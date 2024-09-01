<template>
  <q-page>
    <header-pages activateButtonBreadCrum :breadCrumRoutes="breadCrumRoutes" />

    <div class="q-pa-md bg-grey-3">
      <div class="row bg-white border-panel q-pa-md">
        <div class="col-12">
          <form-proyect-type ref="regForm" :roles="roles" :initRole="1"></form-proyect-type>
        </div>
        <div class="col-12">
          <q-btn
            class="float-right"
            color="secondary"
            icon="save"
            :label="$t('buttons.save')"
            @click="save"
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
      return [self.$t('menus.proyect_type'), self.$t('buttons.new')]
    }
  },
  mounted () {},
  created () {
    self = this
  },
  methods: {
    ...mapActions('admin/proyectTypes', ['create']),
    async save () {
      self.loading = true
      self.$showLoading()
      const formResult = await self.$refs.regForm.getData()
      if (!formResult.isValid) {
        self.loading = false
        self.$destroyLoading()
        return
      }
      const params = { ...formResult.params }
      try {
        const response = await self.create(params)
        this.$showNotifySuccess(response)
        self.$router.push('/proyectTypes')
      } catch (error) {
        this.$showNotifyError(error)
      }
      self.$destroyLoading()
      self.loading = false
    }
  }
}
</script>

<style>
</style>
