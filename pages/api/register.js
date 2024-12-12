import bcrypt from 'bcrypt';
import pool from '../../lib/db';

export default async function handler(req, res) {
  if (req.method === 'POST') {
    const { name, email, password } = req.body;

    try {
      // paziuri ar vartotojas egzistuoja
      const [existingUser] = await pool.query('SELECT * FROM users WHERE email = ?', [email]);
      if (existingUser.length > 0) {
        return res.status(400).json({ message: 'Vartotojas jau egzistuoja.' });
      }

      // pw hashinimas
      const hashedPassword = await bcrypt.hash(password, 10); 

      // issaugo vartotoja db
      await pool.query(
        'INSERT INTO users (name, email, password) VALUES (?, ?, ?)',
        [name, email, hashedPassword]
      );

      return res.status(201).json({ message: 'Pavyko registruoti vartotoją.' });
    } catch (error) {
      console.error('Nepavyko priregistruoti vartotojo:', error);
      return res.status(500).json({ message: 'Nepavyko priregistruoti vartotojo.' });
    }
  } else {
    res.status(405).json({ message: 'Metodas negalimas.' });
  }
}
