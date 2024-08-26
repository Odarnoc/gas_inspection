<template>
  <q-form ref="regForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="col-6">
        <q-select
          filled
          type="text"
          v-model="user.fields.countryId"
          :label="$t('fields.country')"
          emit-value
          map-options
          :rules="rules.countryId"
          :options="options.countries"
          @update:model-value="filteredStatesByCountry()"
        />
      </div>
      <div class="col-6">
        <q-select
          filled
          v-model="user.fields.state"
          :label="$t('fields.state')"
          map-options
          emit-value
          :options="options.states"
          @update:model-value="filteredCitiesByState()"
          :rules="rules.state"
        ></q-select>
      </div>
      <div class="col-6">
        <q-select
          filled
          v-model="user.fields.cityId"
          :label="$t('fields.city')"
          map-options
          emit-value
          :options="options.cities"
          :rules="rules.cityId"
        />
      </div>
      <div class="col-6">
        <q-select
          filled
          v-model="user.fields.code"
          :label="$t('fields.groups')"
          map-options
          emit-value
          :options="computedOptions(options.groups)"
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
      user: {
        fields: {
          code: null,
          cityId: null,
          state: null,
          countryId: null
        }
      },
      options: {
        groups: [],
        cities: [],
        states: [],
        countries: []
      }
    }
  },
  props: {
    roles: Array
  },
  computed: {
    computedOptions () {
      return (options) => [
        { value: null, label: this.$t('options.not_apply') },
        ...options
      ]
    },
    rules () {
      return {
        countryId: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        state: [self.$rules.required(self.$t('validations.required.field'))],
        cityId: [self.$rules.required(self.$t('validations.required.field'))]
      }
    }
  },
  created () {
    self = this
  },
  mounted () {},
  methods: {
    ...mapActions('system/groups', ['getGroups']),
    ...mapActions('system/cities', ['getCitiesByStateOptions']),
    ...mapActions('system/states', [
      'getStates',
      'getStatesByCountriesOptions'
    ]),
    ...mapActions('system/countries', ['getCountries']),
    async getData () {
      const params = { ...self.user.fields }
      if (self.user.fields.password !== self.user.fields.verifyPassword) {
        const data = {
          message: self.$t('messages.errorSpecific.parallelPassword'),
          result: false
        }
        self.$showNotifyMessage(data)
        self.loading = false
        self.$destroyLoading()
        return {
          isValid: false,
          params: params
        }
      } else {
        const isValid = await self.$refs.regForm.validate()
        return {
          isValid: isValid,
          params: params
        }
      }
    },
    async setData (data) {
      self.user.fields = data
      if (data.groups) {
        self.isCode = true
        self.user.fields.code = data.groups.name + ' - ' + data.groups.code
      }
      if (data.city) {
        self.user.fields.cityId = data.city.id
        if (data.city.state) {
          self.user.fields.state = data.city.state.id
        }
      }
      if (data.country) {
        self.user.fields.countryId = data.country.id
      }
      await this.setGroupOptions()
      await this.setStateOptions()
      await this.setCountriesOptions()
    },
    async setGroupOptions () {
      const response = await self.getGroups()
      self.options.groups = response.data
    },
    async setCitiesOptions (stateId) {
      const response = await self.getCitiesByStateOptions(stateId)
      self.options.cities = response.data
    },
    async setStateOptions () {
      const response = await self.getStatesByCountriesOptions(
        self.user.fields.countryId
      )
      self.options.states = response.data
    },
    async setCountriesOptions () {
      const response = await self.getCountries()
      self.options.countries = response.data
    },
    async setUserByCountryOptions (countryId) {
      const response = await self.setUserOptionsByCountry(countryId)
      self.options.userType = response.data
    },
    filteredStatesByCountry () {
      self.options.cities = []
      self.$showLoading()
      this.setUserByCountryOptions(self.user.fields.countryId)
      self.setStateOptions()
      self.user.fields.state = null
      self.user.fields.cityId = null
      self.user.fields.userTypeId = null
      self.$destroyLoading()
    },
    filteredCitiesByState () {
      self.options.cities = []
      self.$showLoading()
      self.setCitiesOptions(self.user.fields.state)
      self.user.fields.cityId = null
      self.$destroyLoading()
    }
  }
}
</script>
<style lang="sass">
</style>
