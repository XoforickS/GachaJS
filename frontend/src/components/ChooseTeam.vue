<template>
    <div class="grid grid-cols-12" style="max-height: 50vh;">
    <div class="col-span-3">
      <ul class="grid grid-cols-2 overflow-y-scroll" style="max-height: 50vh;">
        <li v-for="card in availableCards" :key="card.id">
          <img :src="card.image" @click="addToTeam(card)" :class="{ 'selected-card': card.selected }" class="w-full h-full object-cover scale-100 hover:scale-95 transition ease-in-out duration-500">
        </li>
      </ul>
    </div>
    <div class="col-span-9 w-full">
      <h2 class="text-center text-3xl font-semibold mt-3">Votre équipe</h2>
      <ul class="flex justify-center">
        <li v-for="card in userTeam" :key="card.id">
          <div class="relative">
            <img :src="card.image" alt="">
            <button @click="removeFromTeam(card)" class="absolute top-0 right-0 bg-red-500 px-4 py-2 rounded-lg text-white text-sm">X</button>
          </div>
        </li>
        <div v-if="userTeam.length < 5" class="flex justify-center">
          <img v-for="index in 5 - userTeam.length" :key="index" src="../assets/img/empty_card.png" alt="">
        </div>
      </ul>
    </div>
  </div>
</template>

<script>
import { useAuthStore } from '../stores/auth';

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
  data() {
    return {
      availableCards: [],
      currentUserInfo: [],
      userTeam: [],
      selectedCardIndex: null,
    };
  },
  setup(){
    const authStore = useAuthStore();
    return {authStore}
  },
  async mounted() {      
    await this.loadCurrentUserInfo();
    await this.loadCardData();
    // await this.loadCurrentTeam();
  },
  methods: {
    async loadCurrentUserInfo() {
      try {
        const response = await fetch(`http://localhost:8000/users/${this.authStore.userId}`);
        const responseData = await response.json();

        this.currentUserInfo = new User(responseData.id, responseData.username, responseData.email, responseData.xp, responseData.level, responseData.summon_stone, responseData.coin, responseData.equipment_stone);
      } catch (error) {
        console.error('Error loading user data:', error);
      }
    },
    async loadCardData() {
      try {
        const response = await fetch('http://localhost:8000/cards/');
        const cardData = await response.json();

        this.availableCards = cardData.map(
          (card) => new Card(card.id, card.name, card.image, card.attack, card.defense, card.speed, card.percentage_drop)
        );
      } catch (error) {
        console.error('Error loading card data:', error);
      }
    },
    // async loadCurrentTeam() {
    //   try {
    //     const response = await fetch(`http://localhost:8000/teams/${this.authStore.userId}`);
    //     const currentTeam = await response.json();

    //     this.userTeam = currentTeam.cards.map(
    //       (card) => new Card(card.id, card.name, card.image, card.attack, card.defense, card.speed, card.percentage_drop)
    //     );
    //   } catch (error) {
    //     console.error('Error loading current team data:', error);
    //   }
    // },
    addToTeam(card) {
      if (!card.selected) {
        card.selected = true;

        if (this.userTeam.length < 5) {
          this.userTeam.push(card);
        } else {
          console.warn('You can only have 5 cards in your team.');
        }
      }
    },
    removeFromTeam(card) {
      if (card.selected) {
        card.selected = false;

        this.userTeam = this.userTeam.filter((c) => c.id !== card.id);
      }
    },
    async saveTeam() {
      const cardIds = this.userTeam.map((card) => card.id);

      try {
        const response = await fetch(`http://localhost:8000/teams/add?user_id=${this.currentUserInfo.id}`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(cardIds),
        });

        if (response.ok) {
          const responseData = await response.json();
          console.log('Team saved:', responseData);
        } else {
          console.error('Failed to save team:', response.statusText);
        }
      } catch (error) {
        console.error('Error saving team:', error);
      }
    },
  },
};
</script>

<style scoped>
.selected-card {
  -webkit-filter: grayscale(100%); /* Safari 6.0 - 9.0 */
  filter: grayscale(100%);
}
</style>