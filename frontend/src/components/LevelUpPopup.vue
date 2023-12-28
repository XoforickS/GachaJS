<template>
  <div v-if="isVisible" class="fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-white p-6 rounded-xl shadow-md z-40">
    <h2 class="text-2xl font-bold mb-4">Niveau supérieur !</h2>
    <p class="text-lg border-b border-gray-400 pb-2">Bravo, tu as atteint un nouveau niveau !</p>
    <div class="pt-4 pb-1 flex justify-center">+ 1 500 <img src="../assets/img/coin.webp" class="w-5 h-5 mt-[2px] ml-2" /></div>
    <div class="pt-2 pb-3 flex justify-center">+ 1 jeton d'equipement <img src="../assets/img/equipment_summon.png" class="w-5 h-5 mt-[2px] ml-2" /></div>
    <button @click="closePopup" class="mt-4 px-8 py-2 bg-green-500 text-white rounded-full">Youpiiiii !</button>
  </div>
</template>

<script>
export default {
  props: {
    isVisible: Boolean,
  },
  methods: {
    closePopup() {
      this.$emit('close');
    },
  },
};
</script>