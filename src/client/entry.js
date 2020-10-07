import { createApp } from 'vue'
import App from './app/App.vue'
import router from './app/router.coffee'
import {store} from './app/store.coffee'

// Vue3 migration guide https://v3.vuejs.org/guide/migration/global-api.html#a-new-global-api-createapp
app = createApp(App)

app.use(router)
app.use(store)

app.mount('#app')