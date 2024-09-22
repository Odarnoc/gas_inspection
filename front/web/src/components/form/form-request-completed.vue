<template>
  <q-form ref="regForm" class="q-gutter-md">
    <p class="text-h5 text-bold">{{ $t('fields.personalInfo') }}</p>

    <div class="row q-col-gutter-xs">
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          readonly
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          v-model="user.fields.firstName"
          :rules="rules.firstName"
          :label="$t('fields.firstName')"
        />
      </div>
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          readonly
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          v-model="user.fields.paternalName"
          :rules="rules.paternalName"
          :label="$t('fields.paternalName')"
        />
      </div>
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          readonly
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          v-model="user.fields.maternalName"
          :rules="rules.maternalName"
          :label="$t('fields.maternalName')"
        />
      </div>
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          readonly
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="tel"
          mask="########"
          v-model="user.fields.phone"
          :rules="rules.phone"
          :label="$t('fields.phone')"
        />
      </div>
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          readonly
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="tel"
          mask="########"
          v-model="user.fields.cellphone"
          :rules="rules.cellphone"
          :label="$t('fields.cellphone')"
        />
      </div>
    </div>
    <br />
    <slot name="actions"></slot>
  </q-form>
</template>

<script>
import { GENERAL_ROUTES } from 'src/commons/filesRoutes'
import { mapActions } from 'vuex'

let self
export default {
  name: 'base-table',
  data () {
    return {
      center: { lat: -16.49798820086203, lng: -68.13029845308486 },
      marker: { lat: -16.49798820086203, lng: -68.13029845308486 },
      user: {
        fields: {
          id: null,
          firstName: '',
          paternalName: '',
          maternalName: '',
          phone: '',
          cellphone: '',
          zone: '',
          address: '',
          avenue: '',
          street: '',
          door: '',
          references: '',
          location: null,
          identityCard: '',
          waterBill: '',
          electricityBill: '',
          realFolio: '',
          startDate: '',
          limitDate: '',
          proyectType: null,
          instalator: null,
          status: null,
          observations: ''
        }
      },
      isPwd: true,
      options: { proyectTypes: [], instalators: [] }
    }
  },
  props: {
    edit: Boolean
  },
  computed: {
    createIdentityCardFileRoute () {
      return `${GENERAL_ROUTES.user}identityCard/${new Date().getTime()}/`
    },
    createWaterBillFileRoute () {
      return `${GENERAL_ROUTES.user}waterBill/${new Date().getTime()}/`
    },
    createElectricityBillFileRoute () {
      return `${GENERAL_ROUTES.user}electricityBill/${new Date().getTime()}/`
    },
    createRealFolioFileRoute () {
      return `${GENERAL_ROUTES.user}realFolio/${new Date().getTime()}/`
    },
    computedOptions () {
      return (options) => [
        { value: null, label: this.$t('options.not_apply') },
        ...options
      ]
    },
    rules () {
      return {
        firstName: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        paternalName: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        maternalName: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        phone: [
          self.$rules.required(self.$t('validations.required.field')),
          self.$rules.numeric(
            self.$t('validations.invalid_format.field_numeric')
          ),
          self.$rules.minLength(
            7,
            self.$t('validations.length.field_7_or_8_number')
          ),
          self.$rules.maxLength(
            8,
            self.$t('validations.length.field_7_or_8_number')
          )
        ],
        cellphone: [
          self.$rules.required(self.$t('validations.required.field')),
          self.$rules.numeric(
            self.$t('validations.invalid_format.field_numeric')
          ),
          self.$rules.minLength(
            7,
            self.$t('validations.length.field_7_or_8_number')
          ),
          self.$rules.maxLength(
            8,
            self.$t('validations.length.field_7_or_8_number')
          )
        ],
        proyectType: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        instalator: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        zone: [self.$rules.required(self.$t('validations.required.field'))],
        avenue: [self.$rules.required(self.$t('validations.required.field'))],
        street: [self.$rules.required(self.$t('validations.required.field'))],
        door: [self.$rules.required(self.$t('validations.required.field'))],
        references: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        startDate: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        limitDate: [self.$rules.required(self.$t('validations.required.field'))]
      }
    }
  },
  created () {
    self = this
    this.setInstalatorOptions()
  },
  mounted () {},
  methods: {
    ...mapActions('admin/proyectTypes', ['getOptions']),
    ...mapActions('users/auth', ['getInstalatorOptions']),
    async getData () {
      const params = {
        ...self.user.fields,
        proyectType: {
          id: self.user.fields.proyectType
        },
        instalator: {
          id: self.user.fields.instalator
        },
        location: {
          x: this.marker.lat,
          y: this.marker.lng
        }
      }
      const isValid = await self.$refs.regForm.validate()
      return {
        isValid: isValid,
        params: params
      }
    },
    setData (data) {
      const { location, proyectType, inspector, instalator } = data
      self.user.fields = data
      self.user.fields.proyectType = proyectType?.id
      self.user.fields.inspector = inspector?.id
      self.user.fields.instalator = instalator?.id
      this.marker = {
        lat: location.x,
        lng: location.y
      }
      this.center = {
        lat: location.x,
        lng: location.y
      }
    },
    resetFields () {
      self.user.fields = {
        image: '',
        rol: '',
        email: '',
        password: '',
        firstName: '',
        maternalName: '',
        paternalName: '',
        phone: '',
        cellphone: '',
        address: '',
        professionalTitle: '',
        professionalTitleFile: '',
        cv: '',
        incomeDate: '',
        conclusionDate: ''
      }
      self.$refs.regForm.reset()
    },
    showFile (url) {
      window.open(url, '_blank')
    },
    async setInstalatorOptions () {
      const response = await self.getInstalatorOptions()
      self.options.instalators = response.data
    },
    updateMarker (locationEvent) {
      this.marker = {
        lat: locationEvent.latLng.lat(),
        lng: locationEvent.latLng.lng()
      }
    }
  }
}
</script>
<style lang="sass">
</style>
