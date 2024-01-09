<template>
  <div class="main-bg min-h-screen">
    <h1 class="absolute top-1/2 transform -translate-y-1/2 left-5 text-3xl font-bold text-center text-white bg-black rounded-lg px-5 py-3 -mt-6">Combat Stage 1-1</h1>
    <h1 class="absolute top-1/2 transform -translate-y-1/2 left-1/2 -translate-x-1/2 text-center -mt-6"><img src="../assets/img/attack_icon.webp" class="w-1/2 mx-auto" alt=""></h1>

    <div class="flex justify-center pt-5">
      <div v-for="enemy in stageFight" :key="enemy.id" class="flex justify-center mt-2 bg-white bg-opacity-80 rounded-lg">
        <div class="text-center px-4 py-2" v-if="enemy.attack !== undefined || enemy.defense !== undefined || enemy.speed !== undefined">
          <div class="relative">
            <img :src="enemy.image" alt="">
            <img v-if="hit_marker" @click="attackEnemy(enemy.id, selectedCard)" src="../assets/img/hit.png" class="absolute w-1/2 left-1/2 transform -translate-x-1/2 top-12" alt="">
          </div>
          <div class="py-2 font-semibold text-lg">{{ enemy.name }}</div> 
          <div class="h-5 group relative rounded-full w-full bg-neutral-500 mt-1">
            <div class="h-5 rounded-full relative bg-red-500 transition-defense duration-1000" :style="{ width: `${getEnemyDefense(enemy.id)}%` }"></div>
            <span class="absolute top-0 left-1/2 -translate-x-1/2 text-sm text-white">{{ getEnemyDefense(enemy.id) }}%</span>
          </div>
          <div>
            {{ enemy.attack }} | {{ getEnemyDefense(enemy.id) }} | {{ enemy.speed }}
          </div>
        </div>
      </div>
    </div>

    <ul class="absolute bottom-4 left-1/2 transform -translate-x-1/2 mx-auto flex justify-center w-7/12">
      <li v-for="card in flattenedCurrentTeam" :key="card.id" class="bg-white bg-opacity-80 mx-4 rounded-lg" :class="{ 'attack-animation': cardAttacked === card.id }">
        <div class="relative text-center">
          <img :src="card.image" alt="">
          <div>{{ card.name }}</div>
          <div>{{ card.attack }} / {{ card.defense }} / {{ card.speed }}</div>
          <button class="bg-red-500 px-4 py-1 w-full rounded-b-lg mt-1" @click="hit_marker = !hit_marker, selectCard(card.id)">Attaquer avec</button>
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
      hit_marker: false,
      selectedEnemy: null,
      selectedCard: null,
      cardAttacked: null,
      enemy1Defense: 100,
      enemy2Defense: 100,
      enemy3Defense: 100,
    };
  },
  setup(){
    const authStore = useAuthStore();
    return {authStore}
  },
  async mounted() {
    await this.loadCurrentUserInfo();
    await this.loadCurrentTeam();
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

    selectCard(card) {
      this.selectedCard = card;
    },

    attackEnemy(enemy_id, card_id) {
      console.log(card_id + ' à attaqué, enemie numéro ' + enemy_id);

      let currentDefense;

      switch (enemy_id) {
        case 1:
          currentDefense = this.enemy1Defense;
          break;
        case 2:
          currentDefense = this.enemy2Defense;
          break;
        case 3:
          currentDefense = this.enemy3Defense;
          break;

        default:
          console.error('Invalid enemy_id:', enemy_id);
          return;
      }

      currentDefense = Math.max(currentDefense - 50, 0);

      switch (enemy_id) {
        case 1:
          this.enemy1Defense = currentDefense;
          break;
        case 2:
          this.enemy2Defense = currentDefense;
          break;
        case 3:
          this.enemy3Defense = currentDefense;
          break;
      }

      this.cardAttacked = card_id;

      this.hit_marker = false;

      setTimeout(() => {
        this.cardAttacked = null;
      }, 500);
    },
    getEnemyDefense(enemyId) {
      switch (enemyId) {
        case 1:
          return this.enemy1Defense;
        case 2:
          return this.enemy2Defense;
        case 3:
          return this.enemy3Defense;

        default:
          console.error('Invalid enemyId:', enemyId);
          return 0;
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

<style scoped>
.main-bg{
  background-image: url('../assets/img/board_fight.png');
  background-size: cover;
  background-repeat: no-repeat;
}
.transition-defense {
  transition: width 1s ease;
}

.duration-1000 {
  transition-duration: 2000ms;
}
.attack-animation {
  transform: scale(1.2) translateY(-40px);
  transition: transform 0.5s ease-in-out;
}
</style>