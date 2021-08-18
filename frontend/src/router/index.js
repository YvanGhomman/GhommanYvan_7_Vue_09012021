import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import Create from '../views/CreatePost.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home,
    meta:{
      title: "Maison"
    }
  },
  {
    path: '/accueil',
    name: 'Accueil',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/Accueil.vue'),
    meta:{
      title: "Accueil"
    }
  },
  {
    path: '/create',
    name: 'Create',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: Create,
    meta:{
      title: "Création de post"
    }
  },
  {
    path: '/about',
    name: 'About',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue'),
    meta:{
      title: "À propos"
    }
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
});

router.afterEach((to, from, next) => {
  document.title = to.meta.title;
})

export default router
