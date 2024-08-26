<template>
  <div class="row justify-center">
    <div class="col-sm-12 q-pa-md">
      <div class="row q-col-gutter-xs">
        <q-form ref="emailForm" class="col-sm-12">
          <q-input
            v-model="email"
            readonly
            filled
            :label="$t('fields.email')"
            v-on:keyup.enter="restore()"
            :rules="rules.email"
          />
        </q-form>
        <div class="col-sm-12 q-mt-sm pull-right">
          <q-btn
            color="primary"
            class="full-width"
            :label="$t('buttons.reTryEmail')"
            :loading="loading"
            @click="restore()"
          />
        </div>
        <div class="col-sm-12 q-mt-sm pull-left">
          <q-btn
            color="brown-5"
            :label="$t('buttons.back')"
            flat
            rounded
            @click="$emit('closeModal')"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex'

let self

export default {
  name: 'Login',
  data () {
    return {
      email: this.emailIn,
      loading: false
    }
  },
  props: {
    emailIn: String
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
    ...mapActions('users/userRecovery', ['reTryEmailVerification']),
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
        const response = await self.reTryEmailVerification(this.email)
        data = {
          message: self.$t(`messages.success.${response.data.message}`),
          result: response.data.result
        }
        this.$emit('closeModal')
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
