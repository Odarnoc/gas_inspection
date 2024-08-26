<template>
  <q-form ref="regForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="col-12">
        <q-select
          filled
          :options="roles"
          v-model="user.fields.rol"
          @update:model-value="onRoleChange()"
          map-options
          emit-value
          :label="$t('fields.user_type')"
          v-if="!user.fields.id"
          :rules="rules.roles"
        />
      </div>
      <div class="col-12">
        <q-input
          filled
          type="text"
          :readonly="readonly || edit"
          v-model="user.fields.fullName"
          :rules="rules.fullName"
          :label="$t('fields.fullName')"
        />
      </div>
      <div class="col-12">
        <q-input
          filled
          type="email"
          :readonly="readonly || edit || updateDataDrivers || updateDataUsers"
          v-model="user.fields.email"
          :rules="rules.email"
          :label="$t('fields.email')"
        />
      </div>
      <div class="col-12" v-if="!user.fields.id && !edit">
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
      <div class="col-12" v-if="!user.fields.id && !edit">
        <q-input
          filled
          :type="isPwd ? 'password' : 'text'"
          :readonly="readonly"
          v-model="user.fields.verifyPassword"
          :rules="rules.verifyPassword"
          :label="$t('fields.verifyPassword')"
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
      <div class="col-12">
        <q-input
          filled
          type="tel"
          :readonly="readonly || edit || updateDataDrivers || updateDataUsers"
          v-model="user.fields.phone"
          :rules="rules.phone"
          :label="$t('fields.phone')"
          mask="##########"
        />
      </div>
      <div class="col-12" v-if="$hasRoles([$typesRol.super_admin]) && updateDataDrivers">
        <q-input filled v-model="user.fields.rfc" :label="$t('fields.rfc')" :rules="rules.rfc" />
      </div>
      <div class="'col-md-12 col-xs-12" v-if="!isGroupActive">
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
          :readonly="readonly || edit || updateDataDrivers || updateDataUsers"
        />
      </div>
      <div
        class="col-12"
        v-if="($hasRoles([$typesRol.deliveryman]) || (user.fields.rol === 4)) && user.fields.roles !== $typesRol.client "
      >
        <q-select
          filled
          v-model="user.fields.state"
          :label="$t('fields.state')"
          :readonly="readonly || edit"
          map-options
          emit-value
          :options="options.states"
          @update:model-value="filteredCitiesByState()"
          :rules="rules.state"
        ></q-select>
      </div>
      <div
        class="col-12"
        v-if="($hasRoles([$typesRol.deliveryman]) || (user.fields.rol === 4)) && user.fields.roles !== $typesRol.client "
      >
        <q-select
          filled
          v-model="user.fields.cityId"
          :label="$t('fields.city')"
          :readonly="readonly || edit"
          map-options
          emit-value
          :options="options.cities"
          :rules="rules.cityId"
        />
      </div>
      <div
        class="col-12"
        v-if="$hasRoles([$typesRol.deliveryman]) && options.userType.length > 0 || (user.fields.rol === 4) && user.fields.roles !== $typesRol.client && options.userType.length > 0"
      >
        <q-select
          filled
          v-model="user.fields.userTypeId"
          :label="$t('fields.userType')"
          :readonly="readonly || edit"
          map-options
          emit-value
          :options="options.userType"
          :rules="rules.userType"
        />
      </div>
      <div
        class="col-12"
        v-if="$hasRoles([$typesRol.deliveryman]) && isCode && !edit || user.fields.rol === 4 && !edit"
      >
        <q-checkbox class="q-pr-sm" v-model="isCodeAdd" :label="$t('fields.invitation_code')" />
      </div>
      <div
        class="col-12 q-py-md"
        v-if="$hasRoles([$typesRol.deliveryman]) && isCode && isCodeAdd || user.fields.rol === 4 && isCodeAdd"
      >
        <q-input
          filled
          v-model="user.fields.code"
          :label="$t('fields.code_register')"
          :readonly="readonly || edit"
        />
      </div>
      <div
        class="col-12"
        v-if="$hasRoles([$typesRol.super_admin]) && !disabled && !updateDataDrivers && !updateDataUsers && !saForm"
      >
        <q-select
          filled
          v-model="user.fields.code"
          :label="$t('fields.groups')"
          :readonly="readonly || edit"
          map-options
          emit-value
          :options="computedOptions(options.groups)"
        />
      </div>
      <div class="col-12" v-if="!edit && (user.fields.rol === 4 || user.fields.rol === 3)">
        <q-checkbox
          class="q-pr-sm"
          v-model="user.fields.privacyPolicies"
          :label="$t('fields.privacyPoliciesText')"
        />
        <a class="q-pt-sm" href="/privacyPolicy" target="_blank">{{ $t('fields.privacyPolicies') }}</a>
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
          rol: null,
          fullName: '',
          email: '',
          password: '',
          verifyPassword: '',
          phone: '',
          code: null,
          cityId: null,
          roles: '',
          privacyPolicies: false,
          state: null,
          countryId: null,
          userTypeId: null
        }
      },
      isPwd: true,
      isCode: false,
      isCodeAdd: false,
      isGroupActive: true,
      options: {
        groups: [],
        cities: [],
        states: [],
        countries: [],
        userType: []
      }
    }
  },
  props: {
    initRole: Number,
    roles: Array,
    readonly: Boolean,
    edit: Boolean,
    disabled: Boolean,
    updateDataDrivers: Boolean,
    updateDataUsers: Boolean,
    saForm: Boolean
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
        roles: [self.$rules.required(self.$t('validations.required.field'))],
        fullName: [self.$rules.required(self.$t('validations.required.field'))],
        email: [
          self.$rules.required(self.$t('validations.required.email')),
          self.$rules.email(self.$t('validations.invalid_format.email'))
        ],
        password: [self.$rules.required(self.$t('validations.required.field'))],
        verifyPassword: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        phone: [
          self.$rules.required(self.$t('validations.required.field')),
          self.$rules.numeric(
            self.$t('validations.invalid_format.field_numeric')
          ),
          self.$rules.minLength(
            10,
            self.$t('validations.length.field_10_number')
          )
        ],
        countryId: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        state: [self.$rules.required(self.$t('validations.required.field'))],
        cityId: [self.$rules.required(self.$t('validations.required.field'))],
        rfc: [
          self.$rules.minLength(
            13,
            self.$t('validations.length.field_13_number')
          ),
          self.$rules.maxLength(
            13,
            self.$t('validations.length.field_13_number')
          )
        ],
        userType: [self.$rules.required(self.$t('validations.required.field'))]
      }
    }
  },
  created () {
    self = this
  },
  mounted () {
    this.setGroupOptions()
    this.setStateOptions()
    this.setCountriesOptions()
    this.validateUser()
  },
  methods: {
    ...mapActions('system/groups', ['getGroups']),
    ...mapActions('system/cities', ['getCitiesByStateOptions']),
    ...mapActions('system/states', [
      'getStates',
      'getStatesByCountriesOptions'
    ]),
    ...mapActions('system/countries', ['getCountries']),
    ...mapActions('system/userType', ['setUserOptionsByCountry']),
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
    setData (data) {
      const { roles } = data
      self.user.fields = data
      if (data.groups) {
        self.isCode = true
        self.user.fields.code = data.groups.name + ' - ' + data.groups.code
      }
      if (data.city) {
        self.user.fields.cityId = data.city.name
      }
      if (data.country) {
        self.user.fields.countryId = data.country.id
      }
      self.user.fields.roles = roles[0]
    },
    onRoleChange () {
      if (+self.user.fields.rol === 4) {
        self.user.fields.code = ''
        self.user.fields.groupId = null
        self.user.fields.state = null
        self.user.fields.cityId = null
        self.user.fields.userTypeId = null
        self.options.cities = []
      }
    },
    resetFields () {
      self.user.fields = {
        rol: 3,
        fullName: '',
        email: '',
        password: '',
        verifyPassword: '',
        phone: '',
        code: '',
        groupId: null,
        roles: '',
        privacyPolicies: false,
        countryId: null,
        userTypeId: null
      }
      self.$refs.regForm.resetValidation()
    },
    async setGroupOptions () {
      const response = await self.getGroups()
      self.options.groups = response.data
    },
    async setCitiesOptions (stateId) {
      const response = await self.getCitiesByStateOptions(stateId)
      self.options.cities = response.data
    },
    async setStateOptions (countryId) {
      let response = []
      if (countryId) {
        response = await self.getStatesByCountriesOptions(countryId)
      } else {
        response = await self.getStates()
      }
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
      self.setStateOptions(self.user.fields.countryId)
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
    },
    validateUser () {
      if (!this.$store.state.users.users.groupId) {
        this.isGroupActive = false
      }
    }
  }
}
</script>
<style lang="sass">
</style>
