import { boot } from 'quasar/wrappers'
import { date, Quasar } from 'quasar'
import axios from 'axios'

import { TypesRol } from '../commons/roles.js'
import { i18n } from 'src/boot/i18n'
import { statusOrder } from 'src/commons/status.js'
import { imageCompressionType, manualsUrl } from 'src/commons/generals.js'

export default boot(({ app, ssrContext, store }) => {
  app.config.globalProperties.$initLanguaje = () => {
    let lang = localStorage.getItem('lang')
    if (lang === '' || lang === undefined || lang === null) {
      lang = Quasar.lang.getLocale().replace(/-/g, '_').split('_')[0]
    }
    i18n.global.locale = lang
    // eliminar la siguiente lines, solo es para dejar fijo el idioma en español
    i18n.global.locale = 'es'
  }

  app.config.globalProperties.$setDefaultHTTPLanguajeCode = () => {
    localStorage.setItem('lang', i18n.global.locale)
    axios.defaults.headers.common['Accept-Language'] = i18n.global.locale
    let quasarLang = i18n.global.locale
    if (i18n.global.locale === 'en') {
      quasarLang = 'en-us'
    }
    import('quasar/lang/' + quasarLang).then((lang) => {
      Quasar.lang.set(lang.default, ssrContext)
    })
  }

  // stripe public key
  app.config.globalProperties.$stripePublicKey =
    'pk_test_51IIc46BYgkmYGELWTuP4QA1HOD2KJ7I7f9vgNmjyqu1Tgcwl5vrTecuCMYrAiWqeSUe1j0MsfA2Jf9se4lwwlpGx00U4qqmGaP'
  app.config.globalProperties.$maskDate = 'YYYY-MM-DD'
  app.config.globalProperties.$maskDateTime = 'YYYY-MM-DD HH:mm'

  app.config.globalProperties.$maskDateDB = 'YYYY-MM-DD HH:mm'
  app.config.globalProperties.$maskDateDBNoTime = 'YYYY-MM-DD'

  // Función para darle formato de número a cualquier cifra eg: 1000 => 1,000.00
  app.config.globalProperties.$formatNumber = (number = 0, len = 2) => {
    return parseFloat((100 * number) / 100)
      .toFixed(len)
      .replace(/(\d)(?=(\d{3})+\.)/g, '$1,')
  }

  // Funciones para darle formato a fechas de estados unidos
  app.config.globalProperties.$toUSADate = (dateToParse) => {
    if (!dateToParse) {
      return
    }
    const dateObj = new Date(dateToParse.replace(/\s/, 'T'))
    return date.formatDate(dateObj, app.config.globalProperties.$maskDate)
  }

  app.config.globalProperties.$toUSADateTime = (dateToParse) => {
    if (!dateToParse) {
      return
    }
    const dateObj = new Date(dateToParse.replace(/\s/, 'T'))
    return date.formatDate(dateObj, app.config.globalProperties.$maskDateTime)
  }
  // Funciones para darle formato a fechas para guardarlo en la base de datos
  app.config.globalProperties.$toDBDate = (dateToParse) => {
    let info
    if (dateToParse) {
      info = dateToParse.split('/').reverse().join('-')
    }
    return info
  }
  app.config.globalProperties.$toDBDateNoTime = (dateToParse) => {
    const dateObj = new Date(dateToParse)
    return date.formatDate(
      dateObj,
      app.config.globalProperties.$maskDateDBNoTime
    )
  }

  // Evita que se escriban letras, solo números
  app.config.globalProperties.$lockIntegers = (evt) => {
    if (!evt) {
      evt = window.event
    }
    const charCode = evt.which ? evt.which : evt.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
      evt.preventDefault()
    } else {
      return true
    }
  }

  // Evita que se escriban letras, solo números y puntos decimales
  app.config.globalProperties.$lockDecimals = (evt) => {
    if (!evt) {
      evt = window.event
    }
    const charCode = evt.which ? evt.which : evt.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode !== 46) {
      evt.preventDefault()
    } else {
      return true
    }
  }

  // Agrega a (n) una cantidad (width) de (z). e.g. (1, 4): 0001
  app.config.globalProperties.$padZeros = (n, width, z = '0') => {
    // z = z || '0'
    n = n + ''
    return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n
  }

  // Validate string if is pdf
  app.config.globalProperties.$isPDF = (image) => {
    if (app.config.globalProperties.$getFileExtension(image) === 'pdf') { return true }
    return false
  }

  // Function to get file extension from string
  app.config.globalProperties.$getFileExtension = (filename) => {
    return filename.slice(((filename.lastIndexOf('.') - 1) >>> 0) + 2)
  }

  // Function to get string time from seconds
  app.config.globalProperties.$secondsToString = (seconds) => {
    const hours = Math.floor(seconds / 3600)
    seconds %= 3600
    const minutes = Math.floor(seconds / 60)
    if (hours === 0) {
      return `${minutes} min`
    }
    return `${hours} h ${minutes} min`
  }

  app.config.globalProperties.$getMiles = (distance) => {
    return distance * 0.000621371192
  }

  app.config.globalProperties.$getKilometers = (distance) => {
    return distance * 0.001
  }

  app.config.globalProperties.$ftToCm = (distance) => {
    return parseInt(Number(distance) * 30.48)
  }

  app.config.globalProperties.$lbToKg = (weight) => {
    return parseInt(Number(weight) * 0.453592)
  }

  app.config.globalProperties.$getDistance = (distance) => {
    if (app.store.getters['users/measurementUnits'] === 'imperial') {
      return app.config.globalProperties.$getMiles(distance).toFixed(2) + ' mi'
    }
    return (
      app.config.globalProperties.$getKilometers(distance).toFixed(2) + ' km'
    )
  }

  app.config.globalProperties.$getCmLongitud = (distance) => {
    if (app.store.getters['users/measurementUnits'] === 'imperial') {
      return app.config.globalProperties.$ftToCm(distance)
    }
    return parseInt(distance)
  }

  app.config.globalProperties.$getLongitudUm = () => {
    if (app.store.getters['users/measurementUnits'] === 'imperial') {
      return 'ft'
    }
    return 'cm'
  }

  app.config.globalProperties.$getWeightUm = () => {
    if (app.store.getters['users/measurementUnits'] === 'imperial') {
      return 'lb'
    }
    return 'kg'
  }

  app.config.globalProperties.$getKgWeight = (weight) => {
    if (app.store.getters['users/measurementUnits'] === 'imperial') {
      return app.config.globalProperties.$lbToKg(weight)
    }
    return parseInt(weight)
  }

  app.config.globalProperties.$encode = (val) => {
    return window.btoa(val)
  }

  app.config.globalProperties.$decode = (val) => {
    return window.atob(val)
  }

  app.config.globalProperties.$statusColor = (status) => {
    return status === 'Active'
      ? 'green'
      : status === 'Inactive'
        ? 'red-5'
        : status === 'Archived'
          ? 'blue-4'
          : ''
  }

  app.config.globalProperties.$verifyColor = (status) => {
    return status ? 'green' : 'red-5'
  }

  app.config.globalProperties.$verifyLabel = (status) => {
    return status
      ? i18n.global.t('status.verified')
      : i18n.global.t('status.not_verified')
  }

  app.config.globalProperties.$statusLabel = (status) => {
    return status
      ? i18n.global.t('fields.active')
      : i18n.global.t('fields.notVisible')
  }

  app.config.globalProperties.$documentIcon = (role, requested, verified) => {
    if (role === 4) {
      if (!requested) {
        return verified ? 'done' : 'priority_high'
      }
    }
    return 'folder'
  }

  app.config.globalProperties.$documentStatus = (requested, verified) => {
    if (!requested) {
      return verified
        ? i18n.global.t('status.verified')
        : i18n.global.t('status.on_review')
    } else {
      return i18n.global.t('status.upload_pending')
    }
  }

  app.config.globalProperties.$shipmentStatusColor = (status) => {
    return status === 'Waiting to load'
      ? 'primary'
      : status === 'On the way'
        ? 'positive'
        : status === 'New'
          ? 'blue'
          : status === 'Stopped on the way'
            ? 'red'
            : status === 'Cancel'
              ? 'red'
              : status === 'Arrived'
                ? 'blue'
                : status === 'Rerouted'
                  ? 'primary'
                  : 'positive'
  }
  app.config.globalProperties.$shipmentStatusTextColor = (status) => {
    return status === 'Waiting to load'
      ? 'text-primary'
      : status === 'On the way'
        ? 'text-positive'
        : status === 'New'
          ? 'text-blue'
          : status === 'Stopped on the way'
            ? 'text-red'
            : status === 'Cancel'
              ? 'text-red'
              : status === 'Arrived'
                ? 'text-blue'
                : status === 'Rerouted'
                  ? 'text-primary'
                  : 'text-positive'
  }

  app.config.globalProperties.$colorPalette = [
    '#f44336',
    '#e91e63',
    '#9c27b0',
    '#673ab7',
    '#2196f3',
    '#00bcd4',
    '#009688',
    '#4caf50',
    '#8bc34a',
    '#cddc39',
    '#ffc107',
    '#ff9800',
    '#ff5722'
  ]

  app.config.globalProperties.$hasRoles = (admitRoles) => {
    const userRoles = store.getters['users/auth/role']
    if (!userRoles) return false
    return userRoles.every(value => {
      return admitRoles.includes(value)
    })
  }

  app.config.globalProperties.$typesRol = TypesRol

  app.config.globalProperties.$getFisrtDay = () => {
    const actualDate = new Date()
    const dateObj = new Date(actualDate.getFullYear(), actualDate.getMonth(), 1)

    return date.formatDate(dateObj, app.config.globalProperties.$maskDate)
  }

  app.config.globalProperties.$getLastDay = () => {
    const actualDate = new Date()
    const dateObj = new Date(actualDate.getFullYear(), actualDate.getMonth() + 1, 0)

    return date.formatDate(dateObj, app.config.globalProperties.$maskDate)
  }

  app.config.globalProperties.$translateStatus = (status) => {
    if (status === statusOrder.assigned) {
      return i18n.global.t('requestPetitionStatus.assigned')
    }
    if (status === statusOrder.observed) {
      return i18n.global.t('requestPetitionStatus.observed')
    }
    if (status === statusOrder.inspectionAproved) {
      return i18n.global.t('requestPetitionStatus.inspectionAproved')
    }
    if (status === statusOrder.instalationAssigned) {
      return i18n.global.t('requestPetitionStatus.instalationAssigned')
    }
    if (status === statusOrder.interrnalInspection) {
      return i18n.global.t('requestPetitionStatus.interrnalInspection')
    }
    if (status === statusOrder.done) {
      return i18n.global.t('requestPetitionStatus.done')
    }
    if (status === statusOrder.store) {
      return i18n.global.t('requestPetitionStatus.stored')
    }
    if (status === statusOrder.rejected) {
      return i18n.global.t('requestPetitionStatus.rejected')
    }

    return 'Uknown'
  }

  app.config.globalProperties.$returnDateOptions = (dateBase, dateCompare, type) => {
    if (!dateCompare) {
      return true
    }
    let info
    info = dateBase <= dateCompare.split('/').reverse().join('/')
    if (type === 1) {
      info = dateBase >= dateCompare.split('/').reverse().join('/')
    }
    return info
  }
  app.config.globalProperties.$setColorDefaultVehicle = (status) => {
    if (status) {
      return 'yellow'
    }
    return 'grey'
  }

  app.config.globalProperties.$imageCompression = async (file, quality = 50, type = imageCompressionType.b64) => {
    return new Promise((resolve) => {
      const reader = new FileReader()
      reader.readAsDataURL(file)

      reader.onload = (event) => {
        const imageUrl = event.target.result
        const imageEl = document.createElement('img')
        imageEl.src = imageUrl

        imageEl.onload = (e) => {
          const canvas = document.createElement('canvas')
          canvas.width = imageEl.width
          canvas.height = imageEl.height

          const context = canvas.getContext('2d')
          context.drawImage(imageEl, 0, 0, canvas.width, canvas.height)
          const newImageUrl = context.canvas.toDataURL(
            'image/jpeg',
            quality / 100
          )
          if (type === imageCompressionType.b64) {
            resolve(newImageUrl)
            return
          }

          const blobBin = atob(newImageUrl.split(',')[1])
          const arrayData = []
          for (let i = 0; i < blobBin.length; i++) {
            arrayData.push(blobBin.charCodeAt(i))
          }
          resolve(new Blob([new Uint8Array(arrayData)], { type: 'image/jpeg' }))
        }
      }
    })
  }

  app.config.globalProperties.$imageSetBlobFromBase64 = (fileB64) => {
    const blobBin = atob(fileB64.split(',')[1])
    const arrayData = []
    for (let i = 0; i < blobBin.length; i++) {
      arrayData.push(blobBin.charCodeAt(i))
    }
    return (new Blob([new Uint8Array(arrayData)], { type: 'image/jpeg' }))
  }

  app.config.globalProperties.$imageRotate = async (imageSrc, degrees = 0, type = imageCompressionType.b64) => {
    return new Promise((resolve) => {
      const imageEl = new Image()
      imageEl.src = imageSrc

      imageEl.onload = (e) => {
        let size = imageEl.height
        if (size < imageEl.width) {
          size = imageEl.width
        }
        const canvas = document.createElement('canvas')
        canvas.height = size
        canvas.width = size

        const context = canvas.getContext('2d')

        context.save()
        context.clearRect(0, 0, canvas.width, canvas.height)
        context.translate(size / 2, size / 2)
        context.rotate(0.017453292519943295 * degrees)
        context.translate(-(size / 2), -(size / 2))
        context.drawImage(imageEl, canvas.width / 2 - imageEl.width / 2, canvas.height / 2 - imageEl.height / 2, imageEl.width, imageEl.height)
        context.restore()

        const newImageUrl = context.canvas.toDataURL(
          'image/png'
        )
        if (type === imageCompressionType.b64) {
          resolve(newImageUrl)
          return
        }

        const blobBin = atob(newImageUrl.split(',')[1])
        const arrayData = []
        for (let i = 0; i < blobBin.length; i++) {
          arrayData.push(blobBin.charCodeAt(i))
        }
        resolve(new Blob([new Uint8Array(arrayData)], { type: 'image/png' }))
      }
    })
  }

  app.config.globalProperties.$getCategoriesQuestionsOptions = (data) => {
    let response = ''
    if (data === 'customers') {
      response = i18n.global.t('options.questions_categories.customers')
    }
    if (data === 'drives') {
      response = i18n.global.t('options.questions_categories.drives')
    }
    if (data === 'vehicles') {
      response = i18n.global.t('options.questions_categories.vehicles')
    }
    if (data === 'general') {
      response = i18n.global.t('options.questions_categories.general')
    }
    return response
  }

  app.config.globalProperties.$percentageToStringFormat = (percentage) => {
    return `${percentage ?? 0}%`
  }

  app.config.globalProperties.$setStorageTables = (storageName, data) => {
    localStorage.setItem(storageName, JSON.stringify(data))
  }

  app.config.globalProperties.$getStorageTables = (storageName) => {
    return JSON.parse(localStorage.getItem(storageName))
  }

  app.config.globalProperties.$clearStorageTable = (storageName) => {
    localStorage.removeItem(storageName)
  }

  app.config.globalProperties.$manualsUrl = manualsUrl
})
