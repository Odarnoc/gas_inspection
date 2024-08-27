import api from '../../commons/api.js'
const apiRoot = 'proyectTypes'

const module = {
  namespaced: true,
  state: {
  },
  mutations: {
  },
  actions: {
    getTable: async ({ commit, dispatch }, pagination) => {
      const response = await api.post(`${apiRoot}/getTable`, pagination)
      return response
    },
    get: async ({ commit, dispatch }, id) => {
      const response = await api.post(`${apiRoot}/get/${id}`)
      return response
    },
    create: async (context, payload) => {
      const response = await api.post(`${apiRoot}/create`, payload)
      return response
    },
    update: async (context, payload) => {
      const response = await api.put(`${apiRoot}/update`, payload)
      return response
    }
  },
  getters: {
  }
}
export default module
