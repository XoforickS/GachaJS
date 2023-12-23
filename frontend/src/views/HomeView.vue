<template>
  <div class="main-bg h-screen bg-no-repeat bg-cover w-full overflow-hidden">
    <div class="absolute right-0 left-0 bottom-0">
      <div class="flex justify-center items-end mt-2">
        <img
          id="leftImage"
          src="../assets/img/Left.png"
          :class="{ 'transition mr-0': SummonAnim, 'duration-1000': SummonAnim }"
          class="mr-52"
          alt=""
        />
        <img
          id="rightImage"
          src="../assets/img/Right.png"
          :class="{ 'transition ml-0': SummonAnim, 'duration-1000': SummonAnim }"
          class="ml-52"
          alt=""
        />
      </div>
    </div>
    <nav class="sticky top-0 z-10 w-full px-4 py-1">
      <div class="flex justify-end p-4">
        <div class="absolute top-3 left-5">
          <img src="../assets/img/gachatec_logo.png" class="w-2/3" alt="">
        </div>
        <div class="flex items-center space-x-4 text-lg font-semibold tracking-tight text-white">
          <button class="ml-2 bg-gray-400 hover:bg-gray-500 text-white font-bold py-1 px-2 rounded transition ease-in-out" @click="increaseSummonStones">
            +1
          </button>
          <div class="flex bg-gray-200 bg-opacity-30 rounded-full pr-3">
            <img src="../assets/img/summon-stone.webp" class="w-6 h-6 mt-[2px]" />
            <span class="ml-4">{{ summonStones }}</span>
          </div>
          <div class="flex bg-gray-200 bg-opacity-30 rounded-full pr-3">
            <img src="../assets/img/coin.webp" class="w-6 h-6 mt-[2px]" />
            <span class="ml-4">61 000</span>
          </div>
          <div class="bg-gray-200 bg-opacity-30 rounded-full px-4">
            <button class="pr-3">
              <img src="../assets/svg/collection.svg" class="w-6 h-6 mx-auto pt-1" alt="">
            </button>
            <button class="pr-3">
              <img src="../assets/svg/summon.svg" class="w-6 h-6 mx-auto" alt="">
            </button>
            <button class="pr-3">
              <img src="../assets/svg/harvest.svg" class="w-6 h-6 mx-auto" alt="">
            </button>
          </div>
        </div>
      </div>
    </nav>
    <div class="max-w-7xl mx-auto text-center">
      <div class="absolute bottom-4 right-0 left-0 w-1/3 mx-auto grid grid-cols-2 font-semibold text-2xl justify-center gap-4">
        <button id="summonButton" class="bg-white hover:bg-gray-200 cursor-pointer pt-1 pl-6 pr-1 rounded-full transition ease-in-out flex justify-between" @click="startAnimation" :disabled="summonStones === 0">
          <span class="pt-2">Invocation</span> <span class="flex bg-gray-700 rounded-full px-4 py-2 mb-1 text-white"><img src="../assets/img/summon-stone.webp" class="w-6 h-6 mt-[2px] mr-2" />1</span>
        </button>
        <button id="summonMultiButton" class="bg-white hover:bg-gray-200 cursor-pointer pt-1 pl-6 pr-1 rounded-full transition ease-in-out flex justify-between" @click="summonMulti(10)" :disabled="summonStones < 10">
          <span class="pt-2">Multi-Invocation</span> <span class="flex bg-gray-700 rounded-full px-4 py-2 mb-1 text-white"><img src="../assets/img/summon-stone.webp" class="w-7 h-7 mt-[2px] mr-2" />10</span>
        </button>
      </div>
      <div v-if="account != 0" id="summonedCardDisplay" class="mt-2 grid grid-cols-5 gap-4 bg-black opacity-75 px-8 py-4 -mt-4 text-white">
        <div
          v-for="(card, index) in account"
          :key="index"
          class="flex flex-col items-center"
        >
          <img
            :src="card.image"
            :alt="card.name"
            class="w-full h-full object-cover mb-2"
          />
          <p>{{ card.name }}</p>
          <div class="hidden flex space-x-2">
            <p>Attack: {{ card.attack }}</p>
            <p>Defense: {{ card.defense }}</p>
            <p>Speed: {{ card.speed }}</p>
          </div>
        </div>
      </div>
      <div id="loadingIndicator" ref="loadingIndicator" class="hidden mt-4">
        Invocation en cours...
      </div>
      <div class="text-white bg-black bg-opacity-80 rounded-xl p-4 absolute w-1/5 text-2xl bottom-3 left-5">
        <div class="text-left flex justify-between mb-1"><div><img src="" class="rounded-full" alt="">{{authStore.username}}</div><div>Lvl: 21</div></div>
        <div class="flex space-x-2 mb-1">
          <img src="../assets/svg/xp.svg" class="w-4 h-4" alt="">
          <div class="h-3 rounded-full w-full bg-neutral-500 mt-1">
            <div class="h-3 rounded-full bg-blue-600" style="width: 35%"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { useAuthStore } from '../stores/auth';

const authStore = useAuthStore();

</script>

<script>
import { ref } from 'vue';

class Card {
  constructor(id, name, image, attack, defense, speed) {
    this.id =  id;
    this.name = name;
    this.image = image;
    this.attack = attack;
    this.defense = defense;
    this.speed = speed;
  }
}

export default {
  data() {
    return {
      SummonAnim: false,
      availableCards: [],
      account: [],
      loadingIndicator: null,
      summonStones: 0,
    };
  },
  mounted() {
    this.loadingIndicator = this.$refs.loadingIndicator;
    this.loadCardData().then(() => {
      this.setupEventListeners();
    });
  },
  methods: {
    async loadCardData() {
      try {
        const response = await fetch('http://localhost:8000/cards/');
        const cardData = await response.json();

        this.availableCards = cardData.map(
          (card) => new Card(card.id, card.name, card.image, card.attack, card.defense, card.speed)
        );
      } catch (error) {
        console.error('Error loading card data:', error);
      }
    },

    async summon() {
      if (this.availableCards.length === 0 || this.summonStones === 0) {
        console.log('Pas de carte disponible à invoquer.');
        return;
      }

      this.showLoading();

      const randomIndex = Math.floor(
        Math.random() * this.availableCards.length
      );
      const summonedCard = this.availableCards[randomIndex];

      this.account.push(summonedCard);
      console.log(summonedCard)
      this.summonStones--;

      // try {
      //   console.log('Je rentre in the function')
      //   const response = await fetch('http://localhost:8000/account_cards/add', {
      //     method: 'POST',
      //     headers: {
      //       'Content-Type': 'application/json',
      //     },
      //     body: JSON.stringify({
      //       user_id: this.authStore.userId,
      //       card_id: summonedCard.id,
      //     }),
      //   });

      //   const data = await response.json();

      //   if (!response.ok) {
      //     console.error('Failed to add the summoned card to the database:', data.detail);
      //   }
      // } catch (error) {
      //   console.error('Error during the fetch request:', error);
      // }

      setTimeout(() => {
        this.hideLoading();
      }, 1000);
    },

    summonMulti(count) {
      if (this.availableCards.length === 0 || this.summonStones < count) {
        console.log('Pas assez de pierres pour invoquer!');
        return;
      }

      this.showLoading();

      for (let i = 0; i < count; i++) {
        this.summon();
      }

      this.summonStones - 10;

      setTimeout(() => {
        this.hideLoading();
      }, 1000);
    },

    showLoading() {
      this.loadingIndicator.classList.remove('hidden');
    },

    hideLoading() {
      this.loadingIndicator.classList.add('hidden');
    },

    increaseSummonStones() {
      this.summonStones++;
    },

    startAnimation() {
      for (let i = 0; i < 2; i++) {
        setTimeout(() => {
          this.SummonAnim = true;
          setTimeout(() => {
            this.SummonAnim = false;
          }, 1000);
        }, i * 2000);
      }
      setTimeout(() => {
        this.SummonAnim = true;
        setTimeout(() => {
          this.summon();
        }, 1500);
      }, 4000);
    }
  },
};
</script>

<style scoped>
@font-face {
  font-family: myFirstFont;
  src: url(../assets/font/RifficFree-Bold.ttf);
}

div {
  font-family: myFirstFont;
}

.main-bg{
  background-image: url('../assets/img/background-none.jpg');
  background-size: cover;
  background-repeat: no-repeat;
}
#leftImage, #rightImage {
  transition: opacity 1s ease-in-out, margin 1s ease-in-out;
}

#leftImage.transition, #rightImage.transition {
  animation: fadeInOut 2s ease-in-out infinite;
}

#leftImage.transition {
  margin-right: 0;
}

#rightImage.transition {
  margin-left: 0;
}
</style>