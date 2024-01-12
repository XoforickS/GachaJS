<template>
  <div class="main-bg min-h-screen">
    <h1 class="absolute top-1/2 transform -translate-y-1/2 left-5 text-3xl font-bold text-center text-white bg-black rounded-lg px-5 py-3 -mt-6">Combat Stage 1-1</h1>
    <h1 class="absolute top-1/2 transform -translate-y-1/2 left-1/2 -translate-x-1/2 text-center -mt-6 font-semibold">
      <img src="../assets/img/attack_icon.webp" class="w-1/3 mx-auto -mt-8" alt="">
      <div v-if="isPlayerTurn">Votre Tour !</div><div v-if="!isPlayerTurn">Au tour de l'ennemie</div>
    </h1>

    <div class="flex justify-center pt-5">
      <div v-for="(enemy, index) in stageFight" :key="enemy.id" class="flex justify-center mt-2 bg-white bg-opacity-80 rounded-lg" :class="{ 'attack-animation-enemy': enemyAttack == enemy.id }">
        <div :class="{'dead-card': getEnemyDefense(index, enemy.defense, 1) === 0}" class="text-center px-4 py-2" v-if="enemy.attack !== undefined || enemy.defense !== undefined || enemy.speed !== undefined">
          <div class="relative">
            <img :src="enemy.image" alt="">
            <img v-if="hit_marker && getEnemyDefense(index, enemy.defense, 1) !== 0 " @click="attackEnemy(index, selectedCard, realSelectedId, enemy.attack)" src="../assets/img/hit.png" class="absolute w-1/2 left-1/2 transform -translate-x-1/2 top-12" alt="">
          </div>
          <div class="py-2 font-semibold text-lg">{{ enemy.name }}</div> 
          <div class="h-5 group relative rounded-full w-full bg-neutral-500 mt-1">
            <div class="h-5 rounded-full relative bg-red-500 transition-defense duration-1000" :style="{ width: `${getEnemyDefense(index, enemy.defense, 0)}%` }"></div>
            <span class="absolute top-0 left-1/2 -translate-x-1/2 text-sm text-white">{{ getEnemyDefense(index, enemy.defense, 1) }} / {{ enemy.defense }}</span>
          </div>
          <div>
            {{ enemy.attack }} | {{ enemy.defense }} | {{ enemy.speed }}
          </div>
        </div>
      </div>
    </div>

    <ul class="absolute bottom-4 left-1/2 transform -translate-x-1/2 mx-auto flex justify-center w-7/12">
      <li v-for="(card, index) in flattenedCurrentTeam" :key="card.id" class="bg-white bg-opacity-80 mx-4 rounded-lg" :class="{ 'attack-animation': cardAttacked == index + 1, 'ouch-animation': alliedAttacked == index + 1 }">
        <div :class="{'dead-card': getCardDefense(index + 1, card.defense, 1) === 0}" class="relative text-center">
          <img :src="card.image" alt="">
          <div>{{ card.name }}</div>
          <div>{{ card.attack }} / {{ card.defense }} / {{ card.speed }}</div>
          <div class="h-8 group relative rounded-full w-full bg-neutral-500 mt-1">
            <div class="h-8 rounded-full relative bg-blue-500 transition-defense duration-1000" :style="{ width: `${getCardDefense(index + 1, card.defense, 0)}%` }"></div>
            <span class="absolute top-0 left-1/2 -translate-x-1/2 text-lg text-white">{{ getCardDefense(index + 1, card.defense, 1) }} / {{ card.defense }}</span>
          </div>
          <button v-if="isPlayerTurn && getCardDefense(index + 1, card.defense, 1) !== 0" class="w-1/3 absolute -top-5 -right-5" @click="hit_marker = !hit_marker, selectCard(index + 1, card.id)"><img src="../assets/img/attack_icon.png" alt=""></button>
        </div>
      </li>
    </ul>
    <div v-if="enemy1Defense === 0 && enemy2Defense === 0 && enemy3Defense === 0" class="fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 text-xl font-semibold bg-white rounded-xl shadow-md z-40">
      <span class="text-2xl font-semibold bg-green-300 p-6 rounded-t-xl">Bien joué ! Tu as complété le Stage {{ this.stageFight.stage_id }} - {{ this.stageFight.fight_number }}</span>
      <div class="text-center mt-8">Voici tes récompense :</div>
      <div>
        <div class="pt-4 pb-1 flex justify-center">+ 1 000 <img src="../assets/img/coin.webp" class="w-5 h-5 mt-[2px] ml-2" /></div>
        <div class="pt-2 pb-3 flex justify-center">+ 1 jeton d'equipement <img src="../assets/img/equipment_summon.png" class="w-5 h-5 mt-[2px] ml-2" /></div>
      </div>
      <div class="p-6 flex justify-center space-x-4 text-white">
        <router-link to="/" class="bg-gray-500 px-4 py-2 rounded-lg">Retour au menu</router-link>
        <router-link :to="dynamicRoute" class="bg-green-500 px-4 py-2 rounded-lg">Niveau suivant !</router-link>
      </div>
    </div>
  </div>

  <audio autoplay loop>
    <source src="../assets/music/city.mp3" type="audio/mp3">
  </audio>

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
      realSelectedId: null,
      selectedAttackedCard: null,
      cardAttacked: null,
      enemyAttack: null,
      alliedAttacked: null,
      cardDamageTaken: null,
      enemy1Defense: 1,
      enemy2Defense: 1,
      enemy3Defense: 1,
      card1Defense: 1,
      card2Defense: 1,
      card3Defense: 1,
      card4Defense: 1,
      card5Defense: 1,
      isPlayerTurn: true,
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
        this.card1Defense = this.currentTeam.card1.defense
        this.card2Defense = this.currentTeam.card2.defense
        this.card3Defense = this.currentTeam.card3.defense
        this.card4Defense = this.currentTeam.card4.defense
        this.card5Defense = this.currentTeam.card5.defense
      } catch (error) {
        console.error('Error loading current team data:', error);
      }
    },

    async loadStageFight() {
      try {
        const stageFightId = this.$route.params.stageFightId;
        const response = await fetch(`http://localhost:8000/stage-fights/${stageFightId}`);
        this.stageFight = await response.json();
        this.enemy1Defense = this.stageFight.enemy1.defense
        this.enemy2Defense = this.stageFight.enemy2.defense
        this.enemy3Defense = this.stageFight.enemy3.defense
      } catch (error) {
        console.error('Error loading stage fight data:', error);
      }
    },

    startPlayerTurn() {
      this.isPlayerTurn = true;
    },

    startEnemyTurn(DamageNumber) {
      this.isPlayerTurn = false;

      this.enemyTurn(DamageNumber);
    },

    randomEnemyCard() {    
      const randomEnemyId = Math.floor(Math.random() * 3) + 1;
      this.selectedAttackedCard = this.getRandomAliveCard();
      this.selectEnemy(randomEnemyId, this.selectedAttackedCard);
    },
    
    selectEnemy(enemy, card_team) {
      this.selectedEnemy = enemy;
      this.selectedAttackedCard = card_team
    },

    getRandomAliveCard() {
      const aliveCards = this.flattenedCurrentTeam.filter(card => card.defense > 0);
      if (aliveCards.length === 0) {
        return null;
      }

      const randomIndex = Math.floor(Math.random() * aliveCards.length);
      return aliveCards[randomIndex].id;
    },

    enemyTurn(DamageNumber) {
      this.randomEnemyCard();
      
      if (this.selectedAttackedCard !== null) {
        this.attackCard(this.selectedEnemy, this.selectedAttackedCard, DamageNumber);
      }

      this.startPlayerTurn();
    },

    selectCard(card, realId) {
      this.selectedCard = card;
      this.realSelectedId = realId;
    },

    attackCard(enemy_id, card_id, DamageNumber) {
      
      console.log(enemy_id + ' à attaqué, allié numéro ' + card_id);

      let currentDefense;

      switch (card_id) {
        case 1:
          currentDefense = this.card1Defense;
          break;
        case 2:
          currentDefense = this.card2Defense;
          break;
        case 3:
          currentDefense = this.card3Defense;
          break;
        case 4:
          currentDefense = this.card4Defense;
          break;
        case 5:
          currentDefense = this.card5Defense;
          break;

        default:
          console.error('Invalid enemy_id:', enemy_id);
          return;
      }
      const damage = Math.max(DamageNumber, 0);

      currentDefense = Math.max(currentDefense - damage, 0);

      switch (card_id) {
        case 1:
          this.card1Defense = currentDefense;
          break;
        case 2:
          this.card2Defense = currentDefense;
          break;
        case 3:
          this.card3Defense = currentDefense;
          break;
        case 4:
          this.card4Defense = currentDefense;
          break;
        case 5:
          this.card5Defense = currentDefense;
          break;
      }

      this.enemyAttack = enemy_id;
      this.alliedAttacked = card_id;

      console.log(this.enemyAttack, this.alliedAttacked)

      if (!this.isPlayerTurn) {
        setTimeout(() => {
          this.startPlayerTurn();
        }, 2000);
      }

      setTimeout(() => {
        this.enemyAttack = null;
        this.alliedAttacked = null;
      }, 500);
    },

    attackEnemy(enemy_id, card_id, realCardId, DamageNumber) {
      console.log(card_id + ' à attaqué, enemie numéro ' + enemy_id);

      let currentDefense;
      let attackingCard;

      this.flattenedCurrentTeam.forEach(card => {
        if (card.id === realCardId) {
          attackingCard = card;
        }
      });

      if (!attackingCard) {
        console.error('Selected card not found:', card_id);
        return;
      }

      switch (enemy_id) {
        case 'enemy1':
          currentDefense = this.enemy1Defense;
          break;
        case 'enemy2':
          currentDefense = this.enemy2Defense;
          break;
        case 'enemy3':
          currentDefense = this.enemy3Defense;
          break;
        default:
          console.error('Invalid enemy_id:', enemy_id);
          return;
      }

      const damage = Math.max(attackingCard.attack, 0);

      currentDefense = Math.max(currentDefense - damage, 0);

      switch (enemy_id) {
        case 'enemy1':
          this.enemy1Defense = currentDefense;
          break;
        case 'enemy2':
          this.enemy2Defense = currentDefense;
          break;
        case 'enemy3':
          this.enemy3Defense = currentDefense;
          break;
      }

      this.cardAttacked = card_id;

      this.hit_marker = false;

      if (this.isPlayerTurn) {
        setTimeout(() => {
          this.startEnemyTurn(DamageNumber);
        }, 1000);
      } else {
        setTimeout(() => {
          this.startPlayerTurn();
        }, 1000);
      }

      setTimeout(() => {
        this.cardAttacked = null;
      }, 500);
    },

    getEnemyDefense(enemyId, enemyDefense, is_pourcentage) {
      if (is_pourcentage == 0) {
        switch (enemyId) {
          case 'enemy1':
            return ((this.enemy1Defense / enemyDefense) * 100).toFixed(0);
          case 'enemy2':
            return ((this.enemy2Defense / enemyDefense) * 100).toFixed(0);
          case 'enemy3':
            return ((this.enemy3Defense / enemyDefense) * 100).toFixed(0);
          default:
            console.error('Invalid enemyId:', enemyId);
            return 0;
        }
      } else {
        switch (enemyId) {
          case 'enemy1':
            return this.enemy1Defense;
          case 'enemy2':
            return this.enemy2Defense;
          case 'enemy3':
            return this.enemy3Defense;
          default:
            console.error('Invalid enemyId:', enemyId);
            return 0;
        }
      }
    },

    getCardDefense(cardId, cardDefense, is_pourcentage) {
      if (is_pourcentage == 0) {
        switch (cardId) {
          case 1:
            return ((this.card1Defense / cardDefense) * 100).toFixed(0);
          case 2:
            return ((this.card2Defense / cardDefense) * 100).toFixed(0);
          case 3:
            return ((this.card3Defense / cardDefense) * 100).toFixed(0);
          case 4:
            return ((this.card4Defense / cardDefense) * 100).toFixed(0);
          case 5:
            return ((this.card5Defense / cardDefense) * 100).toFixed(0);
          default:
            console.error('Invalid cardId:', cardId);
            return 0;
        }
      } else {
        switch (cardId) {
          case 1:
            return this.card1Defense;
          case 2:
            return this.card2Defense;
          case 3:
            return this.card3Defense;
          case 4:
            return this.card4Defense;
          case 5:
            return this.card5Defense;
          default:
            console.error('Invalid cardId:', cardId);
            return 0;
        }
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
    
    dynamicRoute() {
      return `/prepare/${this.stageFight.fight_number + 1}`;
    }
  },
};
</script>

<style scoped>
.main-bg{
  background-image: url('../assets/img/fight/city.png');
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
  transform: translateY(-50px);
  transition: transform 0.5s ease-in-out;
}
.attack-animation-enemy {
  transform: translateY(50px);
  transition: transform 0.5s ease-in-out;
}
.ouch-animation {
  transform: scale(0.8);
  transition: transform 1s ease-in-out;
}

.dead-card {
  -webkit-filter: grayscale(100%);
  filter: grayscale(100%);
}
</style>