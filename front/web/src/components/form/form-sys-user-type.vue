<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="'col-md-12 col-xs-3">
        <q-select
          filled
          type="text"
          v-model="state.fields.country.id"
          :label="$t('fields.country')"
          emit-value
          map-options
          :rules="rules.country"
          :options="options.countries"
        />
      </div>
      <div class="'col-md-12 col-xs-9">
        <q-input
          filled
          type="text"
          v-model="state.fields.name"
          :rules="rules.name"
          :label="$t('fields.name')"
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
      state: {
        fields: {
          id: null,
          country: {
            id: null
          },
          name: ''
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
        name: [self.$rules.required(self.$t('validations.required.field'))],
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
      const params = { ...self.state.fields }
      return {
        isValid: isValid,
        params: params
      }
    },
    setData (data) {
      self.state.fields = data
    },
    resetFields () {
      self.state.fields = {
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
