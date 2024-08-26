<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="'col-md-12 col-xs-6">
        <q-input
          filled
          type="text"
          v-model="advertising.fields.company"
          :rules="rules.company"
          :label="$t('fields.company')"
        />
      </div>
      <div class="'col-md-12 col-xs-6">
        <q-input
          filled
          type="text"
          v-model="advertising.fields.title"
          :rules="rules.title"
          :label="$t('fields.title')"
        />
      </div>
      <div class="'col-md-12 col-xs-12">
        <q-input
          filled
          type="text"
          v-model="advertising.fields.description"
          :rules="rules.description"
          :label="$t('fields.description')"
        />
      </div>
      <div class="'col-md-12 col-xs-2">
        <q-input
          filled
          type="text"
          v-model="advertising.fields.phone"
          :rules="rules.phone"
          :label="$t('fields.phone')"
        />
      </div>
      <div class="'col-md-12 col-xs-3">
        <q-input
          filled
          type="text"
          v-model="advertising.fields.email"
          :rules="rules.email"
          :label="$t('fields.email')"
        />
      </div>
      <div class="'col-md-12 col-xs-2">
        <q-select
          filled
          type="text"
          v-model="advertising.fields.country.id"
          :label="$t('fields.country')"
          emit-value
          map-options
          :rules="rules.country"
          :options="options.countries"
        />
      </div>
      <div class="'col-md-12 col-xs-4">
        <q-input
          filled
          type="text"
          v-model="advertising.fields.address"
          :rules="rules.address"
          :label="$t('fields.address')"
        />
      </div>
      <slot name="actions"></slot>
    </div>
  </q-form>
</template>

<script>
import { mapActions } from 'vuex'

let self
export default {
  name: 'base-table',
  data () {
    return {
      advertising: {
        fields: {
          id: null,
          company: '',
          title: '',
          description: '',
          phone: '',
          email: '',
          address: '',
          country: {
            id: null
          }
        }
      },
      options: {
        countries: []
      }
    }
  },
  props: { edit_flag: Boolean },
  computed: {
    rules () {
      return {
        company: [self.$rules.required(self.$t('validations.required.field'))],
        title: [self.$rules.required(self.$t('validations.required.field'))],
        description: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        phone: [
          self.$rules.required(self.$t('validations.required.field')),
          self.$rules.numeric(self.$t('validations.numeric.field'))
        ],
        email: [
          self.$rules.required(self.$t('validations.required.field')),
          self.$rules.email(self.$t('validations.invalid_format.email'))
        ],
        address: [self.$rules.required(self.$t('validations.required.field'))],
        country: [self.$rules.required(self.$t('validations.required.field'))]
      }
    }
  },
  created () {
    self = this
  },
  mounted () {
    this.getCountriesOptions()
  },
  methods: {
    ...mapActions('system/countries', ['getCountries']),
    async getData () {
      const isValid = await self.$refs.refForm.validate()
      const params = { ...self.advertising.fields }
      return {
        isValid: isValid,
        params: params
      }
    },
    setData (data) {
      self.advertising.fields = data
    },
    resetFields () {
      self.advertising.fields = {
        name: '',
        country: {
          id: ''
        }
      }
      self.$refs.refForm.resetValidation()
    },
    async getCountriesOptions () {
      self.$showLoading()
      const response = await self.getCountries()
      self.options.countries = response.data
      self.$destroyLoading()
    }
  }
}
</script>
<style lang="sass">
</style>
