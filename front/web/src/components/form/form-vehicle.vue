<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="col-6">
        <q-input
          filled
          :readonly="readonly"
          v-model="vehicle.fields.mark"
          :rules="rules.mark"
          :label="$t('fields.mark')"
          @update:model-value="onSelectMark()"
        ></q-input>
      </div>
      <div class="col-6">
        <q-input
          filled
          :readonly="readonly"
          v-model="vehicle.fields.model"
          :rules="rules.model"
          :label="$t('fields.model')"
        ></q-input>
      </div>
      <div class="col-6">
        <q-input
          filled
          :readonly="readonly"
          v-model="vehicle.fields.year"
          :rules="rules.year"
          :label="$t('fields.year')"
          mask="####"
        ></q-input>
      </div>
      <div class="col-6">
        <q-input
          filled
          type="text"
          :readonly="readonly"
          v-model="vehicle.fields.plate"
          :rules="rules.plate"
          :label="$t('fields.plate')"
        />
      </div>
      <div class="col-6">
        <q-input
          filled
          type="text"
          :readonly="readonly"
          v-model="vehicle.fields.color"
          :rules="rules.color"
          :label="$t('fields.color')"
        />
      </div>
      <slot name="actions"></slot>
    </div>
  </q-form>
</template>

<script>
let self
export default {
  name: 'base-table',
  data () {
    return {
      lastYearAccepted: new Date().getFullYear() - 10,
      vehicle: {
        fields: {
          mark: null,
          model: null,
          year: null,
          plate: null,
          color: null
        }
      },
      isPwd: true
    }
  },
  props: {
    readonly: Boolean
  },
  computed: {
    rules () {
      return {
        mark: [self.$rules.required(self.$t('validations.required.field'))],
        model: [self.$rules.required(self.$t('validations.required.field'))],
        year: [
          self.$rules.required(self.$t('validations.required.field')),
          self.$rules.integer(
            self.$t('validations.invalid_format.field_numeric')
          ),
          self.$rules.minValue(
            self.lastYearAccepted,
            self.$t('validations.value.minVehicleYear', [self.lastYearAccepted])
          )
        ],
        plate: [self.$rules.required(self.$t('validations.required.field'))],
        color: [self.$rules.required(self.$t('validations.required.field'))]
      }
    }
  },
  created () {
    self = this
  },
  async mounted () {},
  methods: {
    async getData () {
      const isValid = await self.$refs.refForm.validate()
      const params = { ...self.vehicle.fields }
      return {
        isValid: isValid,
        params: params
      }
    },
    async setData (data) {
      self.vehicle.fields = data
    },
    resetFields () {
      self.vehicle.fields = {
        mark: null,
        model: null,
        year: null,
        plate: null,
        color: null
      }
      self.$refs.refForm.resetValidation()
    }
  }
}
</script>

<style lang="sass">
</style>
