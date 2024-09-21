<template>
  <div class="row q-col-gutter-xs">
    <div class="col-12 q-px-md q-pt-md" style="font-size: 20px">{{ $t('buttons.changePassword') }}</div>
    <div class="col-12 q-pa-md">
      <q-input
        filled
        :type="isPwd ? 'password' : 'text'"
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
    <div class="col-12 q-px-md q-pb-md pull-right">
      <q-btn
        color="primary"
        class="full-width"
        :label="$t('buttons.update')"
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
  props: {
    userId: Number,
    isProfile: Boolean
  },
  created () {
    self = this
  },
  methods: {
    ...mapActions('users/auth', ['updatePasswordByUserId']),
    async updateData () {
      this.$showLoading()
      try {
        const response = await this.updatePasswordByUserId({
          userId: +this.userId,
          password: this.user.fields.password
        })
        this.$showNotifySuccess(response)
        this.$emit('onPasswordUpdated')
      } catch (error) {
        this.$showNotifyError(error)
      }
      this.$destroyLoading()
    }
  }
}
</script>
<style lang="sass">
</style>
