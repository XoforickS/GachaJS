<template>
  <div>
    <h1 class="text-2xl">Combat Stage 1-1</h1>

    <h2>Enemies</h2>
    <!-- <ul class="flex justify-center">
      <li v-for="enemy in stageFight" :key="enemy.id">
        <div class="relative">
          <img :src="enemy.image" alt="">
        </div>
      </li>
    </ul> -->
    <h2>Your Team</h2>
    <ul class="flex justify-center">
      <li v-for="card in flattenedCurrentTeam" :key="card.id">
        <div class="relative">
          <img :src="card.image" alt="">
          <div>{{ card.name }} - {{ card.attack }} / {{ card.defense }} / {{ card.speed }}</div>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
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

class Card {
  constructor(id, name, image, attack, defense, speed, percentage_drop) {
    this.id = id;
    this.name = name;
    this.image = image;
    this.attack = attack;
    this.defense = defense;
    this.speed = speed;
    this.percentage_drop = percentage_drop;
  }
}

export default {
  data() {
    return {
      currentTeam: {},
      stageFight: [],
      currentUserInfo: [],
    };
  },
  setup(){
    const authStore = useAuthStore();
    return {authStore}
  },
  async mounted() {
    await this.loadCurrentUserInfo();
    await this.loadCurrentTeam();
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
    async loadCurrentTeam() {
      try {
        const response = await fetch(`http://localhost:8000/teams/${this.authStore.userId}`);
        this.currentTeam = await response.json();
      } catch (error) {
        console.error('Error loading current team data:', error);
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
  },
  computed: {
    flattenedCurrentTeam() {
      const flattenedTeam = [];
      for (let i = 1; i <= 5; i++) {
        const cardKey = `card${i}`;
        if (this.currentTeam[cardKey]) {
          flattenedTeam.push({
            ...this.currentTeam[cardKey],
            id: this.currentTeam[`${cardKey}_id`],
          });
        }
      }
      return flattenedTeam;
    },
  },
};
</script>
