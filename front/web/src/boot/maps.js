import { boot } from 'quasar/wrappers'
import VueGoogleMaps from '@fawmi/vue-google-maps'

export default boot(({ app }) => {
  app.use(VueGoogleMaps, {
    load: {
      key: 'AIzaSyBskDSJ_vXhch_eubPRFh6Lb5V8tNkSeEg'
    }
  }).mount('#app')
})
