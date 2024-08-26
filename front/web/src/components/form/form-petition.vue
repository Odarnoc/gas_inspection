<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="col-md-3 col-sm-6 col-xs-12">
        <q-select
          filled
          use-input
          map-options
          v-model="order.fields.origin"
          @update:model-value="onSelectOption(markerKeys.origin)"
          @filter="filterOrigin"
          :options="originOptions"
          :rules="rules.origin"
          :label="$t('fields.originAddress')"
        >
          <template v-slot:append>
            <q-icon color="positive" name="location_on" />
          </template>
          <template v-slot:no-option>
            <q-item>
              <q-item-section class="text-grey">{{ $t('no_results') }}</q-item-section>
            </q-item>
          </template>
        </q-select>
      </div>
      <div class="col-md-3 col-sm-6 col-xs-12">
        <q-select
          filled
          use-input
          map-options
          v-model="order.fields.destination"
          @update:model-value="onSelectOption(markerKeys.destination)"
          @filter="filterDestination"
          :options="destinationOptions"
          :rules="rules.destination"
          :label="$t('fields.destinationAddress')"
        >
          <template v-slot:append>
            <q-icon color="red" name="location_on" />
          </template>
          <template v-slot:no-option>
            <q-item>
              <q-item-section class="text-grey">{{ $t('no_results') }}</q-item-section>
            </q-item>
          </template>
        </q-select>
      </div>
      <div class="col-md-3 col-sm-6 col-xs-12">
        <q-input
          filled
          v-model="order.fields.clientName"
          :label="$t('fields.clientName')"
          :rules="rules.clientName"
        />
      </div>
      <div class="col-md-3 col-sm-6 col-xs-12">
        <q-input
          type="tel"
          filled
          v-model="order.fields.clientPhone"
          :label="$t('fields.clientPhone')"
          :rules="rules.clientPhone"
          mask="##########"
        />
      </div>
      <div class="col-md-3 col-sm-6 col-xs-12">
        <q-input filled v-model="order.fields.note" :label="$t('fields.notesForDriver')" />
      </div>
      <slot name="actions"></slot>
    </div>
  </q-form>
</template>

<script>
import { markerKeys } from 'src/commons/generals'
import mapApi from 'src/commons/mapApi'

let self
export default {
  name: 'form-petition',
  data () {
    return {
      markerKeys,
      originOptions: [],
      destinationOptions: [],
      order: {
        fields: {
          note: '',
          clientName: '',
          clientPhone: '',
          origin: null,
          destination: null
        }
      }
    }
  },
  computed: {
    rules () {
      return {
        origin: [self.$rules.required(self.$t('validations.required.field'))],
        destination: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        clientName: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        clientPhone: [
          self.$rules.required(self.$t('validations.required.field')),
          self.$rules.numeric(
            self.$t('validations.invalid_format.field_numeric')
          ),
          self.$rules.minLength(
            10,
            self.$t('validations.length.field_10_number')
          )
        ]
      }
    }
  },
  created () {
    self = this
  },
  methods: {
    filterOrigin (val, update, abort) {
      const optionListName = 'originOptions'
      this.filterFn(val, update, abort, optionListName)
    },
    filterDestination (val, update, abort) {
      const optionListName = 'destinationOptions'
      this.filterFn(val, update, abort, optionListName)
    },
    filterFn (val, update, abort, optionListName) {
      setTimeout(() => {
        update(async () => {
          if (!val) {
            this.$data[optionListName] = []
          }
          const res = await mapApi.geocoding(val)

          this.$data[optionListName] = res.data.map((location) => ({
            label: location.display_name,
            value: {
              lat: location.lat,
              lon: location.lon
            }
          }))
        })
      }, 1500)
    },
    async onSelectOption (fieldUpdate) {
      const dataEvent = await this.getData()
      this.$emit('on-update', { fieldUpdate, ...dataEvent })
    },
    async getData () {
      const isValid = await self.$refs.refForm.validate()
      const params = { ...self.order.fields }
      return {
        isValid,
        params
      }
    },
    setData (data) {
      self.order.fields = data
      self.onSelectOption()
    },
    resetFields () {
      self.order.fields = {
        note: '',
        clientName: '',
        clientPhone: '',
        origin: null,
        destination: null
      }
      self.$refs.refForm.resetValidation()
    }
  }
}
</script>
<style lang="sass">
</style>
