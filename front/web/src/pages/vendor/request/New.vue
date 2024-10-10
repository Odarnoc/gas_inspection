<template>
  <q-page>
    <header-pages activateButtonBreadCrum :breadCrumRoutes="breadCrumRoutes" />

    <div class="q-pa-md bg-grey-3">
      <div class="row bg-white border-panel q-pa-md">
        <div class="col-12">
          <form-request ref="regForm" :roles="roles" :initRole="1"></form-request>
        </div>
        <div class="col-12">
          <q-btn
            class="float-right"
            color="secondary"
            icon="save"
            :label="$t('buttons.save')"
            @click="save"
          />
          <q-btn
            class="float-right q-mr-sm"
            color="warning"
            icon="clear"
            :label="$t('buttons.clear')"
            @click="clear"
          />
        </div>
      </div>
    </div>
  </q-page>
</template>

<script>
import { mapActions } from 'vuex'

let self
export default {
  name: 'UserTypeNew',
  data () {
    return {}
  },
  computed: {
    breadCrumRoutes () {
      return [self.$t('menus.requests'), self.$t('buttons.new')]
    }
  },
  mounted () {},
  created () {
    self = this
  },
  methods: {
    ...mapActions('vendor/requestPetition', ['create']),
    async save () {
      self.loading = true
      self.$showLoading()
      const formResult = await self.$refs.regForm.getData()
      if (!formResult.isValid) {
        self.loading = false
        self.$destroyLoading()
        return
      }
      if (
        !formResult.params.identityCard ||
        !formResult.params.waterBill ||
        !formResult.params.electricityBill ||
        !formResult.params.realFolio
      ) {
        this.$destroyLoading()
        this.$showMessage(
          'Advertencia',
          'Asegúrate de subir todos los documentos solicitados para poder continuar'
        )
        return
      }
      const params = { ...formResult.params }
      try {
        const response = await self.create(params)
        this.$showNotifySuccess(response)
        self.$router.push('/request')
      } catch (error) {
        this.$showNotifyError(error)
      }
      self.$destroyLoading()
      self.loading = false
    },
    async clear () {
      self.$refs.regForm.resetFields()
    }
  }
}
</script>

<style>
</style>
