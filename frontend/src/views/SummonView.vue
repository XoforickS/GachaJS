<template>
  <div class="main-bg h-screen bg-no-repeat bg-cover w-full overflow-hidden">
    <div class="absolute right-0 left-0 bottom-0">
      <div class="flex justify-center items-end mt-2">
        <img id="leftImage" src="../assets/img/Left.png" :class="{ 'transition mr-0': SummonAnim, 'duration-1000': SummonAnim }" class="mr-52" alt="" />
        <img id="rightImage" src="../assets/img/Right.png" :class="{ 'transition ml-0': SummonAnim, 'duration-1000': SummonAnim }" class="ml-52" alt="" />
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
            <img src="../assets/img/equipment_summon.png" class="w-6 h-6 mt-[2px]" />
            <span class="ml-4">{{ currentUserInfo.equipment_stone }}</span>
          </div>
          <div class="flex bg-gray-200 bg-opacity-30 rounded-full pr-3">
            <img src="../assets/img/summon-stone.webp" class="w-6 h-6 mt-[2px]" />
            <span class="ml-4">{{ currentUserInfo.summon_stone }}</span>
          </div>
          <div class="flex bg-gray-200 bg-opacity-30 rounded-full pr-3">
            <img src="../assets/img/coin.webp" class="w-6 h-6 mt-[2px]" />
            <span class="ml-4">{{ currentUserInfo.coin }}</span>
          </div>
          <div class="bg-gray-200 bg-opacity-30 rounded-full px-4 py-2 flex justify-center">
            <RouterLink to="/" class="pr-3">
              <img src="../assets/svg/home.svg" class="w-8 h-8 mx-auto" alt="">
            </RouterLink>
            <RouterLink to="/catalogue" class="pr-3">
              <img src="../assets/svg/collection.svg" class="w-7 h-7 mx-auto" alt="">
            </RouterLink>
            <div class="pr-3 relative">
              <button @click="dropdownSettings = !dropdownSettings">
                <img src="../assets/svg/settings.svg" class="w-7 h-7 mx-auto" alt="">
              </button>
              <div v-if="dropdownSettings == true" class="absolute right-0 z-10 mt-4 w-56 origin-top-right rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none" role="menu" aria-orientation="vertical" aria-labelledby="menu-button" tabindex="-1">
                <div class="py-1" role="none">
                  <router-link role="none" to="/login">
                    <span class="text-gray-700 block w-full px-4 py-2 text-left text-sm" role="menuitem" tabindex="-1" id="menu-item-3">Se déconnecter</span>
                  </router-link>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <button @click="equipementChoosed = !equipementChoosed">
        <img src="../assets/img/equipement-summon.png" class="absolute top-20 right-7 w-1/6" alt="">
      </button>
    </nav>
    <div class="max-w-7xl mx-auto text-center">
      <div class="absolute bottom-4 right-0 left-0 w-1/3 mx-auto grid grid-cols-2 font-semibold text-2xl justify-center gap-4">
        <button v-if="!equipementChoosed" id="summonButton" class="bg-white hover:bg-gray-200 cursor-pointer pt-1 pl-6 pr-1 rounded-full transition ease-in-out flex justify-between" @click="startAnimation(1), openSummon = false" :disabled="currentUserInfo.summon_stone === 0">
          <span class="pt-2">Invocation</span> <span class="flex bg-gray-700 rounded-full px-4 py-2 mb-1 text-white"><img src="../assets/img/summon-stone.webp" class="w-6 h-6 mt-[2px] mr-2" />1</span>
        </button>
        <button v-if="!equipementChoosed" id="summonMultiButton" class="bg-white hover:bg-gray-200 cursor-pointer pt-1 pl-6 pr-1 rounded-full transition ease-in-out flex justify-between" @click="startAnimation(2), openSummon = false" :disabled="currentUserInfo.summon_stone < 10">
          <span class="pt-2">Multi-Invocation</span> <span class="flex bg-gray-700 rounded-full px-4 py-2 mb-1 text-white"><img src="../assets/img/summon-stone.webp" class="w-7 h-7 mt-[2px] mr-2" />10</span>
        </button>
        <button
          v-if="equipementChoosed"
          id="summonEquipmentButton"
          class="bg-white hover:bg-gray-200 cursor-pointer pt-1 pl-6 pr-1 rounded-full transition ease-in-out flex justify-between"
          @click="startEquipmentAnimation(1)"
          :disabled="currentUserInfo.summon_stone === 0"
        >
          <span class="pt-2">Invocation</span>
          <span class="flex bg-gray-700 rounded-full px-4 py-2 mb-1 text-white"
            ><img src="../assets/img/equipment_summon.png" class="w-6 h-6 mt-[2px] mr-2" />1</span
          >
        </button>
        <button v-if="equipementChoosed" id="summonMultiButton" class="bg-white hover:bg-gray-200 cursor-pointer pt-1 pl-6 pr-1 rounded-full transition ease-in-out flex justify-between" @click="startAnimation(2)" :disabled="currentUserInfo.summon_stone < 10">
          <span class="pt-2">Multi-Invocation</span> <span class="flex bg-gray-700 rounded-full px-4 py-2 mb-1 text-white"><img src="../assets/img/equipment_summon.png" class="w-7 h-7 mt-[2px] mr-2" />10</span>
        </button>
      </div>
      <div v-if="account != 0 && openSummon" id="summonedCardDisplay" class="fixed z-40 top-2 w-4/6 mx-auto mt-2 grid grid-cols-5 gap-4 bg-black bg-opacity-75 rounded-xl px-8 py-4 text-white">
        <button class="absolute top-2 right-5 text-2xl" @click="ResetInvoc()">X</button>
        <div
          v-for="(card, index) in account"
          :key="index"
          class="flex flex-col items-center relative"
        >
          <img
            :src="card.image"
            :alt="card.name"
            id="summonedCard"
            class="w-full h-full object-cover mb-2 summoned-card-animation"
          />
          <p>{{ card.name }}</p>
          <div class="hidden flex space-x-2">
            <p>{{ card.attack }}</p>
            <p>{{ card.defense }}</p>
            <p>{{ card.speed }}</p>
          </div>
          <div class="w-16 h-16 absolute -top-2 right-0">
            <img v-if="card.rarity == 0" src="../assets/img/cartes/logos/r.png" alt="">
            <img v-if="card.rarity == 1" src="../assets/img/cartes/logos/sr.png" alt="">
            <img v-if="card.rarity == 2" src="../assets/img/cartes/logos/ssr.png" alt="">
            <img v-if="card.rarity == 3" src="../assets/img/cartes/logos/ur.png" alt="">
            <img v-if="card.rarity == 4" src="../assets/img/cartes/logos/lr.png" alt="">
          </div>
        </div>
      </div>

      <div id="loadingIndicator" ref="loadingIndicator" class="hidden mt-4">
        Invocation en cours...
      </div>

      <img v-if="showExplosion" src="../assets/gif/explosion.gif" alt="Explosion" class="explosion-gif z-50" />
      
      <level-up-popup :is-visible="showLevelUpPopup" @close="showLevelUpPopup = false" />

      <div class="text-white bg-black bg-opacity-80 rounded-xl p-4 absolute w-1/5 text-2xl bottom-3 left-5">
        <div class="text-left flex justify-between mb-1"><div><img src="" class="rounded-full" alt="">{{authStore.username}}</div><div>Nv: {{currentUserInfo.level}}</div></div>
        <div class="flex space-x-2 mb-1">
          <img src="../assets/svg/xp.svg" class="w-4 h-4 mt-2" alt="">
          <div class="h-5 group relative rounded-full w-full bg-neutral-500 mt-1">
            <div class="h-5 rounded-full relative bg-blue-600" :style="{ width: `${currentUserInfo.xp}%` }" :class="{ 'transition-xp': xpBarTransition, 'duration-1000': xpBarTransition }"></div>
            <span class="hidden group-hover:block absolute top-1 left-1/2 -translate-x-1/2 text-xs">{{currentUserInfo.xp}}%</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { useAuthStore } from '../stores/auth';
import LevelUpPopup from '../components/LevelUpPopup.vue';

class Card {
  constructor(id, name, image, attack, defense, speed, percentage_drop, rarity) {
    this.id =  id;
    this.name = name;
    this.image = image;
    this.attack = attack;
    this.defense = defense;
    this.speed = speed;
    this.percentage_drop = percentage_drop
    this.rarity = rarity
  }
};

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
  components: {
    LevelUpPopup,
  },
  data() {
    return {
      SummonAnim: false,
      availableCards: [],
      currentUserInfo: [],
      account: [],
      xpBarTransition: true,
      loadingIndicator: null,
      showLevelUpPopup: false,
      showExplosion: false,
      dropdownSettings: false,
      equipementChoosed: false,
      openSummon: false,
    };
  },
  setup(){
    const authStore = useAuthStore();
    return {authStore}
  },
  mounted() {
    this.loadingIndicator = this.$refs.loadingIndicator;
    this.loadCurrentUserInfo();
    this.loadCardData().then(() => {
      this.setupEventListeners(); 
    });
    this.loadEquipmentData()
  },
  methods: {
    async loadCurrentUserInfo() {
      try {
        const response = await fetch(`http://localhost:8000/users/${this.authStore.userId}`);
        const responseData = await response.json();

        this.currentUserInfo = new User(responseData.id, responseData.username, responseData.email, responseData.xp, responseData.level, responseData.summon_stone, responseData.coin, responseData.equipment_stone);
        this.xpBarTransition = true;
      } catch (error) {
        console.error('Error loading user data:', error);
      }
    },

    async loadCardData() {
      try {
        const response = await fetch('http://localhost:8000/cards/');
        const cardData = await response.json();

        this.availableCards = cardData.map(
          (card) => new Card(card.id, card.name, card.image, card.attack, card.defense, card.speed, card.percentage_drop, card.rarity)
        );
      } catch (error) {
        console.error('Error loading card data:', error);
      }
    },

    async loadEquipmentData() {
      try {
        const response = await fetch('http://localhost:8000/equipment/');
        const equipmentData = await response.json();

        this.availableEquipment = equipmentData.map(
          (equipment) =>
            new Equipment(
              equipment.id,
              equipment.name,
              equipment.image,
              equipment.attack,
              equipment.defense,
              equipment.speed,
              equipment.rarity
            )
        );
      } catch (error) {
        console.error('Error loading equipment data:', error);
      }
    },

    async summon() {
      if (this.availableCards.length === 0 || this.summonStones === 0) {
        console.log('Pas de carte disponible à invoquer.');
        return;
      }

      this.showLoading();

      let selectedCard;

      const totalPercentage = this.availableCards.reduce((acc, card) => acc + card.percentage_drop, 0);

      const randomNumber = Math.random() * totalPercentage;

      let cumulativePercentage = 0;
      for (const card of this.availableCards) {
        cumulativePercentage += card.percentage_drop;
        if (randomNumber <= cumulativePercentage) {
          selectedCard = card;
          break;
        }
      }

      if (selectedCard && selectedCard.percentage_drop <= 1) {
        await this.showExplosionAnimation();
      }

      this.account.push(selectedCard);
      console.log(selectedCard);
      const newSummonStones = this.currentUserInfo.summon_stone - 1;

      const updateSummonStonesResponse = await fetch(`http://localhost:8000/users/update-summon-stones/${this.authStore.userId}?summon_stones=${newSummonStones}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
      });

      if (!updateSummonStonesResponse.ok) {
        console.error('Failed to update summon stones:', updateSummonStonesResponse.statusText);
        return;
      }

      this.loadCurrentUserInfo();
      
      this.$nextTick(() => {
        const summonedCardElement = document.getElementById('summonedCardDisplay');

        if (summonedCardElement) {
          summonedCardElement.classList.add('summoned-card-animation');
        }
      });

      try {
        const newXP = this.currentUserInfo.xp + 2;
        let newXPOffset = 0;

        if (newXP >= 100) {
          newXPOffset = newXP - 100;
        } else {
          newXPOffset = newXP;
        }

        const xpUpdateResponse = await fetch(`http://localhost:8000/users/update-xp/${this.authStore.userId}?xp=${newXPOffset}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
        });

        const xpUpdateData = await xpUpdateResponse.json();

        if (!xpUpdateResponse.ok) {
          console.error('Failed to update user XP:', xpUpdateData.detail);
        } else {
          const newLevel = this.currentUserInfo.level + 1;

          if (newXP >= 100) {
            const levelUpdateResponse = await fetch(`http://localhost:8000/users/update-level/${this.authStore.userId}?level=${newLevel}`, {
              method: 'PUT',
              headers: {
                'Content-Type': 'application/json',
              },
            });

            const levelUpdateData = await levelUpdateResponse.json();

            const newCoin = this.currentUserInfo.coin + 1500;
            await fetch(`http://localhost:8000/users/update-coin/${this.authStore.userId}?coin=${newCoin}`, {
              method: 'PUT',
              headers: {
                'Content-Type': 'application/json',
              },
            });

            const newEquipmentStone = this.currentUserInfo.equipment_stone + 1;
            await fetch(`http://localhost:8000/users/update-equipment-stone/${this.authStore.userId}?equipment_stone=${newEquipmentStone}`, {
              method: 'PUT',
              headers: {
                'Content-Type': 'application/json',
              },
            });

            if (!levelUpdateResponse.ok) {
              console.error('Failed to update user level:', levelUpdateData.detail);
            }

            this.showLevelUpPopup = true;
          }

          this.loadCurrentUserInfo();
        }

        
        const userCardCheckResponse = await fetch(`http://localhost:8000/user_cards/upgrade/${this.authStore.userId}/${selectedCard.id}`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            attack_upgrade: 0,
            defense_upgrade: 0,
            speed_upgrade: 0,
          }),
        });

        if (userCardCheckResponse.ok) {
          console.log('User already has the card. Continue with summoning...');
        } else if (userCardCheckResponse.status === 404) {
          console.log('Card added with default upgrades.');
        }

        const addCardResponse = await fetch(`http://localhost:8000/account_cards/add?user_id=${this.authStore.userId}&card_id=${selectedCard.id}`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
        });
        

        const addCardData = await addCardResponse.json();

        if (!addCardResponse.ok) {
          console.error('Failed to add the summoned card to the database:', addCardData.detail);
          return;
        }

        console.log('Card added with default upgrades.');
      } catch (error) {
        console.error('Error during the fetch request:', error);
      }

      setTimeout(() => {
        this.hideLoading();
        this.$nextTick(() => {
          const summonedCardElement = document.getElementById('summonedCard');

          if (summonedCardElement) {
            summonedCardElement.classList.remove('summoned-card-animation');
          }
        });
      }, 1000);
    },

    async summonMulti(count) {
      if (this.availableCards.length === 0 || this.summonStones < count) {
        console.log('Pas assez de pierres pour invoquer!');
        return;
      }

      this.showLoading();

      for (let i = 0; i < count; i++) {
        await this.summon();
        await new Promise(resolve => setTimeout(resolve, 1000));
      }

      const newXP = this.currentUserInfo.xp + 8;
      const newXPOffset = newXP >= 100 ? newXP - 100 : newXP;

      const xpUpdateResponse = await fetch(`http://localhost:8000/users/update-xp/${this.authStore.userId}?xp=${newXPOffset}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
      });

      const xpUpdateData = await xpUpdateResponse.json();

      if (!xpUpdateResponse.ok) {
        console.error('Failed to update user XP:', xpUpdateData.detail);
      } else {
        const newLevel = this.currentUserInfo.level + Math.floor(newXP / 100);

        if (newXP >= 100) {
          const levelUpdateResponse = await fetch(`http://localhost:8000/users/update-level/${this.authStore.userId}?level=${newLevel}`, {
            method: 'PUT',
            headers: {
              'Content-Type': 'application/json',
            },
          });

          const levelUpdateData = await levelUpdateResponse.json();
          
          const newCoin = this.currentUserInfo.coin + 1500;
          await fetch(`http://localhost:8000/users/update-coin/${this.authStore.userId}?coin=${newCoin}`, {
            method: 'PUT',
            headers: {
              'Content-Type': 'application/json',
            },
          });

          const newEquipmentStone = this.currentUserInfo.equipment_stone + 1;
          await fetch(`http://localhost:8000/users/update-equipment-stone/${this.authStore.userId}?equipment_stone=${newEquipmentStone}`, {
            method: 'PUT',
            headers: {
              'Content-Type': 'application/json',
            },
          });

          if (!levelUpdateResponse.ok) {
            console.error('Failed to update user level:', levelUpdateData.detail);
          }

          this.showLevelUpPopup = true;
        }

        this.loadCurrentUserInfo();
      }

      setTimeout(() => {
        this.hideLoading();
      }, 1000);
    },

    async summonEquipment() {
      if (this.availableEquipment.length === 0 || this.summonStones === 0) {
        console.log("Pas d'équipement disponible à invoquer.");
        return;
      }

      this.showLoading();

      let selectedEquipment;

      const totalRarity = this.availableEquipment.reduce(
        (acc, equipment) => acc + (equipment.rarity === 'Epic' ? 1 : 0.5), // Adjust this ratio as needed
        0
      );

      const randomNumber = Math.random() * totalRarity;

      let cumulativeRarity = 0;
      for (const equipment of this.availableEquipment) {
        cumulativeRarity += equipment.rarity === 'Epic' ? 1 : 0.5;
        if (randomNumber <= cumulativeRarity) {
          selectedEquipment = equipment;
          break;
        }
      }

      if (selectedEquipment && selectedEquipment.rarity === 'Epic') {
        await this.showExplosionAnimation();
      }

      const addEquipmentResponse = await fetch(`http://localhost:8000/account_equipments/add?user_id=${this.authStore.userId}&equipment_id=${selectedEquipment.id}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
      });

      const addEquipmentData = await addEquipmentResponse.json();
      
      console.log(addEquipmentData);

      this.account.push(selectedEquipment);
      console.log(selectedEquipment);
      try {
        const newXP = this.currentUserInfo.xp + 2;
        let newXPOffset = 0;

        if (newXP >= 100) {
          newXPOffset = newXP - 100;
        } else {
          newXPOffset = newXP;
        }

        const xpUpdateResponse = await fetch(`http://localhost:8000/users/update-xp/${this.authStore.userId}?xp=${newXPOffset}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
        });

        const xpUpdateData = await xpUpdateResponse.json();

        if (!xpUpdateResponse.ok) {
          console.error('Failed to update user XP:', xpUpdateData.detail);
        } else {
          const newLevel = this.currentUserInfo.level + 1;

          if (newXP >= 100) {
            const levelUpdateResponse = await fetch(`http://localhost:8000/users/update-level/${this.authStore.userId}?level=${newLevel}`, {
              method: 'PUT',
              headers: {
                'Content-Type': 'application/json',
              },
            });

            const levelUpdateData = await levelUpdateResponse.json();

            const newCoin = this.currentUserInfo.coin + 1500;
            await fetch(`http://localhost:8000/users/update-coin/${this.authStore.userId}?coin=${newCoin}`, {
              method: 'PUT',
              headers: {
                'Content-Type': 'application/json',
              },
            });

            const newEquipmentStone = this.currentUserInfo.equipment_stone + 1;
            await fetch(`http://localhost:8000/users/update-equipment-stone/${this.authStore.userId}?equipment_stone=${newEquipmentStone}`, {
              method: 'PUT',
              headers: {
                'Content-Type': 'application/json',
              },
            });

            if (!levelUpdateResponse.ok) {
              console.error('Failed to update user level:', levelUpdateData.detail);
            }

            this.showLevelUpPopup = true;
          }

          this.loadCurrentUserInfo();
        }
      } catch (error) {
        console.error('Error during the fetch request:', error);
      }
    },

    ResetInvoc () {
      this.openSummon = true;
      this.account = [];
    },

    showLoading() {
      this.loadingIndicator.classList.remove('hidden');
    },

    hideLoading() {
      this.loadingIndicator.classList.add('hidden');
    },

    async increaseSummonStones() {
      try {
        const newSummonStones = this.currentUserInfo.summon_stone + 1;

        const response = await fetch(`http://localhost:8000/users/update-summon-stones/${this.authStore.userId}?summon_stones=${newSummonStones}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
        });

        if (!response.ok) {
          console.error('Failed to update summon stones:', response.statusText);
          return;
        }

        this.loadCurrentUserInfo();
      } catch (error) {
        console.error('Error updating summon stones:', error);
      }
    },

    async showExplosionAnimation() {
      this.showExplosion = true;

      await new Promise(resolve => setTimeout(resolve, 2000));

      this.showExplosion = false;
    },

    async logout() {
      console.log('logout ???')
      await this.authStore.logout
    },

    startAnimation(id) {
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
          if (id == 1) {
            this.ResetInvoc();
            this.summon();
          } else {
            this.ResetInvoc()
            this.summonMulti(10);
          }
        }, 1500);
      }, 4000);
    },

    startEquipmentAnimation(id) {
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
          if (id == 1) {
            this.summonEquipment();
          } else {
            this.summonMulti(10);
          }
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
  background-image: url('../assets/img/summon/background.png');
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
.transition-xp {
  transition: width 1s ease;
}

.duration-1000 {
  transition-duration: 1000ms;
}
.explosion-gif {
  position: fixed;
  top: 38%;
  left: 52%;
  transform: translate(-50%, -50%);
  z-index: 9999;
}

.summoned-card-animation {
  animation: fadeIn 0.5s ease-in-out; /* You can adjust the animation properties */
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(-20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>