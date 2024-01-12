<template>
  <div class="items-center text-center h-screen custom-bg">
        <div class="absolute z-20 fixed top-[40%] right-[44%] zone">
          Ville
        </div>
      <router-link to="/prepare/1" class="relative custom-1-1" :class="{ 'bg-gray-500 bg-opacity-70': currentUserInfo.currentStage < 1 }" :disabled="currentUserInfo.currentStage < 1"></router-link>
        <div class="absolute z-20 fixed top-[65%] left-[68%] zone">
          Ruines
        </div>
      <router-link to="/prepare/2" class="relative custom-1-2" :class="{ 'bg-gray-500 bg-opacity-70': currentUserInfo.currentStage < 2 }" :disabled="currentUserInfo.currentStage < 2"></router-link>
        <div class="absolute z-20 fixed top-[23%] left-[65%] zone">
          Montagne
        </div>
      <router-link to="/prepare/3" class="custom-1-3" :class="{ 'bg-gray-500  bg-opacity-70': currentUserInfo.currentStage < 3 }" :disabled="currentUserInfo.currentStage < 3"></router-link>
        <div class="absolute z-20 fixed top-[24%] left-[12%] zone">
          <span>Desert</span><span></span>
        </div>
      <router-link to="/prepare/4" class="custom-1-4" :class="{ 'bg-gray-500 bg-opacity-70': currentUserInfo.currentStage < 4 }" :disabled="currentUserInfo.currentStage < 4"></router-link>
        <div class="absolute z-20 fixed top-[66%] left-[17%] zone">
          Port
        </div>
      <router-link to="/prepare/5" class="custom-1-5" :class="{ 'bg-gray-500 bg-opacity-70': currentUserInfo.currentStage < 5 }" :disabled="currentUserInfo.currentStage < 5">
      </router-link>
  </div>
</template>

<script>
import { useAuthStore } from '../stores/auth';

class User {
  constructor(id, username, email, xp, level, summon_stone, coin, equipment_stone, currentStage) {
    this.id =  id;
    this.username = username;
    this.email = email;
    this.xp = xp;
    this.level = level;
    this.summon_stone = summon_stone;
    this.coin = coin;
    this.equipment_stone = equipment_stone;
    this.currentStage = currentStage
  }
};

export default {
  data() {
    return {
      currentUserInfo: [],
    }
  },
  setup(){
    const authStore = useAuthStore();
    return {authStore}
  },
  async mounted (){
    await this.loadCurrentUserInfo();
  },
  methods: {
    async loadCurrentUserInfo() {
      try {
        const response = await fetch(`http://localhost:8000/users/${this.authStore.userId}`);
        const responseData = await response.json();

        this.currentUserInfo = new User(
          responseData.id,
          responseData.username,
          responseData.email,
          responseData.xp,
          responseData.level,
          responseData.summon_stone,
          responseData.coin,
          responseData.equipment_stone,
          responseData.currentStage
        );
         console.log(this.currentUserInfo.currentStage)
      } catch (error) {
        console.error('Error loading user data:', error);
      }
    },
  }
}

</script>

<style scoped>
.custom-bg{
  background-image: url('../assets/img/map/background.png');
  background-size: cover;
  background-repeat: no-repeat;
}
.custom-1-1 {
  width: 450px;
  height: 160px;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%) skew(110deg, 20deg);
  transition: all 0.3s ease-in-out; /* Add transition for all properties */
}

.custom-1-1:hover {
  background: rgba(255, 255, 255, 0.3); /* Use rgba to specify the background color with alpha */
  transform: translate(-50%, -50%) skew(110deg, 20deg) scale(1.1); /* Add scale for a zoom effect */  
  border: white 3px solid;
}

.custom-1-2 {
  width: 373px;
  height: 120px;
  position: absolute;
  top: 66%;
  left: 62%;
  transform: skew(110deg, 20deg);
  transition: all 0.3s ease-in-out; /* Add transition for all properties */
}

.custom-1-2:hover {
  background: rgba(255, 255, 255, 0.3); /* Use rgba to specify the background color with alpha */
  transform: skew(110deg, 20deg) scale(1.1); /* Add scale for a zoom effect */
  border: white 3px solid;
}

.custom-1-3 {
  width: 380px;
  height: 120px;
  position: absolute;
  top: 25%;
  left: 61%;
  transform: skew(110deg, 20deg);
  transition: all 0.3s ease-in-out; /* Add transition for all properties */
}

.custom-1-3:hover {
  background: rgba(255, 255, 255, 0.3);
  transform: skew(110deg, 20deg) scale(1.1); /* Add scale for a zoom effect */
  border: white 3px solid; 
}

.custom-1-4 {
  width: 330px;
  height: 80px;
  position: absolute;
  top: 28%;
  left: 10%;
  transform: skew(110deg, 20deg);
  transition: all 0.3s ease-in-out;
}

.custom-1-4:hover {
  background: rgba(255, 255, 255, 0.3); /* Use rgba to specify the background color with alpha */
  transform: skew(110deg, 20deg) scale(1.1); /* Add scale for a zoom effect */
  border: white 3px solid; 
}

.custom-1-5 {
  width: 350px;
  height: 110px;
  position: absolute;
  top: 68%;
  left: 13%;
  transform: skew(110deg, 20deg);
  transition: all 0.3s ease-in-out; /* Add transition for all properties */
}

.custom-1-5:hover {
  background: rgba(255, 255, 255, 0.3); /* Use rgba to specify the background color with alpha */
  transform: skew(110deg, 20deg) scale(1.1); /* Add scale for a zoom effect */
  border: white 3px solid;
}

@font-face {
  font-family: myFirstFont;
  src: url(../assets/font/ACMountain.otf);
}

.zone {
  font-family: myFirstFont;
  color: rgb(255, 255, 255);
  font-size: 75px;
}
</style>