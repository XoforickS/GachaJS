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
        
        setTimeout(() => {
          router.push('/')
        }, 400);
      } else {
        console.error('Login failed:', data.detail);
      }
    } catch (error) {
      console.error('Error during login request:', error);
    }
  }

  async function register(registerUsername, registerEmail, registerPassword) {
    try {
      const response = await fetch(`http://localhost:8000/register/?username=${registerUsername}&email=${registerEmail}&password=${registerPassword}&`, {
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

        router.push('/login');
      } else {
        console.error('Registration failed:', data.detail);
      }
    } catch (error) {
      console.error('Error during registration request:', error);
    }
  }

  async function logout() {
    try{
      console.log('LOGOUT INSIDE')
      userId.value = null;
      username.value = '';
      email.value = '';
  
      localStorage.removeItem('userId');
      localStorage.removeItem('username');
      localStorage.removeItem('email');
    
      router.push('/login');
    } catch (error){
      console.error('Error during logout request:', error);
    }
  }

  return { userId, username, email, login, logout, register };
});
