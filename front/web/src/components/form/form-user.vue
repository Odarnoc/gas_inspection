<template>
  <q-form ref="regForm" class="q-gutter-md">
    <p class="text-h5 text-bold">{{ $t('fields.personalInfo') }}</p>

    <div class="row q-col-gutter-xs">
      <div class="col-12 q-mt-md" align="center" v-if="edit">
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
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          v-model="user.fields.address"
          :rules="rules.address"
          :label="$t('fields.address')"
        />
      </div>
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="email"
          :disable="edit"
          v-model="user.fields.email"
          :rules="rules.email"
          :label="$t('fields.email')"
        />
      </div>
      <div class="col-md-3 col-xs-6 col-12" v-if="!edit">
        <q-input
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          :type="isPwd ? 'password' : 'text'"
          v-if="!edit"
          v-model="user.fields.password"
          :rules="rules.password"
          :label="$t('fields.password')"
        >
          <template v-slot:append>
            <q-icon
              :name="isPwd ? 'visibility_off' : 'visibility'"
              color="white"
              class="cursor-pointer"
              @click="isPwd = !isPwd"
            />
          </template>
        </q-input>
      </div>
    </div>
    <p class="text-h5 text-bold">{{ $t('fields.professionalProfile') }}</p>
    <div class="row q-col-gutter-xs">
      <div class="col-md-4 col-xs-6 col-12">
        <q-select
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          :options="roles"
          v-model="user.fields.rol"
          map-options
          emit-value
          :label="$t('fields.rol')"
          :rules="rules.roles"
        />
      </div>
    </div>
    <div class="row q-col-gutter-xs">
      <div class="col-12">
        <q-input
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          v-model="user.fields.professionalTitle"
          :rules="rules.professionalTitle"
          :label="$t('fields.professionalTitle')"
        >
          <template v-slot:append>
            <q-btn round dense flat icon="fa fa-file" v-if="edit">
              <q-menu anchor="top right" self="top left">
                <q-list>
                  <q-item>
                    <q-item-section>
                      <image-upload
                        :route="createProfessionalTitleFileRoute"
                        @onUploadFile="updateProfessionalTitleImage"
                        :buttonText="$t('buttons.upload')"
                        :round="false"
                        icon="upload"
                      />
                    </q-item-section>
                  </q-item>
                  <q-item v-if="user.fields.professionalTitleFile">
                    <q-item-section>
                      <q-btn
                        push
                        color="primary"
                        @click="showFile(user.fields.professionalTitleFile)"
                        :round="false"
                        icon="visibility"
                      >
                        {{ $t('buttons.view') }}
                        <q-tooltip>{{ $t('buttons.view') }}</q-tooltip>
                      </q-btn>
                    </q-item-section>
                  </q-item>
                </q-list>
              </q-menu>
            </q-btn>
          </template>
        </q-input>
      </div>
      <div class="col-12" v-if="edit">
        <q-input
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          :rules="rules.cv"
          :label="$t('fields.curriculumVitae')"
          readonly
        >
          <template v-slot:append>
            <q-btn round dense flat icon="fa fa-file" v-if="edit">
              <q-menu anchor="top right" self="top left">
                <q-list>
                  <q-item>
                    <q-item-section>
                      <image-upload
                        :route="createCVFileRoute"
                        @onUploadFile="updateCVImage"
                        :buttonText="$t('buttons.upload')"
                        :round="false"
                        icon="upload"
                      />
                    </q-item-section>
                  </q-item>
                  <q-item v-if="user.fields.cv">
                    <q-item-section>
                      <q-btn
                        push
                        color="primary"
                        @click="showFile(user.fields.cv)"
                        :round="false"
                        icon="visibility"
                      >
                        {{ $t('buttons.view') }}
                        <q-tooltip>{{ $t('buttons.view') }}</q-tooltip>
                      </q-btn>
                    </q-item-section>
                  </q-item>
                </q-list>
              </q-menu>
            </q-btn>
          </template>
        </q-input>
      </div>
      <div class="col-md-6 col-12">
        <q-input
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          v-model="user.fields.incomeDate"
          :rules="rules.incomeDate"
          :label="$t('fields.incomeDate')"
          readonly
        >
          <template v-slot:append>
            <q-icon name="event" class="cursor-pointer">
              <q-popup-proxy ref="qDateProxyx2" transition-show="scale" transition-hide="scale">
                <q-date :mask="$maskDate" color="primary" v-model="user.fields.incomeDate">
                  <div class="row items-center justify-end">
                    <q-btn v-close-popup :label="$t('buttons.close')" color="primary" flat />
                  </div>
                </q-date>
              </q-popup-proxy>
            </q-icon>
          </template>
        </q-input>
      </div>
      <div class="col-md-6 col-12">
        <q-input
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          v-model="user.fields.conclusionDate"
          :rules="rules.conclusionDate"
          :label="$t('fields.conclusionDate')"
          readonly
        >
          <template v-slot:append>
            <q-icon name="event" class="cursor-pointer">
              <q-popup-proxy ref="qDateProxyx2" transition-show="scale" transition-hide="scale">
                <q-date :mask="$maskDate" color="primary" v-model="user.fields.conclusionDate">
                  <div class="row items-center justify-end">
                    <q-btn v-close-popup :label="$t('buttons.close')" color="primary" flat />
                  </div>
                </q-date>
              </q-popup-proxy>
            </q-icon>
          </template>
        </q-input>
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
    edit: Boolean
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
      this.$emit('onupdateProfileImage')
    },
    async updateCVImage (updateUrlImage) {
      this.user.fields.cv = updateUrlImage
      this.$emit('onupdateCVImage')
    },
    async updateProfessionalTitleImage (updateUrlImage) {
      this.user.fields.professionalTitleFile = updateUrlImage
      this.$emit('onupdateProfessionalTitleImage')
    },
    showFile (url) {
      window.open(url, '_blank')
    }
  }
}
</script>
<style lang="sass">
</style>
