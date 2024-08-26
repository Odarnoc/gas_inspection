import axios from 'axios'
const config = {
  headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    Accept: '*/*'
  }
}

const api = {
  get: (url) => axios.get(url, config),
  post: (url, data) => axios.post(url, data, config),
  put: (url, data) => axios.put(url, data, config),
  patch: (url, data) => axios.patch(url, data, config),
  delete: (url, data) => axios.delete(url, data, config),
  downloadPostFile: (url, data, fileName) => axios.post(url, data, { ...config, responseType: 'blob' }).then(res => {
    const blob = new Blob([res.data], { type: res.headers['content-type'] })
    const link = document.createElement('a')
    link.href = window.URL.createObjectURL(blob)
    link.download = fileName
    link.click()
  }).catch(err => { console.error(err) })
}

export default api
