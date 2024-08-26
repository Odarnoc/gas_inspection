import api from 'src/commons/api.js'
import axios from 'axios'

export default {
  namespaced: true,
  state: {
    id: null,
    firstName: null,
    wasLoaded: false,
    fistLogin: false,
    role: null,
    rox: [],
    token: null
  },
  mutations: {
    setId: (state, id) => {
      state.id = id
    },
    setFirstName: (state, firstName) => {
      state.firstName = firstName
    },
    setWasLoaded: (state, wasLoaded) => {
      state.wasLoaded = wasLoaded
    },
    setFistLogin: (state, fistLogin) => {
      state.fistLogin = fistLogin
    },
    setRole: (state, payload) => {
      state.role = payload
    },
    setRox: (state, payload) => {
      state.rox = payload
    },
    setToken: (state, payload) => {
      state.token = payload
    }
  },
  actions: {
    getTable: async ({ commit, dispatch }, pagination) => {
      const response = await api.get('users/getTable', pagination)
      return response
    },
    get: async ({ commit, dispatch }, id) => {
      const response = await api.post(`users/get/${id}`)
      return response
    },
    update: async (context, payload) => {
      const response = await api.put('users/update', payload)
      return response
    },
    signIn: async (context, payload) => {
      const response = await api.post('users/create', payload)
      return response
    },
    getProfile: async (context) => {
      const response = await api.post('auth/profile')
      const data = response.data
      if (data.result) {
        context.commit('setId', data.id)
        context.commit('setRole', data.roles)
        context.commit('setRox', data.email)
        context.commit('setWasLoaded', true)
      }
      return response
    },
    logIn: async ({ commit, dispatch }, payload) => {
      const response = await api.post('auth/login', payload)
      if (response.data.result) {
        localStorage.setItem('JWT', response.data.token)
        axios.defaults.headers.common.Authorization = response.data.token
        commit('setToken', response.data.token)
      }
      return response
    }
  },
  getters: {
    users: state => state.users,
    id: state => state.id,
    firstName: state => state.firstName,
    wasLoaded: state => state.wasLoaded,
    fistLogin: state => state.fistLogin,
    role: state => state.role,
    rox: state => state.rox,
    token: state => state.token
  }
}
