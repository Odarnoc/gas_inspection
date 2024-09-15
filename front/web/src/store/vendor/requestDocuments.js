import api from '../../commons/api.js'
const apiRoot = 'requestDocuments'

const module = {
  namespaced: true,
  state: {
  },
  mutations: {
  },
  actions: {
    getDocuments: async ({ commit, dispatch }, id) => {
      const response = await api.get(`${apiRoot}/getDocuments/${id}`)
      return response
    }
  },
  getters: {
  }
}
export default module
