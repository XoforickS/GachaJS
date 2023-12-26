<template>
<div class="detail-bg min-h-screen">
    <RouterLink to="/catalogue" class="absolute top-2 left-2 px-4 py-2 text-white rounded-lg bg-black">
        Retour en arrière
    </Routerlink>
    <div class="grid grid-cols-2 gap-8">
        <div class="text-center pt-8 text-white flex justify-center items-center h-screen">
            <img :src="card.image" :alt="card.name" class="h-2/3 mb-2" />
        </div>
        <div class="flex flex-col text-white bg-black bg-opacity-80 p-10">
            <h2 class="text-4xl font-semibold mb-4 flex justify-between">
                {{ card.name }} 
                <div class="flex space-x-2">
                    <img src="../assets/svg/yellow-star.svg" class="w-8 h-8 mt-1" alt="">
                    <img v-for="i in 3" :key="i" src="../assets/svg/stars.svg" class="w-8 h-8 mt-1" alt="">
                </div>
                <div>UR</div>
            </h2>
            <div class="mb-10 mt-4 text-lg">
                Histoire, {{ card.name }} : <br><br><div class="text-sm">Maecenas elit diam, tincidunt sit amet ligula at, blandit aliquam arcu. In eu dui sit amet enim suscipit interdum. Maecenas in velit blandit, pellentesque urna eu, tempus dolor. Praesent venenatis orci at lobortis cursus. In eget ultricies magna. Curabitur molestie nibh sed nibh accumsan, vel rhoncus odio euismod. Maecenas scelerisque mollis purus vel egestas. Cras sit amet molestie risus. Vivamus congue vel justo ac aliquet. Donec porta, felis id ultrices porttitor, purus lacus lacinia ex, et tincidunt leo arcu fermentum est. Curabitur faucibus viverra lacus quis semper.</div>
            </div>
            <div class="mb-8 text-lg">
                Statistique :
            </div>
            <div class="flex flex-col space-y-8">
                <div class="grid grid-cols-5 gap-4">Attaque: {{ card.attack + currentStats.attack_upgrade }}
                    <button 
                        class="bg-green-500 col-span-2 px-4 w-2/3 text-center rounded-lg"
                        @click="upgradeCardStats('attack')"
                    >
                        Améliorer l'Attaque
                    </button>
                    <div class="h-3 group col-span-2 relative rounded-full w-full bg-neutral-500 mt-1">
                        <div class="h-3 rounded-full relative bg-blue-600" :style="{ width: `${currentStats.attack_upgrade || 0}%` }"></div>
                        <span class="hidden group-hover:block absolute top-0 left-1/2 -translate-x-1/2 text-xs">{{ currentStats.attack_upgrade || 0 }}%</span>
                    </div>
                </div>
                <div class="grid grid-cols-5 gap-4">Defense: {{ card.defense + currentStats.defense_upgrade }}
                    <button 
                        class="bg-green-500 col-span-2 px-4 w-2/3 text-center rounded-lg"
                        @click="upgradeCardStats('defense')"
                    >
                        Améliorer la defense
                    </button>
                    <div class="h-3 group col-span-2 relative rounded-full w-full bg-neutral-500 mt-1">
                        <div class="h-3 rounded-full relative bg-blue-600" :style="{ width: `${currentStats.defense_upgrade || 0}%` }" :class="{ 'transition-upgrade duration-1000': upgradeBarTransition }"></div>
                        <span class="hidden group-hover:block absolute top-0 left-1/2 -translate-x-1/2 text-xs">{{ currentStats.defense_upgrade || 0 }}%</span>
                    </div>
                </div>
                <div class="grid grid-cols-5 gap-4">Vitesse: {{ card.speed + currentStats.speed_upgrade }}
                    <button 
                        class="bg-green-500 col-span-2 px-4 w-2/3 text-center rounded-lg"
                        @click="upgradeCardStats('speed')"
                    >
                        Améliorer la Vitesse
                    </button>
                    <div class="h-3 group col-span-2 relative rounded-full w-full bg-neutral-500 mt-1">
                        <div class="h-3 rounded-full relative bg-blue-600" :style="{ width: `${currentStats.speed_upgrade}%` }" :class="{ 'transition-upgrade duration-1000': upgradeBarTransition }"></div>
                        <span class="hidden group-hover:block absolute top-0 left-1/2 -translate-x-1/2 text-xs">{{ currentStats.speed_upgrade || 0 }}%</span>
                    </div>
                </div>
            </div>
            <div class="mt-12 mb-8 text-lg">
                Mes Objets :
            </div>
            <div class="grid grid-cols-5 gap-8">
                <div class="bg-black rounded-lg p-6">Vide</div>
                <div class="bg-black rounded-lg p-6">Vide</div>
                <div class="bg-black rounded-lg p-6">Vide</div>
                <div class="bg-black rounded-lg p-6">Vide</div>
                <div class="bg-black rounded-lg p-6">Vide</div>
            </div>
        </div>
    </div>
</div>
</template>

<script>
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import { useAuthStore } from '../stores/auth';

export default {
  setup() {
    const route = useRoute();
    const authStore = useAuthStore();
    const cardId = ref(route.params.cardId);
    const card = ref({});
    const currentStats = ref({});
    const upgradeBarTransition = ref(true);

    const loadCardDetails = async () => {
      try {
        const response = await fetch(`http://localhost:8000/cards/${cardId.value}`);
        const responseData = await response.json();
        card.value = responseData;
        upgradeBarTransition.value = true;
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

    onMounted(() => {
      loadCardDetails();
      fetchCurrentStats();
    });

    return { card, currentStats, upgradeCardStats };
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