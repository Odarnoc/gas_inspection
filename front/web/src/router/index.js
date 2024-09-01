import { route } from 'quasar/wrappers'
import { createRouter, createMemoryHistory, createWebHistory, createWebHashHistory } from 'vue-router'
import routes from './routes'

/*
 * If not building with SSR mode, you can
 * directly export the Router instantiation;
 *
 * The function below can be async too; either use
 * async/await or return a Promise which resolves
 * with the Router instance.
 */

export default route(function ({ store/*, ssrContext */ }) {
  const createHistory = process.env.SERVER
    ? createMemoryHistory
    : (process.env.VUE_ROUTER_MODE === 'history' ? createWebHistory : createWebHashHistory)

  const Router = createRouter({
    scrollBehavior: () => ({ left: 0, top: 0 }),
    routes,

    // Leave this as is and make changes in quasar.conf.js instead!
    // quasar.conf.js -> build -> vueRouterMode
    // quasar.conf.js -> build -> publicPath
    history: createHistory(process.env.MODE === 'ssr' ? void 0 : process.env.VUE_ROUTER_BASE)
  })

  Router.afterEach(async (to, from) => {
    //* despues de cambiar de ruta ejecuta algo
  })

  Router.beforeEach(async (to, from, next) => {
    store.commit('system/generals/setGlobalLoading', true)
    try {
      const JWT = localStorage.getItem('JWT')
      if (JWT) {
        // await new Promise(resolve => setTimeout(resolve, 60000))
        await store.dispatch('users/auth/getProfile')
      }
      const route = determineRouting(JWT, to)

      next(route)
    } catch (error) {
      console.error(error)
    }
    store.commit('system/generals/setGlobalLoading', false)
  })

  function determineRouting (JWT, to) {
    if (to.matched.some(record => record.meta.requiresAuth)) {
      if (!JWT) {
        return { path: '/login' }
      }
    }

    if (to.matched.some(record => record.meta.redirectToDashboard)) {
      if (JWT) {
        return { path: '/' }
      }
    }

    return null
  }

  return Router
})
