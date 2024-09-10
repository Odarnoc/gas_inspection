import api from '../../commons/api.js'
const apiRoot = 'logs/requestPetition'

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
    }
  },
  getters: {
  }
}
export default module
