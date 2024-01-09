import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue';
import SummonView from '../views/SummonView.vue'
import CatalogueView from '../views/CatalogueView.vue';
import LoginView from '../views/LoginView.vue';
import CardDetailsView from '../views/CardDetailsView.vue';

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
