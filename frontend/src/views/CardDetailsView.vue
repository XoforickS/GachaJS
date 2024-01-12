<template>
<div class="detail-bg min-h-screen">
    <div class="grid grid-cols-2">
        <div class="text-center text-white flex justify-center items-center h-screen">
            <img :src="card.image" :alt="card.name" class="h-screen w-full object-cover mb-2" />
        </div>
        <div class="flex flex-col text-white bg-black bg-opacity-80 px-10 pb-10">
            <div class="flex space-x-4 justify-end my-4">
              <div class="flex bg-gray-200 bg-opacity-30 rounded-full pr-3">
                <img src="../assets/img/equipment_summon.png" class="w-6 h-6 mt-[2px]" />
                <span class="ml-4">{{ currentUserInfo.equipment_stone }}</span>
              </div>
              <div class="flex bg-gray-200 bg-opacity-30 rounded-full pr-3">
                <img src="../assets/img/coin.webp" class="w-6 h-6 mt-[2px]" />
                <span class="ml-4">{{ currentUserInfo.coin }}</span>
              </div>
            </div>
            <h2 class="text-4xl font-semibold mb-4 flex justify-between">
                {{ card.name }} 
                <div class="flex space-x-2">
                    <img v-for="i in currentStats.level" :key="i" src="../assets/svg/yellow-star.svg" class="w-8 h-8 mt-1" alt="">
                    <button
                      v-if="showUpgradeButton"
                      class="bg-green-500 text-lg px-2 rounded-lg"
                      @click="upgradeLevel()"
                    >
                      Niveau +
                    </button>
                </div>
                <div v-if="card.rarity + currentStats.level !== 0" class="w-16 h-16">
                  <img v-if="(card.rarity + currentStats.level) == 1" src="../assets/img/cartes/logos/r.png" alt="">
                  <img v-if="(card.rarity + currentStats.level) == 2" src="../assets/img/cartes/logos/sr.png" alt="">
                  <img v-if="(card.rarity + currentStats.level) == 3" src="../assets/img/cartes/logos/ssr.png" alt="">
                  <img v-if="(card.rarity + currentStats.level) == 4" src="../assets/img/cartes/logos/ur.png" alt="">
                  <img v-if="(card.rarity + currentStats.level) == 5" src="../assets/img/cartes/logos/lr.png" alt="">
                </div>
            </h2>
            <div class="mb-10 mt-4 text-lg">
                Histoire, {{ card.name }} : <br><br><div class="text-sm">Maecenas elit diam, tincidunt sit amet ligula at, blandit aliquam arcu. In eu dui sit amet enim suscipit interdum. Maecenas in velit blandit, pellentesque urna eu, tempus dolor. Praesent venenatis orci at lobortis cursus. In eget ultricies magna. Curabitur molestie nibh sed nibh accumsan, vel rhoncus odio euismod. Maecenas scelerisque mollis purus vel egestas. Cras sit amet molestie risus. Vivamus congue vel justo ac aliquet. Donec porta, felis id ultrices porttitor, purus lacus lacinia ex, et tincidunt leo arcu fermentum est. Curabitur faucibus viverra lacus quis semper.</div>
            </div>
            <div class="mb-8 text-lg">
                Statistique :
            </div>
            <div class="flex flex-col space-y-8">
                <div class="grid grid-cols-6 gap-4">Attaque: {{ card.attack + currentStats.attack_upgrade }}
                    <button 
                        class="bg-green-500 col-span-3 px-4 w-2/3 text-center rounded-lg flex justify-between"
                        @click="upgradeCardStats('attack')"
                        :disabled="currentStats.attack_upgrade >= 100"
                    >
                        Améliorer l'Attaque <div class="flex ml-4">- 150<img src="../assets/img/coin.webp" class="ml-1 w-5 h-5 mt-[2px]" /></div>
                    </button>
                    <div class="h-3 group col-span-2 relative rounded-full w-full bg-neutral-500 mt-1">
                        <div class="h-3 rounded-full relative bg-blue-600" :style="{ width: `${currentStats.attack_upgrade || 0}%` }"></div>
                        <span class="hidden group-hover:block absolute top-0 left-1/2 -translate-x-1/2 text-xs">{{ currentStats.attack_upgrade || 0 }}%</span>
                    </div>
                </div>
                <div class="grid grid-cols-6 gap-4">Defense: {{ card.defense + currentStats.defense_upgrade }}
                    <button 
                        class="bg-green-500 col-span-3 px-4 w-2/3 text-center rounded-lg flex justify-between"
                        @click="upgradeCardStats('defense')"
                        :disabled="currentStats.defense_upgrade >= 100"
                    >
                        Améliorer la defense <div class="flex ml-4">- 150<img src="../assets/img/coin.webp" class="ml-1 w-5 h-5 mt-[2px]" /></div>
                    </button>
                    <div class="h-3 group col-span-2 relative rounded-full w-full bg-neutral-500 mt-1">
                        <div class="h-3 rounded-full relative bg-blue-600" :style="{ width: `${currentStats.defense_upgrade || 0}%` }" :class="{ 'transition-upgrade duration-1000': upgradeBarTransition }"></div>
                        <span class="hidden group-hover:block absolute top-0 left-1/2 -translate-x-1/2 text-xs">{{ currentStats.defense_upgrade || 0 }}%</span>
                    </div>
                </div>
                <div class="grid grid-cols-6 gap-4">Vitesse: {{ card.speed + currentStats.speed_upgrade }}
                    <button 
                        class="bg-green-500 col-span-3 px-4 w-2/3 text-center rounded-lg flex justify-between"
                        @click="upgradeCardStats('speed')"
                        :disabled="currentStats.speed_upgrade >= 100"
                    >
                        Améliorer la Vitesse <div class="flex ml-4">- 150<img src="../assets/img/coin.webp" class="ml-1 w-5 h-5 mt-[2px]" /></div>
                    </button>
                    <div class="h-3 group col-span-2 relative rounded-full w-full bg-neutral-500 mt-1">
                        <div class="h-3 rounded-full relative bg-blue-600" :style="{ width: `${currentStats.speed_upgrade}%` }" :class="{ 'transition-upgrade duration-1000': upgradeBarTransition }"></div>
                        <span class="hidden group-hover:block absolute top-0 left-1/2 -translate-x-1/2 text-xs">{{ currentStats.speed_upgrade || 0 }}%</span>
                    </div>
                </div>
                <div class="pt-10">
                  <RouterLink to="/catalogue" class="px-4 py-2 text-white rounded-lg bg-black">
                      Retour en arrière
                  </Routerlink>
                </div>
            </div>
            <!-- <div class="mt-12 mb-8 text-lg">
                Mes Objets :
            </div>
            <div class="grid grid-cols-5 gap-8">
                <div class="bg-black rounded-lg p-6">Vide</div>
                <div class="bg-black rounded-lg p-6">Vide</div>
                <div class="bg-black rounded-lg p-6">Vide</div>
                <div class="bg-black rounded-lg p-6">Vide</div>
                <div class="bg-black rounded-lg p-6">Vide</div>
            </div> -->
        </div>
    </div>
</div>
</template>

<script>
import { ref, onMounted } from 'vue';
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
  setup() {
    const route = useRoute();
    const authStore = useAuthStore();
    const cardId = ref(route.params.cardId);
    const card = ref({});
    const currentStats = ref({});
    const currentUserInfo = ref({});
    const upgradeBarTransition = ref(true);
    const possibleLevelUp = ref(false)

    const loadCardDetails = async () => {
      try {
        const response = await fetch(`http://localhost:8000/cards/${cardId.value}`);
        const responseData = await response.json();
        card.value = responseData;
        upgradeBarTransition.value = true;
        console.log(card.value)
      } catch (error) {
        console.error('Error loading card details:', error);
      }
    };

    const fetchCurrentStats = async () => {
      try {
        const response = await fetch(`http://localhost:8000/user_cards/${authStore.userId}/${cardId.value}`);
        const responseData = await response.json();

        if (!response.ok) {
          console.error('Failed to fetch current card stats:', responseData.detail);
        } else {
          currentStats.value = responseData;
        }
      } catch (error) {
        console.error('Error during the fetch request:', error);
      }
    };

    const upgradeCardStats = async (statType) => {
      await fetchCurrentStats();

      const currentUpgrade = currentStats.value[`${statType}_upgrade`] || 0;
      const upgradeAmount = 5;
      const upgradedStat = currentUpgrade + upgradeAmount;

      try {
        const userInfoResponse = await fetch(`http://localhost:8000/users/${authStore.userId}`);
        const userInfoData = await userInfoResponse.json();

        if (!userInfoResponse.ok) {
          console.error('Failed to fetch user info:', userInfoData.detail);
          return;
        }

        const newCoin = userInfoData.coin - 150;
        await fetch(`http://localhost:8000/users/update-coin/${authStore.userId}?coin=${newCoin}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
        });

        loadCurrentUserInfo();

        const response = await fetch(`http://localhost:8000/user_cards/upgrade/${authStore.userId}/${cardId.value}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            [`${statType}_upgrade`]: upgradedStat,
          }),
        });

        const responseData = await response.json();

        if (!response.ok) {
          console.error('Failed to upgrade user card stats:', responseData.detail);
        } else {
          console.log(`Upgraded ${statType} from ${currentUpgrade} to ${upgradedStat}`);

          loadCardDetails();
          fetchCurrentStats();
        }
      } catch (error) {
        console.error('Error during the upgrade request:', error);
      }
    };

    const upgradeLevel = async () => {
      try {
        let newLevel = currentStats.value.level || 1;

        const maxedStatsCount = [currentStats.value.attack_upgrade, currentStats.value.defense_upgrade, currentStats.value.speed_upgrade].filter(stat => stat === 100).length;

        if (newLevel === 1 && maxedStatsCount >= 1) {
          possibleLevelUp.value = true;
          newLevel++;
          console.log(newLevel);
        }

        else if (newLevel === 2 && maxedStatsCount >= 2) {
          possibleLevelUp.value = true;
          newLevel++;
          console.log(newLevel);
        }

        await fetch(`http://localhost:8000/user_cards/update-level/${authStore.userId}/${cardId.value}?level=${newLevel}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
        });

        fetchCurrentStats();
      } catch (error) {
        console.error('Error during the upgrade level:', error);
      }
    };

    async function loadCurrentUserInfo() {
      try {
        const response = await fetch(`http://localhost:8000/users/${authStore.userId}`);
        const responseData = await response.json();

        currentUserInfo.value = new User(
          responseData.id,
          responseData.username,
          responseData.email,
          responseData.xp,
          responseData.level,
          responseData.summon_stone,
          responseData.coin,
          responseData.equipment_stone
        );
      } catch (error) {
        console.error('Error loading user data:', error);
      }
    }

    onMounted(() => {
      loadCardDetails();
      fetchCurrentStats();
      loadCurrentUserInfo();
    });

    return { card, currentStats, upgradeCardStats, currentUserInfo, upgradeLevel };
  },
  computed: {
    showUpgradeButton() {
      if (this.currentStats.level === 1) {
        return (
          this.currentStats.attack_upgrade === 100 ||
          this.currentStats.defense_upgrade === 100 ||
          this.currentStats.speed_upgrade === 100
        );
      }

      if (this.currentStats.level === 2) {
        const maxedStatsCount = [this.currentStats.attack_upgrade, this.currentStats.defense_upgrade, this.currentStats.speed_upgrade].filter(stat => stat === 100).length;
        return maxedStatsCount >= 2;
      }

      return false;
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
.detail-bg{
  background-attachment: fixed;
  background-image: url('../assets/img/background-blackclover.jpg');
  background-size: cover;
  background-repeat: no-repeat;
}

.transition-upgrade {
  transition: width 1s ease;
}
.duration-1000 {
  transition-duration: 1000ms;
}
.yellow-star {
  fill: yellow;
}
</style>