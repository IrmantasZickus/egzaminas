'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import Header from '../../components/Header';
import Footer from '../../components/Footer';
import styles from '../login/LoginRegister.module.css';

export default function Register() {
  const [formData, setFormData] = useState({ name: '', email: '', password: '' });
  const [message, setMessage] = useState('');
  const router = useRouter();

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setMessage(''); 
  
    try {
      const response = await fetch('/api/register', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData),
      });
  
      const data = await response.json();
      if (response.ok) {
        router.push('/login'); // Redirectina i login puslapi
      } else {
        setMessage(data.message);
      }
    } catch (error) {
      setMessage('Error: ' + error.message);
    }
  };
  
  return (
    <div>
      <Header />

      <div className={styles.formContainer}>
        <div className={styles.formCard}>
          <h1 className={styles.formHeading}>Sukurti paskyrą</h1>
          <form className={styles.form} onSubmit={handleSubmit}>
            <div className={styles.formInput}>
              <span className={styles.formInputIcon}>
                <i className="fa fa-user"></i>
              </span>
              <input
                type="text"
                name="name"
                placeholder="Jūsų vardas"
                value={formData.name}
                onChange={handleChange}
                required
              />
            </div>
            <div className={styles.formInput}>
              <span className={styles.formInputIcon}>
                <i className="fa fa-envelope"></i>
              </span>
              <input
                type="email"
                name="email"
                placeholder="Jūsų email"
                value={formData.email}
                onChange={handleChange}
                required
              />
            </div>
            <div className={styles.formInput}>
              <span className={styles.formInputIcon}>
                <i className="fa fa-lock"></i>
              </span>
              <input
                type="password"
                name="password"
                placeholder="Jūsų slaptažodis"
                value={formData.password}
                onChange={handleChange}
                required
              />
            </div>

            <button type="submit" className={styles.formButton}>
              Registruotis
            </button>
          </form>

          {message && <p className={styles.errorMessage}>{message}</p>}

          <p className={styles.centeredText}>
            Jau turi paskyrą?{' '}
            <a href="/login" className={styles.formLink}>
              Prisijungti čia
            </a>
          </p>
        </div>
      </div>

      <Footer />
    </div>
  );
}
