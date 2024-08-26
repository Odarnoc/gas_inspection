import api from 'src/commons/api.js'

export default {
  namespaced: true,
  state: {
  },
  mutations: {
  },
  actions: {
    requestPasswordByEmail: async ({ context, payload }, email) => {
      const response = await api.post(`auth/recover/${email}`)
      return response
    },
    validateToken: async (context, payload) => {
      const response = await api.post('userRecovery/validateToken', payload)
      return response
    },
    changePassword: async (context, payload) => {
      const response = await api.patch('auth/update-password', payload)
      return response
    },
    emailConfirmation: async (context, payload) => {
      const response = await api.patch('auth/emailConfirmation', payload)
      return response
    },
    reTryEmailVerification: async ({ context, payload }, email) => {
      const response = await api.get(`auth/reTryEmailVerification/${email}`)
      return response
    }
  },
  getters: {
  }
}
