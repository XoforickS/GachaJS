<template>
  <div :class="{'main-bg': this.stageFight.stage_id == 1, 'bg-ruin': this.stageFight.stage_id == 2, 'bg-montagne': this.stageFight.stage_id == 3, 'bg-desert': this.stageFight.stage_id == 4, 'bg-port': this.stageFight.stage_id == 5}">
    <div style="min-height: 50vh; max-height: 50vh;">
      <RouterLink to="/map" class="px-4 py-2 text-white rounded-lg bg-black absolute top-2 left-2">
          Retour en arrière
      </Routerlink>
      <div class="text-center py-4 text-3xl font-semibold">Prévisualisation de l'ennemi</div>
      <div class="grid grid-cols-3">
        <div v-for="enemy in stageFight" :key="enemy.id" class="flex justify-center mt-2" >
          <div class="text-center text-white" v-if="enemy.attack !== undefined || enemy.defense !== undefined || enemy.speed !== undefined">
            <img :src="enemy.image" class="w-1/3 mx-auto" alt="">
            <div class="bg-black bg-opacity-80 rounded-b-xl w-1/3 mx-auto">
              <div class="py-2 font-semibold text-lg">{{ enemy.name }}</div> 
              <div class="pb-2">
                {{ enemy.attack }} | {{ enemy.defense }} | {{ enemy.speed }}
              </div>
            </div>
          </div>
        </div>
        
        <router-link :to="currentPath" class="col-start-2 flex justify-center">
          <button @click="startFight" class="bg-blue-500 rounded-lg text-white px-4 py-2 mt-4">
            Lancer le combat!
          </button>
        </router-link>
      </div>
    </div>
    <ChooseTeam class="bg-black bg-opacity-70" />
  </div>
</template>

<script>
import ChooseTeam from '../components/ChooseTeam.vue';
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
  computed: {
    currentPath() {
      return `/fights/${this.$route.params.stageFightId}`;
    }
  }
};
</script>

<style scoped>

.main-bg{
  background-image: url('../assets/img/fight/city.png');
  background-size: cover;
  background-repeat: no-repeat;
}
.bg-ruin{
  background-image: url('../assets/img/fight/ruins.png');
  background-size: cover;
  background-repeat: no-repeat;
}
.bg-montagne{
  background-image: url('../assets/img/fight/vicking-bg.png');
  background-size: cover;
  background-repeat: no-repeat;
}
.bg-desert{
  background-image: url('../assets/img/fight/desert.png');
  background-size: cover;
  background-repeat: no-repeat;
}
.bg-port{
  background-image: url('../assets/img/fight/pirate-bg1.png');
  background-size: cover;
  background-repeat: no-repeat;
}
</style>