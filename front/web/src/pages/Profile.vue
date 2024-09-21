<template>
  <q-layout>
    <q-page-container style="background-color: #f5f5f5;">
      <q-page>
        <div class="row q-py-xl">
          <div class="col-12">
            <q-card class="justify-center q-pa-md" flat bordered round>
              <div class="row">
                <div class="col-12 q-pt-md">
                  <form-user-profile ref="regForm" />
                </div>
                <div class="col-sm-12 col-md-12 col-xs-12 q-pa-md" align="center">
                  <q-btn
                    color="primary"
                    :label="$t('buttons.changePassword')"
                    :loading="loading"
                    @click="passwordModal = true"
                  />
                </div>
              </div>
            </q-card>
          </div>
        </div>
      </q-page>

      <q-dialog v-model="passwordModal">
        <q-card style="min-width: 30wv;">
          <form-user-password @onPasswordUpdated="passwordModal = false" :userId="id" />
        </q-card>
      </q-dialog>
    </q-page-container>
  </q-layout>
</template>

<script>
import { GENERAL_ROUTES } from 'src/commons/filesRoutes'
import { mapActions } from 'vuex'

let self

export default {
  name: 'Login',
  data () {
    return {
      id: null,
      passwordModal: false,
      loading: false,
      editGeneralData: false,
      editPayMethods: true,
      userImage: null,
      showBalance: null,
      showGiftBalance: null,
      showTotalBalance: null,
      userImageRequest: false,
      addGroupCode: false,
      codeGroup: null,
      flags: {
        wallet: false
      }
    }
  },
  created () {
    self = this
    if (localStorage.getItem('passwordFlag')) {
      this.passwordModal = true
    }
  },
  mounted () {
    self.fetchFromServer()
  },
  computed: {
    breadCrumRoutes () {
      return [
        self.$t('menus.vehicle_documents'),
        self.$t('titles.edit_document')
      ]
    },
    createFileRoute () {
      return `${GENERAL_ROUTES.user}${self.id}/${self.id}`
    }
  },
  methods: {
    ...mapActions('users/auth', ['getProfile', 'update']),
    async fetchFromServer () {
      this.$showLoading()
      const response = await self.getProfile()
      self.userImageRequest = response.data.isImageRequested
      if (response.data.groups) {
        self.codeGroup =
          response.data.groups.name + ' - ' + response.data.groups.code
      }
      const data = response.data
      if (response.data.city) {
        data.state = response.data.city.state.id
      }
      self.id = data.id
      self.userImage = data.isImageVerified ? data.image : data.imageToChange
      self.$refs.regForm.setData(data)
      self.showBalance = self.$formatNumber(self.balance)
      self.showGiftBalance = self.$formatNumber(self.gift)
      self.showTotalBalance = self.$formatNumber(self.balance + self.gift)
      this.$destroyLoading()
    },
    async updateData () {
      self.$showLoading()
      const formResult = await self.$refs.regForm.getData()
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
        self.editGeneralData = true
        self.$emit('onPasswordUpdated')
      } catch (error) {
        data = {
          message: self.$t(
            `messages.errorCode.${error.response.data.codeError}`
          ),
          result: false
        }
      }
      await self.$showNotifyMessage(data)
      await self.$destroyLoading()
    },
    async updateUrlImage (updateUrlImage) {
      await self.$showLoading()
      const params = {
        image: updateUrlImage,
        isImageRequested: false,
        isImageUpdate: true
      }
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
      await self.$showNotifyMessage(data)
      await self.$destroyLoading()
    }
  }
}
</script>

<style>
</style>
