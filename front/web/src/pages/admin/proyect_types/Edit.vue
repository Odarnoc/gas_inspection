<template>
  <q-page>
    <header-pages activateButtonBreadCrum :breadCrumRoutes="breadCrumRoutes" />

    <div class="q-pa-md bg-grey-3">
      <div class="row bg-white border-panel q-pa-md">
        <div class="col-3" />
        <div class="col-12">
          <form-sys-user-type ref="documentForm" edit_flag />
        </div>
        <div class="col-12">
          <q-btn
            class="float-right"
            color="secondary"
            icon="save"
            :label="$t('buttons.update')"
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
  name: 'UserTypeEdit',
  data () {
    return {
      id: null,
      imageUrl: null
    }
  },
  created () {
    self = this
    self.id = this.$decode(this.$route.params.id)
  },
  mounted () {
    self.fetchFromServer()
  },
  computed: {
    breadCrumRoutes () {
      return [self.$t('menus.proyect_type'), self.$t('buttons.edit')]
    }
  },
  methods: {
    ...mapActions('admin/proyectTypes', ['get', 'update']),
    async fetchFromServer () {
      self.$showLoading()
      const response = await self.get(self.id)
      const data = response.data
      self.$refs.documentForm.setData(data.data)
      self.$destroyLoading()
    },
    async save () {
      self.loading = true
      self.$showLoading()
      const formResult = await self.$refs.documentForm.getData()
      if (!formResult.isValid) {
        self.loading = false
        self.$destroyLoading()
        return
      }
      const params = { ...formResult.params }
      let data = {}
      try {
        const response = await self.update(params)
        data = {
          message: self.$t(`messages.success.${response.data.message}`),
          result: response.data.result
        }
        await self.fetchFromServer()
      } catch (error) {
        data = {
          message: self.$t(
            `messages.errorCode.${error.response.data.codeError}`
          ),
          result: false
        }
      }
      self.$showNotifyMessage(data)
      self.$destroyLoading()
      self.loading = false
    }
  }
}
</script>

<style>
</style>
