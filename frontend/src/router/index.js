import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue';
import SummonView from '../views/SummonView.vue'
import CatalogueView from '../views/CatalogueView.vue';
import LoginView from '../views/LoginView.vue';
import CardDetailsView from '../views/CardDetailsView.vue';
// import FightView from '../views/FightView.vue';
import StageFightView from '../views/StageFightView.vue';
import MapStage from '../views/MapStage.vue'
import FightPage from '../views/FightPage.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'Home',
      component: HomeView,
    },
    {
      path: '/summon',
      name: 'Summon',
      component: SummonView,
    },
    // {
    //   path: '/fight',
    //   name: 'fight',
    //   component: FightView
    // },
    {
      path: '/map',
      name: 'Map',
      component: MapStage
    },
    {
      path: '/map',
      name: 'Map',
      component: MapStage
    },
    {
      path: '/fights',
      name: 'Fight',
      component: FightPage
    },
    {
      path: '/prepare/:stageFightId',
      name: 'prepare',
      component: StageFightView
    },
    {
      path: '/catalogue',
      name: 'Catalogue',
      component: CatalogueView,
    },
    {
      path: '/login',
      name: 'Login',
      component: LoginView,
    },
    { 
      path: '/card/:cardId', 
      name: 'cardDetails', 
      component: CardDetailsView,
    },
  ]
})

export default router
