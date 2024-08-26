<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="col-md-3 col-sm-6 col-xs-12">
        <q-select
          filled
          type="text"
          v-model="region.fields.countryId"
          :label="$t('fields.country')"
          emit-value
          map-options
          :rules="rules.countryId"
          :options="options.countries"
        />
      </div>
      <div class="col-md-3 col-sm-6 col-xs-12">
        <q-input
          filled
          type="text"
          v-model="region.fields.name"
          :rules="rules.name"
          :label="$t('fields.name')"
        />
      </div>
      <div class="col-md-3 col-sm-6 col-xs-12">
        <q-input
          filled
          type="text"
          v-model="region.fields.commissionPercentage"
          :rules="rules.commissionPercentage"
          :label="$t('fields.commissionPercentage')"
        />
      </div>
      <div class="col-md-3 col-sm-6 col-xs-12">
        <q-select
          filled
          use-input
          map-options
          v-model="region.fields.origin"
          @update:model-value="onSelectOption()"
          @filter="filterFn"
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
      <slot name="actions"></slot>
    </div>
  </q-form>
</template>

<script>
import mapApi from 'src/commons/mapApi'
import { precentRange } from '../../commons/generals'
import { mapActions } from 'vuex'

let self
export default {
  name: 'form-petition',
  data () {
    return {
      originOptions: [],
      region: {
        fields: {
          name: '',
          commissionPercentage: 0,
          origin: null,
          countryId: null
        }
      },
      options: {
        countries: []
      }
    }
  },
  props: {
    edit: Boolean
  },
  computed: {
    rules () {
      return {
        countryId: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        name: [self.$rules.required(self.$t('validations.required.field'))],
        commissionPercentage: [
          self.$rules.required(self.$t('validations.required.field')),
          self.$rules.numeric(
            self.$t('validations.invalid_format.field_numeric')
          ),
          self.$rules.between(
            precentRange.min,
            precentRange.max,
            self.$t('validations.value.betweenValue', [
              precentRange.min,
              precentRange.max
            ])
          ),
          self.$rules.integer(
            self.$t('validations.invalid_format.field_integer')
          )
        ],
        ...(!this.edit
          ? {
              origin: [
                self.$rules.required(self.$t('validations.required.field'))
              ]
            }
          : {})
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
    filterFn (val, update, abort) {
      setTimeout(() => {
        update(async () => {
          if (!val) {
            this.originOptions = []
          }
          const res = await mapApi.geocoding(val)

          this.originOptions = res.data.map((location) => ({
            label: location.display_name,
            value: {
              lat: location.lat,
              lon: location.lon
            }
          }))
        })
      }, 1500)
    },
    async onSelectOption () {
      const dataEvent = await this.getData()
      this.$emit('on-update', { ...dataEvent })
    },
    async getData () {
      const isValid = await self.$refs.refForm.validate()
      const params = { ...self.region.fields }
      return {
        isValid,
        params
      }
    },
    setData (data) {
      self.region.fields = data
      if (data.country) {
        self.region.fields.countryId = data.country.id
      }
      self.onSelectOption()
    },
    resetFields () {
      self.region.fields = {
        origin: null
      }
      self.$refs.refForm.resetValidation()
    },
    async setCountriesOptions () {
      const response = await self.getCountries()
      self.options.countries = response.data
    }
  }
}
</script>
<style lang="sass">
</style>
