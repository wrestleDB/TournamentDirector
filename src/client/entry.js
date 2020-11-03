import { createApp } from 'vue'
import App           from './app/App.vue'
import DatePicker    from './app/components/DatePicker.vue'
import DropDown      from './app/components/DropDown.vue'
import InputField    from './app/components/InputField.vue'
import router        from './router.coffee'
import store         from './store.coffee'

const app = createApp(App)

app.component('DatePicker', DatePicker)
app.component('DropDown',   DropDown)
app.component('InputField', InputField)

app.use(router)
app.use(store)

app.mount('#app')