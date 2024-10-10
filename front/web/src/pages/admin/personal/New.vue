<template>
  <q-page>
    <header-pages activateButtonBreadCrum :breadCrumRoutes="breadCrumRoutes" />

    <div class="q-pa-md bg-grey-3">
      <div class="row bg-white border-panel q-pa-md">
        <div class="col-12">
          <form-user ref="regForm" :roles="roles" :initRole="1"></form-user>
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
      return [self.$t('menus.personal'), self.$t('buttons.new')]
    }
  },
  mounted () {},
  created () {
    self = this
  },
  methods: {
    ...mapActions('users/auth', ['create']),
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
        if (response?.data?.user?.id) {
          this.$router.push(
            `/personal/edit/${this.$encode(response?.data?.user?.id)}`
          )
        } else {
          self.$router.push('/personal')
        }
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
