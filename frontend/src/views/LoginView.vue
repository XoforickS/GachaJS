<template>
  <!-- <div>
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
  </div> -->
  <div class="h-screen login-bg py-6">
    <div class="absolute -top-5 left-2">
      <img src="../assets/img/Logo-Wow.png" class="w-1/5" alt="">
    </div>
    <form @submit.prevent="login" class="max-w-xs mx-auto py-3 h-full flex flex-col justify-center">
      <div class="py-8 text-base leading-6 space-y-4 text-gray-700 sm:text-lg sm:leading-7 flex flex-col justify-center">
        <div class="relative">
          <label for="username" class="shadow-log text-md flex justify-center mb-1">Surnom</label>
          <input autocomplete="off" id="username" name="username" type="text" v-model="loginUsername" class="h-10 w-full rounded-lg bg-[#312824] bg-opacity-80 px-2 border-2 border-[#74625c] text-white focus:outline-none" />
        </div>
        <div class="relative">
          <label for="password" class="shadow-log text-md flex justify-center mb-1">Mot de passe</label>
          <input autocomplete="off" id="password" name="password" type="password" v-model="loginPassword" class="h-10 w-full rounded-lg bg-[#312824] bg-opacity-80 px-2 border-2 border-[#74625c] text-white focus:outline-none" />
        </div>
        <RouterLink class="shadow-log" to="/register">Pas de compte ? S'enregistrer ici !</RouterLink>
      </div>
      <div class="mt-32">
        <button type="submit" @click="startAnimationScale()" :class="{ 'transition scale-95 duration-200': scaleAnim, 'transition scale-100 duration-200': !scaleAnim}" class="bg-[#630e03] text-[#bda747] w-full rounded-lg border-2 border-[#40342f] px-2 py-1 scale-100">Connexion</button>
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

const loginUsername = ref('');
const loginPassword = ref('');

async function login() {
  await authStore.login(loginUsername.value, loginPassword.value);
}
</script>

<script>

export default {
  data() {
    return {
      scaleAnim: false
    }
  },
  methods:{
    startAnimationScale() {
      this.scaleAnim = true

      setTimeout(() => {
        this.scaleAnim = false
      }, 200);
    }
  }
}
</script>


<style>
.login-bg{
  background-image: url('../assets/img/background-login.jpg');
  background-size: cover;
  background-repeat: no-repeat;
}
.shadow-log {
  color: white;
  text-shadow:
   -1px -1px 0 #000,  
    1px -1px 0 #000,
    -1px 1px 0 #000,
     1px 1px 0 #000;
}

</style>