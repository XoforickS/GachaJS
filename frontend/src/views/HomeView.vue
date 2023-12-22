<template>
  <div class="main-bg h-screen bg-no-repeat bg-cover w-full">
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
        <button id="summonButton" class="bg-white hover:bg-gray-200 cursor-pointer pt-1 pl-6 pr-1 rounded-full transition ease-in-out flex justify-between" @click="summon" :disabled="summonStones === 0">
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
      <div class="text-white absolute bottom-5 left-5">
        <img src="" class="rounded-full" alt="">Username
        <div class="flex space-x-2">
          <img src="../assets/svg/xp.svg" class="w-4 h-4" alt="">
          <div class="h-1 w-full bg-neutral-500 mt-1">
            <div class="h-1 bg-blue-800" style="width: 45%"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
class Card {
  constructor(name, image, attack, defense, speed) {
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
          (card) => new Card(card.name, card.image, card.attack, card.defense, card.speed)
        );
      } catch (error) {
        console.error('Error loading card data:', error);
      }
    },

    summon() {
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
      this.summonStones--;

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
  background-image: url('../assets/img/background_home.jpg');
  background-size: cover;
  background-repeat: no-repeat;
}
</style>