const module = {
  namespaced: true,
  state: {
    globalLoading: false
  },
  mutations: {
    setGlobalLoading: (state, globalLoading) => {
      state.globalLoading = globalLoading
    }
  },
  actions: {
  },
  getters: {
    globalLoading: state => state.globalLoading
  }
}
export default module
