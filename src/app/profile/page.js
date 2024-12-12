"use client"; 

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import Header from '../../components/Header';
import Footer from '../../components/Footer';
import styles from './Profile.module.css';

export default function Profile() {
  const [user, setUser] = useState(null);
  const router = useRouter();

  useEffect(() => {
    const storedUser = localStorage.getItem('user');
    if (storedUser) {
      const userData = JSON.parse(storedUser);
      setUser(userData);
    } else {
      router.push('/login'); // jei nerastas redirect
    }
  }, [router]);

  const handleLogout = () => {
    localStorage.removeItem('user');
    router.push('/login');
  };

  if (!user) {
    return <p>Kraunama...</p>;
  }

  return (
    <div>
      <Header />
      <div className={styles.profileContainer}>
        <h1>Mano Profilis</h1>
        <div className={styles.profileInfo}>
          <p><strong>Vardas:</strong> {user.name}</p>
          <p><strong>Email:</strong> {user.email}</p>
          <p><strong>Rolė:</strong> {user.role}</p>
        </div>
        <button onClick={handleLogout} className={styles.logoutButton}>Atsijungti</button>
      </div>
      <Footer />
    </div>
  );
}
