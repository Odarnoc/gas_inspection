import api from '../../commons/api.js'
const apiRoot = 'pdf/materials'

const module = {
  namespaced: true,
  state: {
  },
  mutations: {
  },
  actions: {
    getAllByRequestPdf: async ({ commit }, params, payload) => {
      const response = await api.downloadPostFile(`${apiRoot}/getAllByRequest/${params.id}`, payload, params.name)
      return response
    }
  },
  getters: {
  }
}
export default module
