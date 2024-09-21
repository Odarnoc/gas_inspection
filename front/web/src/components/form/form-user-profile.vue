<template>
  <q-form ref="regForm" class="q-gutter-md">
    <p class="text-h5 text-bold">{{ $t('fields.personalInfo') }}</p>

    <div class="row q-col-gutter-xs">
      <div class="col-12 q-mt-md" align="center">
        <image-profile :imageUrl="user.fields.image" />
        <br />
        <image-upload
          :route="createProfileFileRoute"
          @onUploadFile="updateProfileImage"
          :isProfileView="true"
        />
        <br />
      </div>
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          outlined
          readonly
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          v-model="user.fields.firstName"
          :label="$t('fields.firstName')"
        />
      </div>
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          outlined
          readonly
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          v-model="user.fields.paternalName"
          :label="$t('fields.paternalName')"
        />
      </div>
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          outlined
          readonly
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          v-model="user.fields.maternalName"
          :label="$t('fields.maternalName')"
        />
      </div>
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          outlined
          readonly
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="tel"
          mask="########"
          v-model="user.fields.phone"
          :label="$t('fields.phone')"
        />
      </div>
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          outlined
          readonly
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="tel"
          mask="########"
          v-model="user.fields.cellphone"
          :label="$t('fields.cellphone')"
        />
      </div>
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          outlined
          readonly
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="email"
          :disable="edit"
          v-model="user.fields.email"
          :label="$t('fields.email')"
        />
      </div>
    </div>
    <slot name="actions"></slot>
  </q-form>
</template>

<script>
import { GENERAL_ROUTES } from 'src/commons/filesRoutes'

let self
export default {
  name: 'base-table',
  data () {
    return {
      user: {
        fields: {
          id: null,
          image: '',
          rol: '',
          email: '',
          password: '',
          firstName: '',
          maternalName: '',
          paternalName: '',
          phone: '',
          cellphone: '',
          roles: '',
          address: '',
          professionalTitle: '',
          professionalTitleFile: '',
          cv: '',
          incomeDate: '',
          conclusionDate: ''
        }
      },
      isPwd: true,
      roles: [
        { value: this.$typesRol.admin, label: this.$t('roles.admin') },
        { value: this.$typesRol.vendor, label: this.$t('roles.vendor') },
        { value: this.$typesRol.inspector, label: this.$t('roles.inspector') },
        { value: this.$typesRol.instalator, label: this.$t('roles.instalator') }
      ]
    }
  },
  props: {
    edit: Boolean,
    isProfile: Boolean
  },
  computed: {
    createProfileFileRoute () {
      return `${GENERAL_ROUTES.user}${this.user.fields.id}/profile/`
    },
    createProfessionalTitleFileRoute () {
      return `${GENERAL_ROUTES.user}${this.user.fields.id}/professionalTitle/`
    },
    createCVFileRoute () {
      return `${GENERAL_ROUTES.user}${this.user.fields.id}/cv/`
    },
    computedOptions () {
      return (options) => [
        { value: null, label: this.$t('options.not_apply') },
        ...options
      ]
    },
    rules () {
      return {
        roles: [self.$rules.required(self.$t('validations.required.field'))],
        firstName: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        paternalName: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        maternalName: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        email: [
          self.$rules.required(self.$t('validations.required.email')),
          self.$rules.email(self.$t('validations.invalid_format.email'))
        ],
        password: [self.$rules.required(self.$t('validations.required.field'))],
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
        address: [self.$rules.required(self.$t('validations.required.field'))],
        professionalTitle: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        incomeDate: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        conclusionDate: [
          self.$rules.required(self.$t('validations.required.field'))
        ]
      }
    }
  },
  created () {
    self = this
  },
  mounted () {},
  methods: {
    async getData () {
      const params = { ...self.user.fields }
      const isValid = await self.$refs.regForm.validate()
      return {
        isValid: isValid,
        params: params
      }
    },
    setData (data) {
      const { roles } = data
      self.user.fields = data
      self.user.fields.rol = roles[0]
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
        roles: '',
        address: '',
        professionalTitle: '',
        professionalTitleFile: '',
        cv: '',
        incomeDate: '',
        conclusionDate: ''
      }
      self.$refs.regForm.resetValidation()
    },
    async updateProfileImage (updateUrlImage) {
      this.user.fields.image = updateUrlImage
    },
    async updateCVImage (updateUrlImage) {
      this.user.fields.cv = updateUrlImage
    },
    async updateProfessionalTitleImage (updateUrlImage) {
      this.user.fields.professionalTitleFile = updateUrlImage
    },
    showFile (url) {
      window.open(url, '_blank')
    }
  }
}
</script>
<style lang="sass">
</style>
