import api from '../../commons/api.js'
const apiRoot = 'requestPetition'

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
    getTableApproved: async ({ commit, dispatch }, pagination) => {
      const response = await api.post(`${apiRoot}/getTableApproved`, pagination)
      return response
    },
    getTableAssigned: async ({ commit, dispatch }, pagination) => {
      const response = await api.post(`${apiRoot}/getTableAssigned`, pagination)
      return response
    },
    getTableObserved: async ({ commit, dispatch }, pagination) => {
      const response = await api.post(`${apiRoot}/getTableObserved`, pagination)
      return response
    },
    getTableRejected: async ({ commit, dispatch }, pagination) => {
      const response = await api.post(`${apiRoot}/getTableRejected`, pagination)
      return response
    },
    getTableDone: async ({ commit, dispatch }, pagination) => {
      const response = await api.post(`${apiRoot}/getTableDone`, pagination)
      return response
    },
    getTableStore: async ({ commit, dispatch }, pagination) => {
      const response = await api.post(`${apiRoot}/getTableStore`, pagination)
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
