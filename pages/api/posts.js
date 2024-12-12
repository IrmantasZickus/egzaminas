import pool from '../../lib/db';

export default async function handler(req, res) {
  if (req.method === 'GET') {
    try {
      const [posts] = await pool.query(`
        SELECT 
          posts.*, 
          (SELECT COUNT(*) FROM likes WHERE likes.post_id = posts.id) AS likes
        FROM posts
      `);

      res.status(200).json(posts);
    } catch (error) {
      console.error('Nepavyko gauti renginių:', error);
      res.status(500).json({ message: 'Nepavyko gauti renginių' });
    }
  } else {
    res.status(405).json({ message: 'Metodas negalimas' });
  }
}
