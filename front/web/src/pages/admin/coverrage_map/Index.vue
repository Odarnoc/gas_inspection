<template>
  <q-page>
    <header-pages :breadCrumRoutes="breadCrumRoutes" />

    <div class="q-pa-md bg-grey-3">
      <div class="row bg-white border-panel q-pa-md">
        <div class="col-12 q-mb-md">
          <div class="row q-col-gutter-xs" v-if="!isCreating && !isEditing">
            <div class="col-12">
              <q-btn
                class="float-right"
                color="secondary"
                icon="add"
                :label="$t('buttons.new')"
                @click="startCreation"
              />
            </div>
          </div>
        </div>
        <div class="col-12">
          <q-form ref="linesForm" v-if="isCreating || isEditing">
            <div class="row q-col-gutter-xs">
              <div class="col-md-3 col-xs-6 col-12">
                <q-input
                  outlined
                  bg-color="primary-input-color"
                  color="border-primary-input-color"
                  label-color="primary-input-color"
                  input-class="value-primary-input-color"
                  v-model="color"
                  :rules="rules.color"
                >
                  <template v-slot:append>
                    <q-icon name="colorize" class="cursor-pointer">
                      <q-popup-proxy cover transition-show="scale" transition-hide="scale">
                        <q-color v-model="color" />
                      </q-popup-proxy>
                    </q-icon>
                  </template>
                </q-input>
              </div>
              <div class="col-md-3 col-xs-6 col-12">
                <q-input
                  outlined
                  bg-color="primary-input-color"
                  color="border-primary-input-color"
                  label-color="primary-input-color"
                  input-class="value-primary-input-color"
                  type="text"
                  v-model="city"
                  :rules="rules.city"
                  :label="$t('fields.city')"
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
                  v-model="zone"
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
                  v-model="avenue"
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
                  v-model="streets"
                  :rules="rules.streets"
                  :label="$t('fields.streets')"
                />
              </div>
            </div>
          </q-form>
        </div>
        <div class="col-12">
          <GMapMap
            :center="center"
            :zoom="15"
            style="width: auto; height: 500px"
            :options="{
              clickableIcons: false,
              zoomControl: true,
              mapTypeControl: false,
              scaleControl: true,
              streetViewControl: false,
              rotateControl: true,
              fullscreenControl: false
            }"
            @click="addCoordinatesToLine"
          >
            <GMapPolyline
              @path_changed="updateCreate($event)"
              :path="newPath"
              :editable="true"
              :options="{
                strokeColor: `${color}`,
                strokeOpacity: 1.0,
                strokeWeight: 7,
              }"
            />
            <GMapPolyline
              v-bind:key="polyline.id"
              v-for="(polyline, index) in existentPolylines"
              @click="polyLineOptions(index)"
              @path_changed="updateEdited($event)"
              :path="polyline.line"
              :editable="polyline.editable"
              :ref="`existentPoly-${index}`"
              :options="{
                strokeColor: getColorOfPolyline(polyline, index),
                strokeOpacity: 1.0,
                strokeWeight: 7,
              }"
            />
            <q-menu v-model="showing">
              <q-list style="min-width: 100px">
                <q-btn
                  color="secondary"
                  icon="edit"
                  :label="$t('buttons.edit')"
                  @click="startEdit"
                />
                <br />
                <br />
                <q-btn
                  color="negative"
                  icon="delete"
                  :label="$t('buttons.delete')"
                  @click="deleteLine"
                />
              </q-list>
            </q-menu>
          </GMapMap>
        </div>
        <div class="col-12 q-mt-md">
          <q-btn
            v-if="isEditing"
            class="float-right"
            color="primary"
            icon="save"
            :label="$t('buttons.save')"
            @click="updateSelectedLine"
          />
          <q-btn
            v-if="isCreating"
            class="float-right"
            color="primary"
            icon="save"
            :label="$t('buttons.save')"
            @click="save"
          />
          <q-btn
            v-if="isEditing || isCreating"
            class="float-right q-mr-md"
            color="negative"
            icon="fas fa-trash"
            :label="$t('buttons.cancel')"
            @click="cancel"
          />
        </div>
      </div>
    </div>
  </q-page>
</template>

<script>
import {
  getBoundingBoxFromPoint,
  latLngToLineParser
} from 'src/commons/mapHelpers'
import { mapActions } from 'vuex'

export default {
  name: 'RegionsNew',
  data () {
    return {
      center: { lat: -16.49798820086203, lng: -68.13029845308486 },
      color: '#00d600',
      city: '',
      zone: '',
      avenue: '',
      streets: '',
      newPath: [],
      editedPath: [],
      existentPolylines: [],
      selectedLineIndex: null,
      showing: false,
      isEditing: false,
      isCreating: false
    }
  },
  computed: {
    breadCrumRoutes () {
      return [this.$t('menus.coverage_map')]
    },
    rules () {
      return {
        color: [
          this.$rules.required(this.$t('validations.required.field')),
          (val) =>
            /^#[0-9A-F]{6}$/i.test(val) ||
            this.$t('validations.invalid_format.color')
        ],
        city: [this.$rules.required(this.$t('validations.required.field'))],
        avenue: [this.$rules.required(this.$t('validations.required.field'))],
        zone: [this.$rules.required(this.$t('validations.required.field'))],
        streets: [this.$rules.required(this.$t('validations.required.field'))]
      }
    }
  },
  created () {},
  mounted () {
    this.setLines()
  },
  methods: {
    ...mapActions('admin/covergeLines', [
      'create',
      'getAll',
      'update',
      'delete'
    ]),
    async setLines () {
      const response = await this.getAll()
      this.existentPolylines = response.data.data
    },
    polyLineOptions (index) {
      if (this.isEditing) {
        return
      }
      if (this.isCreating) {
        return
      }
      this.selectedLineIndex = index
      this.showing = true
    },
    startEdit () {
      this.existentPolylines[this.selectedLineIndex].editable = true
      this.color = this.existentPolylines[this.selectedLineIndex].color
      this.city = this.existentPolylines[this.selectedLineIndex].city
      this.zone = this.existentPolylines[this.selectedLineIndex].zone
      this.avenue = this.existentPolylines[this.selectedLineIndex].avenue
      this.streets = this.existentPolylines[this.selectedLineIndex].streets
      this.showing = false
      this.isEditing = true
    },
    startCreation () {
      this.isCreating = true
    },
    cancel () {
      this.newPath = []
      this.showing = false
      this.isEditing = false
      this.isCreating = false
      this.setLines()
    },
    addCoordinatesToLine (event) {
      if (this.isCreating) {
        if (event.latLng?.lat) {
          this.newPath = [
            ...this.newPath,
            { lat: event.latLng.lat(), lng: event.latLng.lng() }
          ]
        }
      }
      if (this.isEditing) {
        if (event.latLng?.lat) {
          this.existentPolylines[this.selectedLineIndex].line = [
            ...this.existentPolylines[this.selectedLineIndex].line,
            { lat: event.latLng.lat(), lng: event.latLng.lng() }
          ]
        }
      }
    },
    async save () {
      this.loading = true
      this.$showLoading()
      const isValid = await this.$refs.linesForm.validate()
      if (!isValid) {
        this.loading = false
        this.$destroyLoading()
        return
      }
      if (this.newPath.length < 2) {
        this.$destroyLoading()
        this.$showMessage(
          'Advertencia',
          'Seleccione al menos 2 coordenadas para la creación de la línea de cobertura'
        )
        return
      }
      const line = latLngToLineParser(this.newPath)
      const params = {
        line,
        color: this.color,
        city: this.city,
        zone: this.zone,
        avenue: this.avenue,
        streets: this.streets
      }
      try {
        const response = await this.create(params)
        this.$showNotifySuccess(response)
        this.newPath = []
        this.isCreating = false
        this.setLines()
      } catch (error) {
        this.$showNotifyError(error)
      }
      this.$destroyLoading()
      this.loading = false
    },
    async deleteLine () {
      this.loading = true
      this.showing = false
      this.$showLoading()
      const id = this.existentPolylines[this.selectedLineIndex].id
      try {
        const response = await this.delete(id)
        this.$showNotifySuccess(response)
        this.setLines()
      } catch (error) {
        this.$showNotifyError(error)
      }
      this.$destroyLoading()
      this.loading = false
    },
    async updateSelectedLine () {
      this.loading = true
      this.$showLoading()
      const isValid = await this.$refs.linesForm.validate()
      if (!isValid) {
        this.loading = false
        this.$destroyLoading()
        return
      }
      const editedPath = this.existentPolylines[this.selectedLineIndex].line
      if (editedPath < 2) {
        this.$destroyLoading()
        this.$showMessage(
          'Advertencia',
          'Seleccione al menos 2 coordenadas para la actualización de la línea de cobertura'
        )
        return
      }
      const id = this.existentPolylines[this.selectedLineIndex].id
      const line = latLngToLineParser(editedPath)
      const params = {
        id,
        line,
        color: this.color,
        city: this.city,
        zone: this.zone,
        avenue: this.avenue,
        streets: this.streets
      }
      try {
        const response = await this.update(params)
        this.$showNotifySuccess(response)
        this.isEditing = false
        this.setLines()
      } catch (error) {
        this.$showNotifyError(error)
      }
      this.$destroyLoading()
      this.loading = false
    },
    updateEdited (event) {
      const newArray = []
      event.forEach((element) => {
        newArray.push({ lat: element.lat(), lng: element.lng() })
      })
      this.existentPolylines[this.selectedLineIndex].line = newArray
    },
    updateCreate (event) {
      const newArray = []
      event.forEach((element) => {
        newArray.push({ lat: element.lat(), lng: element.lng() })
      })
      this.newPath = newArray
    },
    onUpdateForm (event) {
      const params = event.params
      const point = {
        lat: +params.origin.value.lat,
        lng: +params.origin.value.lon
      }
      this.center = { ...point }
      this.marker = { ...point }
      this.paths = [getBoundingBoxFromPoint(point)]
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

<style>
</style>
