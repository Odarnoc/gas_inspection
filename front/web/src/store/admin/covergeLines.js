import api from '../../commons/api.js'
const apiRoot = 'covergeLines'

const module = {
  namespaced: true,
  state: {
  },
  mutations: {
  },
  actions: {
    getAll: async ({ commit, dispatch }) => {
      const response = await api.get(`${apiRoot}/getAll`)
      return response
    },
    create: async (context, payload) => {
      const response = await api.post(`${apiRoot}/create`, payload)
      return response
    },
    update: async (context, payload) => {
      const response = await api.put(`${apiRoot}/update`, payload)
      return response
    },
    delete: async ({ commit, dispatch }, id) => {
      const response = await api.delete(`${apiRoot}/delete/${id}`)
      return response
    }
  },
  getters: {
  }
}
export default module
