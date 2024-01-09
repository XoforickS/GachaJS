<template>
  <div class="grid grid-cols-3 items-center text-center h-screen">
    <router-link to="/prepare/1" :class="{ 'bg-gray-200': currentUserInfo.currentStage < 1 }" :disabled="currentUserInfo.currentStage < 1">
        Stage 1-1
    </router-link>
    <router-link to="/prepare/2" :class="{ 'bg-gray-200': currentUserInfo.currentStage < 2 }" :disabled="currentUserInfo.currentStage < 2">
        Stage 1-2
    </router-link>
    <router-link to="/prepare/3" :class="{ 'bg-gray-200': currentUserInfo.currentStage < 3 }" :disabled="currentUserInfo.currentStage < 3">
        Stage 1-3
    </router-link>
    <router-link to="/prepare/4" :class="{ 'bg-gray-200': currentUserInfo.currentStage < 4 }" :disabled="currentUserInfo.currentStage < 4">
        Stage 2-1
    </router-link>
    <router-link to="/prepare/5" :class="{ 'bg-gray-200': currentUserInfo.currentStage < 5 }" :disabled="currentUserInfo.currentStage < 5">
        Stage 2-2
    </router-link>
    <router-link to="/prepare/6" :class="{ 'bg-gray-200': currentUserInfo.currentStage < 6 }" :disabled="currentUserInfo.currentStage < 6">
        Stage 2-3
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