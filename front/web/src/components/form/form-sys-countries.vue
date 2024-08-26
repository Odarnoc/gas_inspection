<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="'col-md-12 col-xs-2">
        <q-input
          filled
          type="text"
          v-model="countries.fields.code"
          :rules="rules.code"
          :label="$t('fields.code')"
        />
      </div>
      <div class="'col-md-12 col-xs-4">
        <q-input
          filled
          type="text"
          v-model="countries.fields.name"
          :rules="rules.name"
          :label="$t('fields.name')"
        />
      </div>
      <div class="'col-md-12 col-xs-2">
        <q-input
          filled
          type="text"
          v-model="countries.fields.currency"
          :rules="rules.currency"
          :label="$t('fields.currency')"
        />
      </div>
      <div class="'col-md-12 col-xs-2">
        <q-input
          filled
          type="text"
          v-model="countries.fields.currency_symbol"
          :rules="rules.currency_symbol"
          :label="$t('fields.currency_symbol')"
        />
      </div>
      <div class="'col-md-12 col-xs-2">
        <q-input
          filled
          type="text"
          v-model="countries.fields.minStripeAmount"
          :rules="rules.minStripeAmount"
          :label="$t('fields.minStripeAmount')"
        />
      </div>
      <div class="'col-md-12 col-xs-2">
        <q-checkbox
          filled
          type="text"
          v-model="countries.fields.isActive"
          :rules="rules.isActive"
          :label="$t('fields.active')"
        />
      </div>
      <slot name="actions"></slot>
    </div>
  </q-form>
</template>

<script>
let self
export default {
  name: 'base-table',
  data () {
    return {
      countries: {
        fields: {
          id: null,
          code: '',
          name: '',
          currency: '',
          currency_symbol: '',
          minStripeAmount: 0,
          isActive: false
        }
      }
    }
  },
  props: { edit_flag: Boolean },
  computed: {
    rules () {
      return {
        code: [self.$rules.required(self.$t('validations.required.field'))],
        name: [self.$rules.required(self.$t('validations.required.field'))],
        currency: [self.$rules.required(self.$t('validations.required.field'))],
        currency_symbol: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        minStripeAmount: [
          self.$rules.required(self.$t('validations.required.field')),
          self.$rules.minValue(1, self.$t('validations.value.minValue', [0]))
        ],
        isActive: [self.$rules.required(self.$t('validations.required.field'))]
      }
    }
  },
  created () {
    self = this
  },
  methods: {
    async getData () {
      const isValid = await self.$refs.refForm.validate()
      const params = { ...self.countries.fields }
      return {
        isValid: isValid,
        params: params
      }
    },
    setData (data) {
      self.countries.fields = data
    },
    resetFields () {
      self.countries.fields = {
        name: '',
        isActive: false
      }
      self.$refs.refForm.resetValidation()
    }
  }
}
</script>
<style lang="sass">
</style>
