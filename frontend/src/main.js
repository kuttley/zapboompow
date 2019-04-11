import Vue from 'vue';
import './plugins/vuetify';
import VeeValidate from 'vee-validate';
import BootstrapVue from 'bootstrap-vue';
import App from './App.vue';
import router from './router';
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap-vue/dist/bootstrap-vue.css';
import 'vuetify/dist/vuetify.min.css';

Vue.config.productionTip = false

Vue.use(BootstrapVue);
Vue.use(VeeValidate);

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
