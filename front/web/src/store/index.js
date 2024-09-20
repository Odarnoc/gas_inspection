import { store } from 'quasar/wrappers'
import { createStore } from 'vuex'

import users from './users'
import system from './system'
import admin from './admin'
import vendor from './vendor'
import logs from './logs'
import pdf from './pdf'

/*
 * If not building with SSR mode, you can
 * directly export the Store instantiation;
 *
 * The function below can be async too; either use
 * async/await or return a Promise which resolves
 * with the Store instance.
 */

export default store(function (/* { ssrContext } */) {
  const Store = createStore({
    modules: {
      users,
      system,
      admin,
      vendor,
      logs,
      pdf
    },

    // enable strict mode (adds overhead!)
    // for dev mode and --debug builds only
    strict: process.env.DEBUGGING
  })

  return Store
})
