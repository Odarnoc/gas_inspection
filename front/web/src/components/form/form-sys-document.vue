<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="col-md-4 col-xs-12">
        <q-select
          filled
          type="text"
          v-model="document.fields.countryId"
          :label="$t('fields.country')"
          emit-value
          map-options
          :rules="rules.countryId"
          :options="options.countries"
          @update:model-value="filterUserTypeByCoauntry()"
        />
      </div>
      <div class="col-md-4 col-xs-12">
        <q-select
          filled
          v-model="document.fields.userTypeId"
          :label="$t('fields.userType')"
          map-options
          emit-value
          :options="options.userType"
        />
      </div>
      <div class="'col-md-12 col-xs-2">
        <q-checkbox v-model="document.fields.identifier" :label="$t('fields.identifier')" />
      </div>
      <div class="col-md-6 col-xs-12">
        <q-input
          filled
          type="text"
          v-model="document.fields.name"
          :rules="rules.name"
          :label="$t('fields.name')"
        />
      </div>
      <div class="col-md-6 col-xs-12">
        <q-input
          filled
          type="text"
          v-model="document.fields.description"
          :rules="rules.description"
          :label="$t('fields.description')"
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
      document: {
        fields: {
          id: null,
          name: '',
          description: '',
          image_document_id: null,
          image_url: null,
          countryId: null,
          identifier: false,
          userTypeId: null
        }
      },
      options: {
        countries: [],
        userType: []
      }
    }
  },
  props: {},
  computed: {
    rules () {
      return {
        name: [self.$rules.required(self.$t('validations.required.field'))],
        description: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        countryId: [self.$rules.required(self.$t('validations.required.field'))]
      }
    }
  },
  created () {
    self = this
  },
  mounted () {
    this.setCountriesOptions()
  },
  methods: {
    ...mapActions('system/countries', ['getCountries']),
    ...mapActions('system/userType', ['setUserOptionsByCountry']),
    async getData () {
      const isValid = await self.$refs.refForm.validate()
      const params = { ...self.document.fields }
      return {
        isValid: isValid,
        params: params
      }
    },
    setData (data) {
      self.document.fields = data
      self.document.fields.countryId = data.country ? data.country.id : null
      this.filterUserTypeByCoauntry()
      self.document.fields.userTypeId = data.userType ? data.userType.id : null
    },
    resetFields () {
      self.document.fields = {
        name: '',
        description: ''
      }
      self.$refs.refForm.resetValidation()
    },
    async setCountriesOptions () {
      const response = await self.getCountries()
      self.options.countries = response.data
    },
    async filterUserTypeByCoauntry () {
      const response = await self.setUserOptionsByCountry(
        self.document.fields.countryId
      )
      self.options.userType = response.data
      self.options.userType.unshift({ value: null, label: 'Ninguno' })
    }
  }
}
</script>
<style lang="sass">
</style>
