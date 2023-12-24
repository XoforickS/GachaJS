// auth.js
import { ref } from 'vue'
import { defineStore } from 'pinia'
import router from '../router'

export const useAuthStore = defineStore('auth', () => {
  const userId = ref(localStorage.getItem('userId') || null);
  const username = ref(localStorage.getItem('username') || '');
  const email = ref(localStorage.getItem('email') || '');

  async function login(loginUsername, loginPassword) {
    try {
      const response = await fetch(`http://localhost:8000/login/?username=${loginUsername}&password=${loginPassword}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
      });
  
      const data = await response.json();
  
      if (response.ok) {
        userId.value = data.user_id;
        username.value = data.username;
        email.value = data.email;
  
        localStorage.setItem('userId', data.user_id);
        localStorage.setItem('username', data.username);
        localStorage.setItem('email', data.email);

        router.push('/')
      } else {
        console.error('Login failed:', data.detail);
      }
    } catch (error) {
      console.error('Error during login request:', error);
    }
  }

  return { userId, username, email, login };
});
