import { boot } from 'quasar/wrappers'
import VueGoogleMaps from '@fawmi/vue-google-maps'

export default boot(({ app }) => {
  app.use(VueGoogleMaps, {
    load: {
      key: 'AIzaSyBxXFSMJISfc_2X6jlG9VcEHCYfEHuNNz4'
    }
  }).mount('#app')
})
