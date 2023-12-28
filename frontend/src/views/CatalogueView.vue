<template>
<div class="catalogue-bg h-full min-h-screen">
  <div class="max-w-7xl mx-auto text-center pt-8 text-white pb-10">
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
    <h1 class="text-3xl font-bold mb-4">Catalogue des cartes</h1>
    <div class="grid grid-cols-5 gap-4 bg-black bg-opacity-80 p-10 rounded-xl">
      <RouterLink
        v-for="(card, index) in uniqueCards"
        :key="index"
        :to="{ name: 'cardDetails', params: { cardId: card.id } }"
      >
        <div class="flex flex-col items-center pt-8">
          <img :src="card.image" :alt="card.name" class="w-3/4 mb-2" />
          <p>{{ card.name }}</p>
          <p>Attack: {{ card.attack + card.attackUpgrade }}%</p>
          <p>Defense: {{ card.defense + card.defenseUpgrade }}%</p>
          <p>Speed: {{ card.speed + card.speedUpgrade }}%</p>
          <p v-if="card.duplicateCount > 1">x{{ card.duplicateCount }}</p>
        </div>
      </RouterLink>
    </div>
    <h1 class="text-3xl font-bold my-4">Catalogue des Items</h1>
    <div class="grid grid-cols-5 gap-4 bg-black bg-opacity-80 p-10 rounded-xl">
      <div
        v-for="(items, index) in uniqueEquipment"
        :key="index"
      >
        <div class="flex flex-col items-center pt-8">
          <img :src="items.image" :alt="items.name" class="w-3/4 mb-2" />
          <p>{{ items.name }}</p>
          <p>Attack: {{ items.attack }}%</p>
          <p>Defense: {{ items.defense }}%</p>
          <p>Speed: {{ items.speed }}%</p>
          <p v-if="items.duplicateCount > 1">x{{ items.duplicateCount }}</p>
        </div>
      </div>
    </div>
  </div>
</div>
</template>


<script>
import { useAuthStore } from '../stores/auth';
import { ref, onMounted } from 'vue';


class Card {
  constructor(id, name, image, attack, defense, speed, duplicateCount, attackUpgrade, defenseUpgrade, speedUpgrade) {
    this.id = id;
    this.name = name;
    this.image = image;
    this.attack = attack;
    this.defense = defense;
    this.speed = speed;
    this.duplicateCount = duplicateCount;
    this.attackUpgrade = attackUpgrade;
    this.defenseUpgrade = defenseUpgrade;
    this.speedUpgrade = speedUpgrade;
  }
}

class Equipment {
  constructor(id, name, image, attack, defense, speed, rarity) {
    this.id = id;
    this.name = name;
    this.image = image;
    this.attack = attack;
    this.defense = defense;
    this.speed = speed;
    this.rarity = rarity;
  }
}

export default {
  setup() {
    const authStore = useAuthStore();
    const userCards = ref([]);
    const userEquipment = ref([]);
    const uniqueCards = ref([]);
    const uniqueEquipment = ref([]);

    const loadCardData = async () => {
      try {
        const responseCards = await fetch(`http://localhost:8000/account_cards/${authStore.userId}`);
        const responseUpgrades = await fetch(`http://localhost:8000/user_cards/upgrades/${authStore.userId}`);
        const responseCounts = await fetch(`http://localhost:8000/account_cards/counts/${authStore.userId}`);

        const responseDataCards = await responseCards.json();
        const responseDataUpgrades = await responseUpgrades.json();
        const responseCountsData = await responseCounts.json();

        const cardCountsMap = new Map();

        responseCountsData.forEach((item) => {
          const cardKey = `${item.card_id}`;
          cardCountsMap.set(cardKey, item.count);
        });

        userCards.value = responseDataCards.map((item) => {
          const cardData = item.card;
          const cardKey = `${cardData.id}`;
          const duplicateCount = cardCountsMap.get(cardKey) || 1;
          const upgradeData = cardCountsMap.has(cardKey)
            ? responseDataUpgrades.find((upgrade) => upgrade.card_id === cardData.id)
            : {};

          return new Card(
            cardData.id,
            cardData.name,
            cardData.image,
            cardData.attack,
            cardData.defense,
            cardData.speed,
            duplicateCount,
            upgradeData.attack_upgrade || 0,
            upgradeData.defense_upgrade || 0,
            upgradeData.speed_upgrade || 0
          );
        });

        uniqueCards.value = [...new Set(userCards.value.map((card) => card.id))].map((id) => {
          return userCards.value.find((card) => card.id === id);
        });
      } catch (error) {
        console.error('Error loading card data:', error);
      }
    };

    const loadEquipmentData = async () => {
      try {
        const responseEquipment = await fetch(`http://localhost:8000/account_equipments/${authStore.userId}`);
        const responseDataEquipment = await responseEquipment.json();

        const equipmentCountsMap = new Map();

        responseDataEquipment.forEach((item) => {
          const equipmentKey = `${item.equipment_id}`;
          equipmentCountsMap.set(equipmentKey, (equipmentCountsMap.get(equipmentKey) || 0) + 1);
        });

        userEquipment.value = responseDataEquipment.map((item) => {
          const equipmentData = item.equipment;
          const equipmentKey = `${equipmentData.id}`;
          const duplicateCount = equipmentCountsMap.get(equipmentKey) || 1;

          return new Equipment(
            equipmentData.id,
            equipmentData.name,
            equipmentData.image,
            equipmentData.attack,
            equipmentData.defense,
            equipmentData.speed,
            equipmentData.rarity,
            duplicateCount
          );
        });

        uniqueEquipment.value = [...new Set(userEquipment.value.map((equipment) => equipment.id))].map((id) => {
          return userEquipment.value.find((equipment) => equipment.id === id);
        });
      } catch (error) {
        console.error('Error loading equipment data:', error);
      }
    };

    onMounted(() => {
      loadCardData();
      loadEquipmentData();
    });

    return { uniqueCards, userEquipment, uniqueEquipment };
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
.catalogue-bg{
  background-attachment: fixed;
  background-image: url('../assets/img/background_catalogue.jpg');
  background-size: cover;
  background-repeat: no-repeat;
}
</style>