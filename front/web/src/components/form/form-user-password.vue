<template>
    <div class="row q-col-gutter-xs">
      <div class="col-12 q-px-md q-pt-md" style="font-size: 20px">Actualizar contraseña</div>
      <div class="col-12 q-pa-md">
        <q-input
          filled
          :type="isPwd ? 'password' : 'text'"
          :readonly="readonly"
          v-model="user.fields.password"
          :rules="rules.password"
          :label="$t('fields.password')"
        >
          <template v-slot:append>
            <q-icon
              :name="isPwd ? 'visibility_off' : 'visibility'"
              class="cursor-pointer"
              @click="isPwd = !isPwd"
            />
          </template>
        </q-input>
      </div>
      <div class="col-12 q-px-md">
        <q-input
          filled
          :type="isVerPwd ? 'password' : 'text'"
          :readonly="readonly"
          v-model="user.fields.veryfiedPassword"
          :rules="rules.veryfiedPassword"
          :label="$t('fields.verifyPassword')"
          @keydown.enter.prevent="updateData()"
        >
          <template v-slot:append>
            <q-icon
              :name="isVerPwd ? 'visibility_off' : 'visibility'"
              class="cursor-pointer"
              @click="isVerPwd = !isVerPwd"
            />
          </template>
        </q-input>
      </div>
      <div class="col-12 q-px-md q-pb-md pull-right">
        <q-btn
          color="primary"
          class="full-width"
          :label="$t('buttons.update')"
          :loading="loading"
          @click="updateData()"
        />
      </div>
    </div>
</template>

<script>
import { mapActions } from 'vuex'
let self
export default {
  name: 'base-table',
  data () {
    return {
      user: {
        fields: {
          password: '',
          veryfiedPassword: ''
        }
      },
      isPwd: true,
      isVerPwd: true
    }
  },
  computed: {
    rules () {
      return {
        password: [self.$rules.required(self.$t('validations.required.field'))],
        veryfiedPassword: [
          self.$rules.required(self.$t('validations.required.field'))
        ]
      }
    }
  },
  created () {
    self = this
  },
  methods: {
    ...mapActions('users/userRecovery', ['changePassword']),
    async updateData () {
      let data = {}
      if (self.user.fields.password !== self.user.fields.veryfiedPassword) {
        data = {
          message: self.$t('messages.errorSpecific.parallelPassword'),
          result: false
        }
        self.$showNotifyMessage(data)
        self.$destroyLoading()
        self.loading = false
        return
      }
      const params = { ...self.user.fields }
      self.$showLoading()
      try {
        const response = await self.changePassword(params)
        data = {
          message: self.$t(`messages.success.${response.data.message}`),
          result: response.data.result
        }
        localStorage.removeItem('passwordFlag')
        this.$emit('onPasswordUpdated')
      } catch (error) {
        data = {
          message: self.$t(
            `messages.errorCode.${error.response.data.codeError ? error.response.data.codeError : error.response.data.message[0]}`
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
<style lang="sass">
</style>
