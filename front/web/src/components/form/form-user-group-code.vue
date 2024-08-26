<template>
  <div class="row q-col-gutter-xs">
    <div class="col-12 q-px-md q-pt-md" style="font-size: 20px">Código de invitación</div>
    <div class="col-12 q-px-md">
      <q-input
        filled
        v-model="user.fields.code"
        :rules="rules.code"
        :label="$t('fields.code_register')"
      ></q-input>
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
          code: ''
        }
      }
    }
  },
  computed: {
    rules () {
      return {
        code: [self.$rules.required(self.$t('validations.required.field'))]
      }
    }
  },
  created () {
    self = this
  },
  methods: {
    ...mapActions('users/users', ['updateGroup']),
    async updateData () {
      let data = {}
      const params = { ...self.user.fields }
      self.$showLoading()
      try {
        const response = await self.updateGroup(params)
        data = {
          message: self.$t(`messages.success.${response.data.message}`),
          result: response.data.result
        }
        this.$emit('onCodeAdding')
      } catch (error) {
        data = {
          message: self.$t(
            `messages.errorCode.${
              error.response.data.codeError
                ? error.response.data.codeError
                : error.response.data.message[0]
            }`
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
