import pool from '../../../lib/db';

export default async function handler(req, res) {
  const { postId } = req.query; 
  const { userId } = req.body;

  if (!postId) {
    return res.status(400).json({ message: 'Post ID būtinas' });
  }

  if (req.method === 'POST') {
    try {
      // pažiūri ar likintas renginys
      const [existingLike] = await pool.query(
        'SELECT * FROM likes WHERE user_id = ? AND post_id = ?',
        [userId, postId]
      );

      if (existingLike.length > 0) {
        // unlike post
        await pool.query('DELETE FROM likes WHERE user_id = ? AND post_id = ?', [userId, postId]);
        await pool.query('UPDATE posts SET likes = likes - 1 WHERE id = ?', [postId]);
        const [likesCount] = await pool.query('SELECT likes FROM posts WHERE id = ?', [postId]);
        return res.status(200).json({ message: 'Patiktukas nuimtas', liked: false, likes: likesCount[0].likes });
      } else {
        // prideti like
        await pool.query('INSERT INTO likes (user_id, post_id) VALUES (?, ?)', [userId, postId]);
        await pool.query('UPDATE posts SET likes = likes + 1 WHERE id = ?', [postId]); 
        const [likesCount] = await pool.query('SELECT likes FROM posts WHERE id = ?', [postId]);
        return res.status(200).json({ message: 'Renginys patiktas', liked: true, likes: likesCount[0].likes });
      }
    } catch (error) {
      console.error('Nepavyko patikti:', error);
      return res.status(500).json({ message: 'Nepavyko patikti', error: error.message });
    }
  } else if (req.method === 'GET') {
    const { userId } = req.query; 
    try {
      // gauti like skaiciu
      const [likesCount] = await pool.query('SELECT likes FROM posts WHERE id = ?', [postId]);

      // paziureti ar vartotojas jau palikines
      const [existingLike] = await pool.query(
        'SELECT * FROM likes WHERE user_id = ? AND post_id = ?',
        [userId, postId]
      );

      return res.status(200).json({
        likes: likesCount[0]?.likes || 0,
        liked: existingLike.length > 0,
      });
    } catch (error) {
      console.error('Nepavyko gauti patiktukų:', error);
      return res.status(500).json({ message: 'Nepavyko gauti patiktukų', error: error.message });
    }
  } else {
    res.status(405).json({ message: 'Metodas negalimas' });
  }
}
