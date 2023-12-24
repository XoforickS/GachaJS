<template>
<div class="catalogue-bg h-full min-h-screen">
  <div class="max-w-7xl mx-auto text-center pt-8 text-white">
    <div class="absolute top-5 right-8 flex">
      <div class="bg-gray-200 bg-opacity-30 rounded-full px-4 py-2 flex justify-center">
        <RouterLink to="/" class="pr-3">
          <img src="../assets/img/summon-icon.png" class="w-8 h-8 mx-auto" alt="">
        </RouterLink>
        <RouterLink to="/catalogue" class="pr-3">
          <img src="../assets/svg/collection.svg" class="w-7 h-7 mx-auto" alt="">
        </RouterLink>
        <button class="pr-3 -mt-1">
          <img src="../assets/svg/harvest.svg" class="w-7 h-7 mx-auto" alt="">
        </button>
        <RouterLink to="/login" class="pr-3">
          <img src="../assets/svg/settings.svg" class="w-7 h-7 mx-auto" alt="">
        </RouterLink>
      </div>
    </div>
    <h1 class="text-3xl font-bold mb-4">Catalogue</h1>
    <div class="grid grid-cols-5 gap-4 bg-black bg-opacity-80 p-10 rounded-xl">
      <div
        v-for="(card, index) in userCards"
        :key="index"
        class="flex flex-col items-center pt-8"
      >
        <img :src="card.image" :alt="card.name" class="w-3/4 mb-2" />
        <p>{{ card.name }}</p>
        <p>Attack: {{ card.attack }}</p>
        <p>Defense: {{ card.defense }}</p>
        <p>Speed: {{ card.speed }}</p>
      </div>
    </div>
  </div>
</div>
</template>

<script>
import { useAuthStore } from '../stores/auth';
import { ref, onMounted } from 'vue';

class Card {
  constructor(id, name, image, attack, defense, speed) {
    this.id = id;
    this.name = name;
    this.image = image;
    this.attack = attack;
    this.defense = defense;
    this.speed = speed;
  }
}

export default {
  setup() {
    const authStore = useAuthStore();
    const userCards = ref([]);

    const loadCardData = async () => {
      try {
        const response = await fetch(`http://localhost:8000/account_cards/${authStore.userId}`);
        const responseData = await response.json();

        const cardMap = new Map();

        responseData.forEach((item) => {
          const cardData = item.card;
          const cardKey = `${cardData.id}-${cardData.name}`;

          if (cardMap.has(cardKey)) {
            // Increment count if card is already in the map
            cardMap.set(cardKey, cardMap.get(cardKey) + 1);
          } else {
            // Add card to the map with count 1
            cardMap.set(cardKey, 1);
          }
        });

        // Create Card instances and handle duplicates
        userCards.value = responseData.reduce((result, item) => {
          const cardData = item.card;
          const cardKey = `${cardData.id}-${cardData.name}`;
          const duplicateCount = cardMap.get(cardKey);

          // If there are duplicates, add a duplicate count to the card name
          const cardName = duplicateCount > 1 ? `${cardData.name} x${duplicateCount}` : cardData.name;

          // Only add the card to the result if it's not already added
          if (!result.some((card) => card.name === cardName)) {
            result.push(new Card(
              cardData.id,
              cardName,
              cardData.image,
              cardData.attack,
              cardData.defense,
              cardData.speed
            ));
          }

          return result;
        }, []);
      } catch (error) {
        console.error('Error loading card data:', error);
      }
    };

    onMounted(() => {
      loadCardData();
    });

    return { userCards };
  },
};
</script>

<style scoped>
.catalogue-bg{
  background-attachment: fixed;
  background-image: url('../assets/img/background_catalogue.jpg');
  background-size: cover;
  background-repeat: no-repeat;
}
</style>