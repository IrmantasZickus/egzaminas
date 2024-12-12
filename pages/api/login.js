import bcrypt from 'bcrypt';
import pool from '../../lib/db';

export default async function handler(req, res) {
  if (req.method === 'POST') {
    const { email, password } = req.body;

    try {
      // suranda pagal email
      const [user] = await pool.query('SELECT * FROM users WHERE email = ?', [email]);

      if (user.length === 0) {
        return res.status(401).json({ message: 'Invalid email or password.' });
      }

      const validPassword = await bcrypt.compare(password, user[0].password);

      if (!validPassword) {
        return res.status(401).json({ message: 'Neteisingas slaptažodis arba email.' });
      }

      return res.status(200).json({
        id: user[0].id,
        name: user[0].name,
        email: user[0].email,
        role: user[0].role,
      });
    } catch (error) {
      console.error('Erroras prisijungiant:', error);
      return res.status(500).json({ message: 'Erroras prisijungiant.' });
    }
  } else {
    res.status(405).json({ message: 'Metodas negalimas.' });
  }
}