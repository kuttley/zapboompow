import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/views/Home.vue'
import Login from '@/views/Login.vue';
import Register from '@/views/Register.vue';
import User from '@/views/User.vue';
import auth from './auth';
import CollectionList from '@/views/CollectionList';
import CollectionCreate from '@/views/CollectionCreate';
import Collection from '@/views/Collection';

Vue.use(Router)

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/register',
      name: 'register',
      component: Register
    },
    {
      path: '/login',
      name: 'login',
      component: Login
    },
    {
      path: '/user/:id',
      component: User,
      name: 'user',
      props: true,
    },
    {
      path: '/collections',
      component: CollectionList
    },
    {
      path: '/collections/create',
      component: CollectionCreate
    },
    {
      path: '/collections/:id',
      component: Collection
    },
  ]
})


router.beforeEach((to, from, next) => {
  // redirect to login page if not logged in and trying to access a restricted page
  const publicPages = ['/login', '/register'];
  const authRequired = !publicPages.includes(to.path);
  const loggedIn = auth.getUser();

  if (!authRequired && loggedIn) {
    return next('/');
  }

  if (authRequired && !loggedIn) {
    return next('/login');
  }

  next();
});

export default router;
