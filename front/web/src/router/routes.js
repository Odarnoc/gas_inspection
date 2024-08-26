const metaAuth = { requiresAuth: true }
const metaNoAuth = { requiresAuth: false }
const metaNoAuthAndRedirectToDashboard = { requiresAuth: false, redirectToDashboard: true }

const routes = [
  {
    path: '/login',
    meta: metaNoAuthAndRedirectToDashboard,
    component: () => import('pages/Login.vue')
  },
  {
    path: '/forgotPassword',
    meta: metaNoAuth,
    component: () => import('pages/ForgotPassword.vue')
  },
  {
    path: '/',
    meta: metaAuth,
    component: () => import('layouts/MainLayout.vue'),
    children: [
      { path: '', component: () => import('pages/Index.vue') }
    ]
  },

  // Always leave this as last one,
  // but you can also remove it
  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/Error404.vue')
  }
]

export default routes
