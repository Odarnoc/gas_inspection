<template>
  <q-page>
    <header-pages activateButtonBreadCrum :breadCrumRoutes="breadCrumRoutes" />

    <div class="q-pa-md bg-grey-3">
      <div class="row bg-white border-panel q-pa-md">
        <div class="col-3" />
        <div class="col-12">
          <form-request ref="documentForm" edit_flag />
        </div>
        <div class="col-12">
          <q-btn
            v-if="status == statusOrder.observed"
            class="float-right q-mr-md"
            color="primary"
            icon="save"
            :label="$t('buttons.saveAndReassign')"
            @click="saveAndReassign"
          />
          <q-btn
            v-if="status != statusOrder.rejected"
            class="float-right q-mr-md"
            color="secondary"
            icon="save"
            :label="$t('buttons.update')"
            @click="save"
          />
          <q-btn
            v-if="status == statusOrder.observed"
            class="float-right q-mr-md"
            color="negative"
            icon="delete"
            :label="$t('buttons.reject')"
            @click="reject"
          />
        </div>
      </div>
    </div>
  </q-page>
</template>

<script>
import { statusOrder } from 'src/commons/status'
import { mapActions } from 'vuex'

let self
export default {
  name: 'UserTypeEdit',
  data () {
    return {
      id: null,
      imageUrl: null,
      status: null,
      statusOrder: {
        ...statusOrder
      }
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
      return [self.$t('menus.requests'), self.$t('buttons.edit')]
    }
  },
  methods: {
    ...mapActions('vendor/requestPetition', ['get', 'update']),
    async fetchFromServer () {
      self.$showLoading()
      const response = await self.get(self.id)
      const data = response.data
      self.$refs.documentForm.setData(data.data)
      this.status = data.data.status
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
      try {
        const response = await self.update(params)
        this.$showNotifySuccess(response)
        await self.fetchFromServer()
      } catch (error) {
        this.$showNotifyError(error)
      }
      self.$destroyLoading()
      self.loading = false
    },
    async saveAndReassign () {
      self.loading = true
      self.$showLoading()
      const formResult = await self.$refs.documentForm.getData()
      if (!formResult.isValid) {
        self.loading = false
        self.$destroyLoading()
        return
      }
      const params = { ...formResult.params, status: statusOrder.assigned }
      try {
        const response = await self.update(params)
        this.$showNotifySuccess(response)
        await self.fetchFromServer()
      } catch (error) {
        this.$showNotifyError(error)
      }
      self.$destroyLoading()
      self.loading = false
    },
    async reject () {
      self.loading = true
      self.$showLoading()
      const formResult = await self.$refs.documentForm.getData()
      if (!formResult.isValid) {
        self.loading = false
        self.$destroyLoading()
        return
      }
      const params = { ...formResult.params, status: statusOrder.rejected }
      try {
        const response = await self.update(params)
        this.$showNotifySuccess(response)
        await self.fetchFromServer()
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
