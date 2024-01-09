<template>
  <div>
    <div class="bg-gray-200" style="min-height: 50vh; max-height: 50vh;">
      <div class="text-center py-4 text-3xl font-semibold">Prévisualisation de l'ennemi</div>
      <div class="grid grid-cols-3">
        <div v-for="enemy in stageFight" :key="enemy.id" class="flex justify-center mt-2" >
          <div class="text-center" v-if="enemy.attack !== undefined || enemy.defense !== undefined || enemy.speed !== undefined">
            <img :src="enemy.image" alt="">
            <div class="py-2 font-semibold text-lg">{{ enemy.name }}</div> 
            <div>
              {{ enemy.attack }} | {{ enemy.defense }} | {{ enemy.speed }}
            </div>
          </div>
        </div>
        <router-link to="/fights" class="col-start-2 flex justify-center"><button class="bg-blue-500 rounded-lg text-white px-4 py-2 mt-4">Lancer le combat!</button></router-link>
        <!--remettre  @click="startFight" -->
      </div>
    </div>
    <ChooseTeam />
  </div>
</template>

<script>
import ChooseTeam from '../components/ChooseTeam.vue';
import { useRoute } from 'vue-router';
import { useAuthStore } from '../stores/auth';

class User {
  constructor(id, username, email, xp, level, summon_stone, coin, equipment_stone) {
    this.id =  id;
    this.username = username;
    this.email = email;
    this.xp = xp;
    this.level = level;
    this.summon_stone = summon_stone;
    this.coin = coin;
    this.equipment_stone = equipment_stone;
  }
};

export default {
  data () {
    return {
      stageFight: [],
      currentUserInfo: [],
    };
  },
  components: {
    ChooseTeam,
  },
  setup(){
    const authStore = useAuthStore();
    return {authStore}
  },
  async mounted() {
    await this.loadCurrentUserInfo();
    await this.loadStageFight();
  },
  methods: {
    async loadCurrentUserInfo() {
      try {
        const response = await fetch(`http://localhost:8000/users/${this.authStore.userId}`);
        const responseData = await response.json();

        this.currentUserInfo = new User(responseData.id, responseData.username, responseData.email, responseData.xp, responseData.level, responseData.summon_stone, responseData.coin, responseData.equipment_stone, responseData.currentStage);
      } catch (error) {
        console.error('Error loading user data:', error);
      }
    },
    async loadStageFight() {
      try {
        const stageFightId = this.$route.params.stageFightId;
        const response = await fetch(`http://localhost:8000/stage-fights/${stageFightId}`);
        this.stageFight = await response.json();
      } catch (error) {
        console.error('Error loading stage fight data:', error);
      }
    },
    async startFight() {
      try {
        const stageFightId = parseInt(this.$route.params.stageFightId) + 1;
        const userId = this.authStore.userId;

        const response = await fetch(`http://localhost:8000/users/set-current-stage/${userId}?stage_id=${parseInt(stageFightId)}`, {
          method: 'PUT',
        });

        if (response.ok) {
          console.log('User current stage updated successfully');
        } else {
          console.error('Failed to update user current stage:', response.statusText);
        }
      } catch (error) {
        console.error('Error updating user current stage:', error);
      }
    },
  },
};
</script>