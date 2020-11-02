import { createApp } from 'vue'
import App           from './app/App.vue'
import DatePicker    from './app/components/DatePicker.vue'
import router        from './router.coffee'
import store         from './store.coffee'

const app = createApp(App)

app.component('DatePicker', DatePicker)

app.use(router)
app.use(store)

app.mount('#app')