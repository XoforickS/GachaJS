<template>
  <div class="catalogue-bg min-h-screen flex items-end w-full text-center">
    <div class="max-w-7xl mx-auto text-center pt-8 text-white pb-10">
        
      <div class="absolute top-5 right-5 flex items-center space-x-4 text-xl font-semibold tracking-tight text-white">
        <div class="flex bg-gray-900 bg-opacity-40 rounded-full pr-3">
          <img src="../assets/img/equipment_summon.png" class="w-8 h-8 mt-[2px]" />
          <span class="ml-4 mt-1">{{ currentUserInfo.equipment_stone }}</span>
        </div>
        <div class="flex bg-gray-900 bg-opacity-40 rounded-full pr-3">
          <img src="../assets/img/summon-stone.webp" class="w-8 h-8 mt-[2px]" />
          <span class="ml-4 mt-1">{{ currentUserInfo.summon_stone }}</span>
        </div>
        <div class="flex bg-gray-900 bg-opacity-40 rounded-full pr-3">
          <img src="../assets/img/coin.webp" class="w-8 h-8 mt-[2px]" />
          <span class="ml-4 mt-1">{{ currentUserInfo.coin }}</span>
        </div>
      </div>
      <div class="absolute top-5 right-8 flex">
        <RouterLink to="/login" >
          <button class="w-[6vw] h-[8vh] fixed top-[46%] right-[15%]"></button>
        </RouterLink>
        <RouterLink to="/summon" >
          <button class="w-[6vw] h-[10vh] fixed top-[17.5%] right-[46.5%]"></button>
        </RouterLink>
        <RouterLink to="/catalogue" >
            <button class="w-[9vw] h-[23vh] fixed top-[31%] right-[45%] custom-bg"></button>
        </RouterLink>
        <RouterLink to="/map" >
            <button class="w-[50vw] h-[13vh] fixed bottom-[0%] right-[22%]"></button>
        </RouterLink>
      </div>
      <div class="text-white bg-black bg-opacity-80 rounded-xl p-4 absolute w-1/5 text-2xl bottom-3 left-5">
        <div class="text-left flex justify-between mb-1"><div><img src="" class="rounded-full" alt="">{{authStore.username}}</div><div>Nv: {{currentUserInfo.level}}</div></div>
        <div class="flex space-x-2 mb-1">
          <img src="../assets/svg/xp.svg" class="w-4 h-4 mt-2" alt="">
          <div class="h-5 group relative rounded-full w-full bg-neutral-500 mt-1">
            <div class="h-5 rounded-full relative bg-blue-600" :style="{ width: `${currentUserInfo.xp}%` }" :class="{ 'transition-xp': xpBarTransition, 'duration-1000': xpBarTransition }"></div>
            <span class="hidden group-hover:block absolute top-1 left-1/2 -translate-x-1/2 text-xs">{{currentUserInfo.xp}}%</span>
          </div>
        </div>
      </div>
    </div>
    <audio autoplay loop>
      <source src="../assets/music/home.mp3" type="audio/mp3">
    </audio>
  </div>
  
</template>
    
    
<script>  
  import { useAuthStore } from '../stores/auth';
  class User {
    constructor(id, username, email, xp, level, summon_stone, coin, equipment_stone, favorite_card) {
      this.id =  id;
      this.username = username;
      this.email = email;
      this.xp = xp;
      this.level = level;
      this.summon_stone = summon_stone;
      this.coin = coin;
      this.equipment_stone = equipment_stone;
      this.favorite_card = favorite_card;
    }
  };

  class Card {
  constructor(id, name, image, attack, defense, speed, percentage_drop) {
    this.id =  id;
    this.name = name;
    this.image = image;
    this.attack = attack;
    this.defense = defense;
    this.speed = speed;
    this.percentage_drop = percentage_drop
  }
};


  export default {
    data() {
      return {
        currentUserInfo: [],
        currentFavCardInfo: [],
      }
    },
    setup(){
        const authStore = useAuthStore();
        return {authStore}
    },
    async mounted() {
      await this.loadCurrentUserInfo();

    },
    methods: {
      async loadCurrentUserInfo() {
        try {
          const response = await fetch (`http://localhost:8000/users/${this.authStore.userId}`);
          const responseData = await response.json();

          this.currentUserInfo = new User(responseData.id, responseData.username, responseData.email, responseData.xp, responseData.level, responseData.summon_stone, responseData.coin, responseData.equipment_stone, responseData.favorite_card);
          this.loadCurrentFavCardInfo();
        } catch (error) {
          console.error('Error loading user data:', error);
        }
      },
      async loadCurrentFavCardInfo() {
        try {
          const response = await fetch (`http://localhost:8000/cards/${this.currentUserInfo.favorite_card}`);
          const responseData = await response.json();

          this.currentFavCardInfo = new Card(responseData.id, responseData.name, responseData.image, responseData.attack, responseData.defense, responseData.speed, responseData.percentage_drop);
        } catch (error) {
          console.error('Error loading card data:', error);
        }
      },
    },
  }
</script>
    
<style scoped>
@font-face {
  font-family: myFirstFont;
  src: url(../assets/font/RifficFree-Bold.ttf);
}

div {
  font-family: myFirstFont;
}
.catalogue-bg{
  background-attachment: fixed;
  background-image: url('../assets/img/homepage/background.png');
  background-size: cover;
  background-repeat: no-repeat;
}

.custom-bg{
  background-image: url('../assets/img/personnage/napoleon.png');
  background-size: cover;
  background-repeat: no-repeat;
}
</style>