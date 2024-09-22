<template>
  <q-form ref="regForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs justify-center">
      <div class="col-md-6 col-xs-6 col-12 justify-center">
        <q-select
          :readonly="readonlyByStatus"
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          :options="options.proyectTypes"
          v-model="user.fields.proyectType"
          map-options
          emit-value
          :label="$t('fields.selectProyectType')"
          :rules="rules.proyectType"
        />
      </div>
    </div>

    <p class="text-h5 text-bold">{{ $t('fields.personalInfo') }}</p>

    <div class="row q-col-gutter-xs">
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          :readonly="readonlyByStatus"
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
          :readonly="readonlyByStatus"
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
          :readonly="readonlyByStatus"
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
          :readonly="readonlyByStatus"
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
          :readonly="readonlyByStatus"
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
    <p class="text-h5 text-bold">{{ $t('fields.assignment') }}</p>
    <div class="row q-col-gutter-xs">
      <div class="col-md-6 col-xs-6 col-12">
        <q-select
          :readonly="readonlyByStatus"
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          :options="options.inspectors"
          v-model="user.fields.inspector"
          map-options
          emit-value
          :label="$t('roles.inspector')"
          :rules="rules.inspector"
        />
      </div>
    </div>
    <p class="text-h5 text-bold">{{ $t('fields.requirements') }}</p>
    <div class="row q-col-gutter-xs">
      <div class="col-12">
        <q-input
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          :rules="rules.identityCard"
          :label="$t('fields.identityCard')"
          readonly
        >
          <template v-slot:append>
            <q-btn round dense flat icon="fa fa-file">
              <q-menu anchor="top right" self="top left">
                <q-list>
                  <q-item>
                    <q-item-section>
                      <image-upload
                        :route="createIdentityCardFileRoute"
                        @onUploadFile="updateIdentityCardImage"
                        :buttonText="$t('buttons.upload')"
                        :round="false"
                        icon="upload"
                      />
                    </q-item-section>
                  </q-item>
                  <q-item v-if="user.fields.identityCard">
                    <q-item-section>
                      <q-btn
                        push
                        color="primary"
                        @click="showFile(user.fields.identityCard)"
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
      <div class="col-12">
        <q-input
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          :label="$t('fields.waterBill')"
          readonly
        >
          <template v-slot:append>
            <q-btn round dense flat icon="fa fa-file">
              <q-menu anchor="top right" self="top left">
                <q-list>
                  <q-item>
                    <q-item-section>
                      <image-upload
                        :route="createWaterBillFileRoute"
                        @onUploadFile="updateWaterBillImage"
                        :buttonText="$t('buttons.upload')"
                        :round="false"
                        icon="upload"
                      />
                    </q-item-section>
                  </q-item>
                  <q-item v-if="user.fields.waterBill">
                    <q-item-section>
                      <q-btn
                        push
                        color="primary"
                        @click="showFile(user.fields.waterBill)"
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
      <div class="col-12">
        <q-input
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          :label="$t('fields.electricityBill')"
          readonly
        >
          <template v-slot:append>
            <q-btn round dense flat icon="fa fa-file">
              <q-menu anchor="top right" self="top left">
                <q-list>
                  <q-item>
                    <q-item-section>
                      <image-upload
                        :route="createElectricityBillFileRoute"
                        @onUploadFile="updateElectricityBillImage"
                        :buttonText="$t('buttons.upload')"
                        :round="false"
                        icon="upload"
                      />
                    </q-item-section>
                  </q-item>
                  <q-item v-if="user.fields.electricityBill">
                    <q-item-section>
                      <q-btn
                        push
                        color="primary"
                        @click="showFile(user.fields.electricityBill)"
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
      <div class="col-12">
        <q-input
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          :label="$t('fields.realFolio')"
          readonly
        >
          <template v-slot:append>
            <q-btn round dense flat icon="fa fa-file">
              <q-menu anchor="top right" self="top left">
                <q-list>
                  <q-item>
                    <q-item-section>
                      <image-upload
                        :route="createRealFolioFileRoute"
                        @onUploadFile="updateRealFolioImage"
                        :buttonText="$t('buttons.upload')"
                        :round="false"
                        icon="upload"
                      />
                    </q-item-section>
                  </q-item>
                  <q-item v-if="user.fields.realFolio">
                    <q-item-section>
                      <q-btn
                        push
                        color="primary"
                        @click="showFile(user.fields.realFolio)"
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
          v-model="user.fields.startDate"
          :rules="rules.startDate"
          :label="$t('fields.startDate')"
          readonly
        >
          <template v-slot:append>
            <q-icon name="event" class="cursor-pointer">
              <q-popup-proxy
                ref="qDateProxyx2"
                transition-show="scale"
                transition-hide="scale"
                v-if="!readonlyByStatus"
              >
                <q-date :mask="$maskDate" color="primary" v-model="user.fields.startDate">
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
          v-model="user.fields.limitDate"
          :rules="rules.limitDate"
          :label="$t('fields.limitDate')"
          readonly
        >
          <template v-slot:append>
            <q-icon name="event" class="cursor-pointer">
              <q-popup-proxy
                ref="qDateProxyx2"
                transition-show="scale"
                transition-hide="scale"
                v-if="!readonlyByStatus"
              >
                <q-date :mask="$maskDate" color="primary" v-model="user.fields.limitDate">
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
    <p class="text-h5 text-bold">{{ $t('fields.location') }}</p>
    <div class="row q-col-gutter-xs">
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          :readonly="readonlyByStatus"
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          v-model="user.fields.zone"
          :rules="rules.zone"
          :label="$t('fields.zone')"
        />
      </div>
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          :readonly="readonlyByStatus"
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          v-model="user.fields.avenue"
          :rules="rules.avenue"
          :label="$t('fields.avenue')"
        />
      </div>
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          :readonly="readonlyByStatus"
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          v-model="user.fields.street"
          :rules="rules.street"
          :label="$t('fields.street')"
        />
      </div>
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          :readonly="readonlyByStatus"
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          v-model="user.fields.door"
          :rules="rules.door"
          :label="$t('fields.door')"
        />
      </div>
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          :readonly="readonlyByStatus"
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          v-model="user.fields.references"
          :rules="rules.references"
          :label="$t('fields.references')"
        />
      </div>
    </div>
    <div class="row q-col-gutter-xs">
      <div class="col-12">
        <GMapMap :center="center" :zoom="13" style="width: auto; height: 500px">
          <GMapMarker
            :position="marker"
            :draggable="!readonlyByStatus"
            @dragend="updateMarker($event)"
          />
          <GMapPolyline
            v-for="(polyline, index) in lines"
            v-bind:key="polyline.id"
            :path="polyline.line"
            :options="{
                strokeColor: getColorOfPolyline(polyline, index),
                strokeOpacity: 1.0,
                strokeWeight: 7,
              }"
          />
        </GMapMap>
      </div>
    </div>
    <div class="row q-col-gutter-xs" v-if="user.fields.observations">
      <div class="col-12">
        <q-input
          readonly
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="textarea"
          v-model="user.fields.observations"
          :label="$t('fields.observations')"
        />
      </div>
    </div>
    <br />
    <slot name="actions"></slot>
  </q-form>
</template>

<script>
import { GENERAL_ROUTES } from 'src/commons/filesRoutes'
import { statusOrder } from 'src/commons/status'
import { mapActions } from 'vuex'

let self
export default {
  name: 'base-table',
  data () {
    return {
      lines: [],
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
          inspector: null,
          status: statusOrder.assigned,
          observations: ''
        }
      },
      isPwd: true,
      options: { proyectTypes: [], inspectors: [] }
    }
  },
  props: {
    edit: Boolean
  },
  computed: {
    readonlyByStatus () {
      return (
        this.user.fields.status === statusOrder.rejected ||
        this.user.fields.status === statusOrder.done
      )
    },
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
        inspector: [
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
    this.setProyectTypeOptions()
    this.setInspectorOptions()
    this.setLines()
  },
  mounted () {},
  methods: {
    ...mapActions('admin/covergeLines', { getAllLines: 'getAll' }),
    ...mapActions('admin/proyectTypes', ['getOptions']),
    ...mapActions('users/auth', ['getInspectorOptions']),
    async getData () {
      const params = {
        ...self.user.fields,
        proyectType: {
          id: self.user.fields.proyectType
        },
        inspector: {
          id: self.user.fields.inspector
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
      const { location, proyectType, inspector } = data
      self.user.fields = data
      self.user.fields.proyectType = proyectType?.id
      self.user.fields.inspector = inspector?.id
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
    async updateIdentityCardImage (updateUrlImage) {
      this.user.fields.identityCard = updateUrlImage
      this.$emit('onupdateIdentityCard')
    },
    async updateWaterBillImage (updateUrlImage) {
      this.user.fields.waterBill = updateUrlImage
      this.$emit('onupdateWaterBillImage')
    },
    async updateElectricityBillImage (updateUrlImage) {
      this.user.fields.electricityBill = updateUrlImage
      this.$emit('onupdateElectricityBillImage')
    },
    async updateRealFolioImage (updateUrlImage) {
      this.user.fields.realFolio = updateUrlImage
      this.$emit('onupdateRealFolioImage')
    },
    showFile (url) {
      window.open(url, '_blank')
    },
    async setProyectTypeOptions () {
      const response = await self.getOptions()
      self.options.proyectTypes = response.data
    },
    async setLines () {
      const response = await self.getAllLines()
      self.lines = response.data.data
    },
    async setInspectorOptions () {
      const response = await self.getInspectorOptions()
      self.options.inspectors = response.data
    },
    updateMarker (locationEvent) {
      this.marker = {
        lat: locationEvent.latLng.lat(),
        lng: locationEvent.latLng.lng()
      }
    },
    getColorOfPolyline (polyline, index) {
      if (this.isEditing && this.selectedLineIndex === index) {
        return `${this.color}`
      }
      return `${polyline.color}`
    }
  }
}
</script>
<style lang="sass">
</style>
