import Vue from 'vue'
import App from './App.vue'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import axios from 'axios';
import cors from 'cors';
import VueAxios from 'vue-axios';

Vue.config.productionTip = false
Vue.use(ElementUI);


// Vue.use(axios);
// axios.defaults.baseURL=''; 
axios.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';
axios.defaults.timeout = 5000;

Vue.prototype.$axios = axios;
Vue.use(VueAxios, axios);




new Vue({
	render: h => h(App),
}).$mount('#app')


Vue.prototype.FomatTime = function(timestamp) {

	if (typeof timestamp != 'number') return timestamp;



	let time = new Date(timestamp)
	let year = time.getFullYear()
	const month = (time.getMonth() + 1).toString().padStart(2, '0')
	const date = (time.getDate()).toString().padStart(2, '0')
	const hours = (time.getHours()).toString().padStart(2, '0')
	const minute = (time.getMinutes()).toString().padStart(2, '0')
	const second = (time.getSeconds()).toString().padStart(2, '0')

	return year + '-' + month + '-' + date + ' ' + hours + ':' + minute + ':' + second
}
