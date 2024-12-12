import formidable from 'formidable';
import fs from 'fs';
import path from 'path';
import pool from '../../lib/db';

export const config = {
  api: {
    bodyParser: false, 
  },
};

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ message: 'Metodas negalimas' });
  }

  const form = formidable({
    uploadDir: path.join(process.cwd(), 'public/uploads'), // nustatom upload vieta
    keepExtensions: true, // leidzia daug fileu
    multiples: true, // leisti keleta failu
  });

  const uploadDir = path.join(process.cwd(), 'public/uploads');
  if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir, { recursive: true });
  }

  form.parse(req, async (err, fields, files) => {
    if (err) {
      console.error('Nepavyko parsinti formos:', err);
      return res.status(500).json({ message: 'Nepavyko parsinti formos', error: err.message });
    }

    console.log('Fields:', fields);
    console.log('Files:', files);

    const { title, content, category, event_time, userId } = fields;

    
    if (!title || !content || !category || !event_time || !userId) {
      return res.status(400).json({ message: 'Trūksta reikiamų laukų' });
    }

    // file uploadai
    const uploadedFiles = [];
    for (const key in files) {
      if (key.startsWith('images')) {
        const fileArray = Array.isArray(files[key]) ? files[key] : [files[key]];
        fileArray.forEach((file) => {
          const newFileName = `${Date.now()}_${file.originalFilename}`;
          const newPath = path.join(uploadDir, newFileName);

          try {
            fs.renameSync(file.filepath, newPath); // nusiuncia faila i upload
            uploadedFiles.push(`/uploads/${newFileName}`); // issaugo path
          } catch (error) {
            console.error('Nepavyko pamovinti file:', error);
          }
        });
      }
    }

    console.log('Įkelti failus:', uploadedFiles);

    // issaugoti postus ir nuotraukas db
    try {
      const query = `
        INSERT INTO posts (title, content, category, event_time, user_id, images)
        VALUES (?, ?, ?, ?, ?, ?)
      `;
      const values = [
        title[0],
        content[0],
        category[0],
        new Date(event_time[0]),
        userId[0],
        JSON.stringify(uploadedFiles), 
      ];

      const [result] = await pool.query(query, values);
      return res.status(200).json({ message: 'Renginys sukurtas sėkmingai', postId: result.insertId });
    } catch (dbError) {
      console.error('Duomenų bazės error:', dbError);
      return res.status(500).json({ message: 'Duomenų bazės error', error: dbError.message });
    }
  });
};