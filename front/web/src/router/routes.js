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
      { path: '', component: () => import('pages/Index.vue') },
      { path: 'proyectTypes', component: () => import('pages/admin/proyect_types/Index.vue') },
      { path: 'proyectTypes/new', component: () => import('pages/admin/proyect_types/New.vue') },
      { path: 'proyectTypes/edit/:id', component: () => import('pages/admin/proyect_types/Edit.vue') },
      { path: 'personal', component: () => import('pages/admin/personal/Index.vue') },
      { path: 'personal/new', component: () => import('pages/admin/personal/New.vue') },
      { path: 'personal/edit/:id', component: () => import('pages/admin/personal/Edit.vue') },
      { path: 'request', component: () => import('pages/vendor/request/Index.vue') },
      { path: 'request/new', component: () => import('pages/vendor/request/New.vue') },
      { path: 'request/edit/:id', component: () => import('pages/vendor/request/Edit.vue') }
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
