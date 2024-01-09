<template>
  <div class="catalogue-bg min-h-screen flex items-end w-full text-center">
    <div class="max-w-7xl mx-auto text-center pt-8 text-white pb-10">
      <div class="absolute top-5 right-8 flex">
        <RouterLink to="/catalogue" >
          <button class="w-[6vw] h-[8vh] fixed top-[46%] right-[15%]"></button>
        </RouterLink>
        <RouterLink to="/catalogue" >
          <button class="w-[6vw] h-[10vh] fixed top-[17.5%] right-[46.5%]"></button>
        </RouterLink>
        <RouterLink to="/catalogue" >
            <button class="w-[9vw] h-[23vh] fixed top-[31%] right-[45%] custom-bg"></button>
        </RouterLink>
        <RouterLink to="/catalogue" >
            <button class="w-[50vw] h-[13vh] fixed bottom-[0%] right-[22%]"></button>
        </RouterLink>
      </div>
    </div>
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
      console.log(this.currentUserInfo);

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
          console.log(this.currentFavCardInfo);
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