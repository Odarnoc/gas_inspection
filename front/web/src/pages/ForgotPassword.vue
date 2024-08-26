<template>
  <q-layout>
    <q-page-container class="page-background">
      <q-page>
        <div class="row justify-center q-mb-xl" style="padding-top: 5%;">
          <img src="statics/Logo.png" style="width: 192px;height: 192px" />
        </div>
        <div class="row justify-center">
          <div class="col-sm-4 q-pa-md">
            <div class="row q-col-gutter-xs">
              <q-form ref="emailForm" class="col-sm-12">
                <q-input
                  v-model="email"
                  standout
                  rounded
                  color="accent"
                  input-class="text-accent"
                  bg-color="white"
                  :label="$t('fields.email')"
                  v-on:keyup.enter="restore()"
                  :rules="rules.email"
                />
              </q-form>
              <div class="col-12 text-center self-center q-mt-sm">
                <q-btn
                  class="self-center"
                  color="secondary"
                  rounded
                  :label="$t('buttons.restore')"
                  :loading="loading"
                  @click="restore()"
                />
              </div>
              <div class="col-12 text-center self-center q-mt-sm">
                <q-btn
                  class="self-center"
                  color="white"
                  :label="$t('buttons.back')"
                  flat
                  rounded
                  to="/login"
                />
              </div>
            </div>
          </div>
        </div>
      </q-page>
    </q-page-container>
  </q-layout>
</template>

<script>
import { mapActions } from 'vuex'

let self

export default {
  name: 'Login',
  data () {
    return {
      email: null,
      loading: false
    }
  },
  created () {
    self = this
  },
  computed: {
    rules () {
      return {
        email: [
          self.$rules.required(self.$t('validations.required.email')),
          self.$rules.email(self.$t('validations.invalid_format.email'))
        ]
      }
    }
  },
  methods: {
    ...mapActions('users/userRecovery', ['requestPasswordByEmail']),
    async restore () {
      this.loading = true
      const isValid = await self.$refs.emailForm.validate()
      if (!isValid) {
        self.loading = false
        self.$destroyLoading()
        return
      }
      let data = {}
      try {
        const response = await self.requestPasswordByEmail(this.email)
        data = {
          message: self.$t(`messages.success.${response.data.message}`),
          result: response.data.result
        }
        this.$router.push('/login')
      } catch (error) {
        data = {
          message: self.$t(
            `messages.errorCode.${error?.response?.data?.codeError}`
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
