import api from '../../commons/api.js'
const apiRoot = 'pdf/request'

const module = {
  namespaced: true,
  state: {
  },
  mutations: {
  },
  actions: {
    getProyectPdf: async ({ commit }, params) => {
      const response = await api.downloadPostFile(`${apiRoot}/getProyectPdf/${params.id}`, params, params.name)
      return response
    },
    getInProgressReport: async ({ commit }, params) => {
      const response = await api.downloadPostFile(`${apiRoot}/getInProgressReport`, params, params.name)
      return response
    }
  },
  getters: {
  }
}
export default module
