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
      { path: 'dashboard', component: () => import('pages/Index.vue') },
      { path: 'proyectTypes', component: () => import('pages/admin/proyect_types/Index.vue') },
      { path: 'proyectTypes/new', component: () => import('pages/admin/proyect_types/New.vue') },
      { path: 'proyectTypes/edit/:id', component: () => import('pages/admin/proyect_types/Edit.vue') },
      { path: 'personal', component: () => import('pages/admin/personal/Index.vue') },
      { path: 'personal/new', component: () => import('pages/admin/personal/New.vue') },
      { path: 'personal/edit/:id', component: () => import('pages/admin/personal/Edit.vue') },
      { path: 'request', component: () => import('src/pages/vendor/request/Index-assigned.vue') },
      { path: 'observed', component: () => import('src/pages/vendor/request/Index-observed.vue') },
      { path: 'approved', component: () => import('src/pages/vendor/request/Index-approved.vue') },
      { path: 'rejected', component: () => import('src/pages/vendor/request/Index-rejected.vue') },
      { path: 'done', component: () => import('src/pages/vendor/request/Index-done.vue') },
      { path: 'stored', component: () => import('src/pages/vendor/request/Index-store.vue') },
      { path: 'request/new', component: () => import('pages/vendor/request/New.vue') },
      { path: 'request/edit/:id', component: () => import('pages/vendor/request/Edit.vue') },
      { path: 'request/approved/:id', component: () => import('pages/vendor/request/Edit-approved.vue') },
      { path: 'request/completed/:id', component: () => import('pages/vendor/request/Edit-completed.vue') },
      { path: 'logs/request', component: () => import('pages/admin/logs/request/Index.vue') },
      { path: 'coverageMap', component: () => import('pages/admin/coverrage_map/Index.vue') },
      { path: 'profile', component: () => import('pages/Profile') }
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
