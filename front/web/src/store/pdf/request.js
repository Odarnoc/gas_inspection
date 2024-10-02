import api from '../../commons/api.js'
const apiRoot = 'pdf/request'

const module = {
  namespaced: true,
  state: {
  },
  mutations: {
  },
  actions: {
    getProyectPdf: async ({ commit }, params, payload) => {
      const response = await api.downloadPostFile(`${apiRoot}/getProyectPdf/${params.id}`, payload, params.name)
      return response
    }
  },
  getters: {
  }
}
export default module
