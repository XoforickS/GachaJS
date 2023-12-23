<template>
  <div>
    <div class="bg-gray-400 h-screen">
      <h1>Login</h1>
      <form @submit.prevent="login">
        <label for="username">Username:</label>
        <input type="text" v-model="loginUsername" required />
        <br />
        <label for="password">Password:</label>
        <input type="password" v-model="loginPassword" required />
        <br />
        <button type="submit">Login</button>
      </form>
    </div>
  </div>
</template>
<script setup>
import { ref } from 'vue'
import { useAuthStore } from '../stores/auth'

const authStore = useAuthStore()

const loginUsername = ref('');
const loginPassword = ref('');

async function login() {
  await authStore.login(loginUsername.value, loginPassword.value);

  console.log('User ID:', authStore.userId);
  console.log('Username:', authStore.username);
  console.log('Email:', authStore.email);
}
</script>
