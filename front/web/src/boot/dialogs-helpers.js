import { boot } from 'quasar/wrappers'
import { Dialog, Loading, QSpinnerCube, Notify } from 'quasar'
import { i18n } from 'src/boot/i18n'

export default boot(({ app, ssrContext }) => {
  app.config.globalProperties.$showMessage = (
    title,
    message,
    persistent = false,
    ok = true
  ) => {
    Dialog.create({
      title: title,
      message: message,
      persistent: persistent,
      ok: ok ? {
        color: 'green',
        label: i18n.global.t('buttons.accept')
      } : ok
    })
  }

  // show loading
  app.config.globalProperties.$showLoading = () => {
    Loading.show({
      spinner: QSpinnerCube,
      spinnerColor: 'primary',
      spinnerSize: 140,
      backgroundColor: 'white',
      message: i18n.global.t('dialogs.loading'),
      messageColor: 'black'
    })
  }

  // hide loading
  app.config.globalProperties.$destroyLoading = () => {
    Loading.hide()
  }

  // general notify
  app.config.globalProperties.$showNotifyMessage = (data) => {
    Notify.create({
      message: data.message,
      timeout: 3000,
      color: data.result ? 'green' : 'orange',
      textColor: 'white', // if default 'white' doesn't fits
      icon: data.result ? 'done' : 'error',
      position: 'top-right' // 'top', 'left', 'bottom-left' etc
    })
  }

  app.config.globalProperties.$showNotifySuccess = (response) => {
    if (response?.data?.message) {
      app.config.globalProperties.$showNotifyMessage({
        result: true,
        message: response.data.message
      })
    }
  }

  app.config.globalProperties.$showNotifyError = (error) => {
    const data = {
      result: false,
      message: i18n.global.t('messages.errorSpecific.errUnknown')
    }
    if (error?.response?.data?.message) {
      data.message = error.response.data.message
    }
    app.config.globalProperties.$showNotifyMessage(data)
  }

  // confirm dialog
  app.config.globalProperties.$confirmDialog = (message) => {
    return new Promise((resolve, reject) => {
      Dialog.create({
        title: i18n.global.t('buttons.confirm'),
        message: message,
        persistent: true,
        ok: {
          color: 'green',
          label: i18n.global.t('buttons.confirm')
        },
        cancel: {
          color: 'red',
          label: i18n.global.t('buttons.cancel')
        }
      }).onOk(async () => {
        resolve(true)
      }).onCancel(() => {
        resolve(false)
      })
    })
  }
})
