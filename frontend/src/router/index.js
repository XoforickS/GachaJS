import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import CatalogueView from '../views/CatalogueView.vue';
import LoginView from '../views/LoginView.vue';
import CardDetailsView from '../views/CardDetailsView.vue';
import FightView from '../views/FightView.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/fight',
      name: 'fight',
      component: FightView
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
