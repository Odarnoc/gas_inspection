<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="col-md-6 col-xs-12">
        <q-input
          filled
          type="text"
          v-model="priceTable.fields.firstKilometer"
          :rules="rules.firstKilometer"
          :label="$t('fields.firstKilometer')"
        />
      </div>
      <div class="col-md-6 col-xs-12">
        <q-input
          filled
          type="text"
          v-model="priceTable.fields.lastKilometer"
          :rules="rules.lastKilometer"
          :label="$t('fields.lastKilometer')"
        />
      </div>
      <div class="col-md-6 col-xs-12">
        <q-input
          filled
          type="text"
          v-model="priceTable.fields.pricePerKilometer"
          :rules="rules.pricePerKilometer"
          :label="$t('fields.pricePerKilometer')"
        />
      </div>
      <div class="col-md-6 col-xs-12">
        <q-input
          filled
          type="text"
          v-model="priceTable.fields.pricePerMinute"
          :rules="rules.pricePerMinute"
          :label="$t('fields.pricePerMinute')"
        />
      </div>
      <div class="col-md-6 col-xs-12">
        <q-input
          filled
          type="text"
          v-model="priceTable.fields.basePrice"
          :rules="rules.basePrice"
          :label="$t('fields.basePrice')"
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
      options: {
        regions: []
      },
      priceTable: {
        fields: {
          id: null,
          firstKilometer: null,
          lastKilometer: null,
          pricePerKilometer: null,
          pricePerMinute: null,
          basePrice: null
        }
      }
    }
  },
  computed: {
    lastKilometerMinValue () {
      return +self.priceTable.fields.firstKilometer + 1
    },
    rules () {
      return {
        firstKilometer: [
          self.$rules.required(self.$t('validations.required.field')),
          self.$rules.numeric(
            self.$t('validations.invalid_format.field_numeric')
          )
        ],
        lastKilometer: [
          self.$rules.required(self.$t('validations.required.field')),
          self.$rules.numeric(
            self.$t('validations.invalid_format.field_numeric')
          ),
          self.$rules.minValue(
            self.lastKilometerMinValue,
            self.$t('validations.value.minValue', [self.lastKilometerMinValue])
          )
        ],
        pricePerKilometer: [
          self.$rules.required(self.$t('validations.required.field')),
          self.$rules.numeric(
            self.$t('validations.invalid_format.field_numeric')
          )
        ],
        pricePerMinute: [
          self.$rules.required(self.$t('validations.required.field')),
          self.$rules.numeric(
            self.$t('validations.invalid_format.field_numeric')
          )
        ],
        basePrice: [
          self.$rules.required(self.$t('validations.required.field')),
          self.$rules.numeric(
            self.$t('validations.invalid_format.field_numeric')
          )
        ]
      }
    }
  },
  created () {
    self = this
  },
  mounted () {
    this.fetchFromServer()
  },
  methods: {
    ...mapActions('system/regions', ['getOptions']),
    async fetchFromServer () {
      const regionsResponse = await this.getOptions()
      this.options.regions = regionsResponse.data
    },
    async getData () {
      const isValid = await self.$refs.refForm.validate()
      const params = { ...self.priceTable.fields }
      return {
        isValid: isValid,
        params: params
      }
    },
    setData (data) {
      self.priceTable.fields = data
    },
    resetFields () {
      self.priceTable.fields = {
        id: null,
        firstKilometer: null,
        lastKilometer: null,
        pricePerKilometer: null,
        pricePerMinute: null,
        basePrice: null
      }
      self.$refs.refForm.resetValidation()
    }
  }
}
</script>
<style lang="sass">
</style>
