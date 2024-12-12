import pool from '../../../lib/db';

export default async function handler(req, res) {
  const { id } = req.query;

  if (req.method === 'GET') {
    try {
      const [result] = await pool.query(`
        SELECT 
          posts.*
        FROM 
          posts
        WHERE 
          posts.id = ?
      `, [id]);

      if (!result || result.length === 0) {
        return res.status(404).json({ message: 'Renginys nerastas.' });
      }

      return res.status(200).json(result[0]);
    } catch (error) {
      console.error('Nepavyko gauti renginio informacijos:', error);
      return res.status(500).json({ message: 'Nepavyko gauti renginio informacijos.', error: error.message });
    }
  } else if (req.method === 'PUT') {
    const { title, content, category, event_time } = req.body;

    if (!title || !content || !category || !event_time) {
      return res.status(400).json({ message: 'All fields (title, content, category, event time) are required.' });
    }

    try {
      const result = await pool.query(
        'UPDATE posts SET title = ?, content = ?, category = ?, event_time = ? WHERE id = ?',
        [title, content, category, event_time, id]
      );

      if (result.affectedRows === 0) {
        return res.status(404).json({ message: 'Renginys nerastas.' });
      }

      return res.status(200).json({ message: 'Renginys atnaujintas sėkmingai.' });
    } catch (error) {
      return res.status(500).json({ message: 'Nepavyko atnaujinto renginio.', error: error.message });
    }
  } else if (req.method === 'DELETE') {
    try {
      const result = await pool.query('DELETE FROM posts WHERE id = ?', [id]);

      if (result.affectedRows === 0) {
        return res.status(404).json({ message: 'Renginys nerastas.' });
      }

      return res.status(200).json({ message: 'Renginys sėkmingai ištrintas.' });
    } catch (error) {
      return res.status(500).json({ message: 'Nepavyko ištrinti renginio.', error: error.message });
    }
  } else {
    res.status(405).json({ message: 'Metodas negalimas.' });
  }
}
