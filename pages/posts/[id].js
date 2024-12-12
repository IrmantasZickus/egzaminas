import { useRouter } from 'next/router';
import { useEffect, useState } from 'react';
import Header from '../../src/components/Header';
import Footer from '../../src/components/Footer';
import styles from './Post.module.css';
import { postCategories } from '../../src/data/postCategories';

export default function PostDetails() {
  const router = useRouter();
  const { id } = router.query;
  const [post, setPost] = useState(null);
  const [likes, setLikes] = useState(0);
  const [liked, setLiked] = useState(false);
  const [user, setUser] = useState(null);
  const [currentImageIndex, setCurrentImageIndex] = useState(0);
  const [isEditing, setIsEditing] = useState(false);
  const [formData, setFormData] = useState({ title: '', category: '', event_time: '', content: '' });

  useEffect(() => {
    const storedUser = localStorage.getItem('user');
    if (storedUser) {
      setUser(JSON.parse(storedUser));
    }
  }, []);

  useEffect(() => {
    if (id && user) {
      const fetchPostAndLikes = async () => {
        try {
          // gauti post details
          const postResponse = await fetch(`/api/posts/${id}`);
          const postData = await postResponse.json();
          setPost(postData);

          // gauti like details
          const likeResponse = await fetch(`/api/posts/like?postId=${id}&userId=${user.id}`);
          const likeData = await likeResponse.json();
          setLikes(likeData.likes);
          setLiked(likeData.liked); // rodo pagal tai ar liked ar ne
        } catch (error) {
          console.error('Nepavyko įkelti patiktukų:', error);
        }
      };

      fetchPostAndLikes();
    }
  }, [id, user]);


  // handlina like/unlike
  const handleLike = async () => {
    if (!user) {
      alert('Turi būti prisijungęs kad galėtum patikti šį renginį.');
      return;
    }

    try {
      const response = await fetch(`/api/posts/like?postId=${id}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ userId: user.id }),
      });
      const data = await response.json();
      setLiked(data.liked); 
      setLikes(data.likes); 
    } catch (error) {
      console.error('Nepavyko togglinti like:', error);
    }
  };


  const handleEditToggle = () => {
    setIsEditing(!isEditing);
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSave = async () => {
    try {
      const response = await fetch(`/api/posts/${id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData),
      });
      if (response.ok) {
        setPost({ ...post, ...formData });
        setIsEditing(false);
        alert('Renginys atnaujintas sėkmingai!');
      } else {
        alert('Nepavyko atnaujinti renginio.');
      }
    } catch (error) {
      console.error('FaNepavyko atnaujinti renginiost:', error);
      alert('Atsitiko error.');
    }
  };

  const handleDelete = async () => {
    if (confirm('Ar tirai norite ištrinti šį renginį?')) {
      try {
        const response = await fetch(`/api/posts/${id}`, { method: 'DELETE' });
        if (response.ok) {
          alert('Renginys ištrintas sėkmingai.');
          router.push('/');
        } else {
          alert('Nepavyko ištrinti renginio ');
        }
      } catch (error) {
        console.error('Nepavyko ištrinti renginio:', error);
        alert('Atsitiko error.');
      }
    }
  };

  if (!post) {
    return <p>Loading...</p>;
  }

  const images = JSON.parse(post.images || '[]');

  return (
    <div style={{ backgroundColor: 'rgba(27, 72, 136, 1)', minHeight: '100vh' }}>
      <Header />
      <div className={styles.postPage}>
        <div className={styles.postContainer}>
          <div className={styles.postContentBox}>
            <div className={styles.postInfoSection}>
              {isEditing ? (
                <input
                  type="text"
                  name="title"
                  value={formData.title}
                  onChange={handleInputChange}
                  className={styles.input}
                />
              ) : (
                <h1>{post.title}</h1>
              )}
              <div className={styles.postInfo}>
                {isEditing ? (
                  <select
                    name="category"
                    value={formData.category}
                    onChange={handleInputChange}
                    className={styles.select}
                  >
                    {postCategories.map((category) => (
                      <option key={category.value} value={category.value}>
                        {category.label}
                      </option>
                    ))}
                  </select>
                ) : (
                  <p><strong>Kategorija:</strong> {post.category}</p>
                )}

                {isEditing ? (
                  <input
                    type="datetime-local"
                    name="event_time"
                    value={formData.event_time}
                    onChange={handleInputChange}
                    className={styles.input}
                  />
                ) : (
                  <p><strong>Renginio data:</strong> {new Date(post.event_time).toLocaleString()}</p>
                )}
                {isEditing ? (
                  <textarea
                    name="content"
                    value={formData.content}
                    onChange={handleInputChange}
                    className={styles.textarea}
                  />
                ) : (
                  <p><strong>Vieta, aprašymas:</strong> {post.content}</p>
                )}
              </div>

            {/* like  */}
            <div className={styles.likeSection}>
              <button onClick={handleLike} className={styles.likeButton}>
                {liked ? 'Unlike' : 'Like'}
              </button>
              <p>{likes} {likes === 1 ? 'Patinka' : 'Nepatinka'}</p>
            </div>
              {/* edit / delete buttonai */}
              {user && user.id === post.user_id && (
                <div className={styles.actions}>
                  <button onClick={handleEditToggle} className={styles.editButton}>
                    {isEditing ? 'Atšaukti' : 'Atnaujinti'}
                  </button>
                  {isEditing && (
                    <button onClick={handleSave} className={styles.saveButton}>
                      Išsaugoti
                    </button>
                  )}
                  <button onClick={handleDelete} className={styles.deleteButton}>
                    Ištrinti
                  </button>
                </div>
              )}
            </div>

            <div className={styles.imageCarousel}>
              {images.length > 0 ? (
                <div className={styles.imageSection}>

                  <img
                    src={images[currentImageIndex]}
                    alt={`Post Image ${currentImageIndex + 1}`}
                    className={styles.postImage}
                  />

                </div>
              ) : (
                <p>Nėra nuotraukų</p>
              )}
            </div>
          </div>
        </div>
      </div>
      <Footer />
    </div>
  );
}
