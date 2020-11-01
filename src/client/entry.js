import { createApp } from 'vue'
import App           from './app/App.vue'
import router        from './router.coffee'
import store         from './store.coffee'

import DatePicker    from './app/components/DatePicker.vue'

const app = createApp(App)

app.use(router)
app.use(store)

app.component('DatePicker', DatePicker)

app.mount('#app')