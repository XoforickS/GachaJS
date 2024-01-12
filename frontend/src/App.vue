<script setup>
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <div>
    <!-- <div class="sidebar bg-[#200E3A] flex flex-col space-y-4 px-4 py-8 items-center font-semibold">
      <div class="h-14 border-b border-gray-400 mb-4">
        LOGO du jeu
      </div>
      <RouterLink to="/login" class="mt-4">About</RouterLink>
      <button class="bg-gray-300 rounded-xl w-24 h-24">
        Acceuil
      </button>
      <button class="bg-gray-300 rounded-xl w-24 h-24">
        <img src="./assets/svg/collection.svg" class="w-1/3 mx-auto pb-1" alt="">
        Collection
      </button>
      <button class="bg-gray-300 rounded-xl w-24 h-24">
        <img src="./assets/svg/summon.svg" class="w-1/2 mx-auto pb-1" alt="">
        Invocation
      </button>
      <button class="bg-gray-300 rounded-xl w-24 h-24">
        <img src="./assets/svg/harvest.svg" class="w-1/2 mx-auto pb-1" alt="">
        Récolte
      </button>
    </div> -->
    <RouterView />
  </div>
</template>