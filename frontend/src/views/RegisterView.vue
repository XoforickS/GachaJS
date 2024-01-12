<template>
  <div class="h-screen login-bg py-6">
    <div class="absolute -top-5 left-2">
      <img src="../assets/img/Logo-Wow.png" class="w-1/5" alt="">
    </div>
    <form @submit.prevent="register" class="max-w-xs mx-auto py-3 h-full flex flex-col justify-center">
      <div class="py-8 text-base leading-6 space-y-4 text-gray-700 sm:text-lg sm:leading-7 flex flex-col justify-center">
        <div class="relative">
          <label for="register-username" class="shadow-log text-md flex justify-center mb-1">Surnom</label>
          <input autocomplete="off" id="register-username" name="register-username" type="text" v-model="registerUsername" class="h-10 w-full rounded-lg bg-[#312824] bg-opacity-80 px-2 border-2 border-[#74625c] text-white focus:outline-none" />
        </div>
        <div class="relative">
          <label for="register-email" class="shadow-log text-md flex justify-center mb-1">Email</label>
          <input autocomplete="off" id="register-email" name="register-email" type="text" v-model="registerEmail" class="h-10 w-full rounded-lg bg-[#312824] bg-opacity-80 px-2 border-2 border-[#74625c] text-white focus:outline-none" />
        </div>
        <div class="relative">
          <label for="register-password" class="shadow-log text-md flex justify-center mb-1">Mot de passe</label>
          <input autocomplete="off" id="register-password" name="register-password" type="password" v-model="registerPassword" class="h-10 w-full rounded-lg bg-[#312824] bg-opacity-80 px-2 border-2 border-[#74625c] text-white focus:outline-none" />
        </div>
        <RouterLink class="shadow-log" to="/login">Déjà un compte ? Se connecter ici !</RouterLink>
      </div>
      <div class="mt-32">
        <button type="submit" @click="startAnimationScale()" :class="{ 'transition scale-95 duration-200': scaleAnim, 'transition scale-100 duration-200': !scaleAnim}" class="bg-[#630e03] text-[#bda747] w-full rounded-lg border-2 border-[#40342f] px-2 py-1 scale-100">Inscription</button>
      </div>
    </form>
    <audio autoplay loop>
      <source src="../assets/music/wow-login.mp3" type="audio/mp3">
    </audio>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useAuthStore } from '../stores/auth'

const authStore = useAuthStore()

const registerUsername = ref('');
const registerEmail = ref('');
const registerPassword = ref('');

async function register() {
  await authStore.register(registerUsername.value, registerEmail.value, registerPassword.value);
}
</script>