import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/views/Home.vue'
import Login from '@/views/Login.vue';
import Register from '@/views/Register.vue';
import User from '@/views/User.vue';
import auth from './auth';
import CollectionList from '@/views/CollectionList.vue';
import CollectionCreate from '@/views/CollectionCreate.vue';
import Collection from '@/views/Collection.vue';
import Comic from '@/views/Comic.vue';

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
      component: Register,
      beforeEnter(to, from, next) {
        if (auth.getUser() != null) {
          next('/');
        } else {
          next();
        }
      }
    },
    {
      path: '/login',
      name: 'login',
      component: Login,
      beforeEnter(to, from, next) {
        if (auth.getUser() != null) {
          next('/');
        } else {
          next();
        }
      }
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
      component: CollectionCreate,
      beforeEnter(to, from, next) {
        if (auth.getUser() != null) {
          next();
        } else {
          next('/login');
        }
      }
    },
    {
      path: '/collections/:id',
      component: Collection
    },
    {
      path: '/comic/:id',
      component: Comic,
    },
  ]
})

export default router;
