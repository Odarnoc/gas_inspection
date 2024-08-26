import { boot } from 'quasar/wrappers'
import axios from 'axios'

export default boot(({ app }) => {
  axios.defaults.baseURL = process.env.API
  app.config.globalProperties.$axios = axios
})

export { axios }
