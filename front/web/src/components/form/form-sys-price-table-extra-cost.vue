<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="col-md-6 col-xs-12">
        <q-input
          filled
          type="text"
          v-model="priceTable.fields.start"
          :rules="rules.start"
          :label="$t('fields.start')"
          readonly
        >
          <template v-slot:append>
            <q-icon name="timer" class="cursor-pointer">
              <q-popup-proxy ref="qTimeProxy1" transition-show="scale" transition-hide="scale">
                <q-time
                  v-model="priceTable.fields.start"
                  mask="HH:mm:ss"
                  with-seconds
                  :options="optionsFnTimeStart"
                >
                  <div class="row items-center justify-end">
                    <q-btn v-close-popup :label="$t('buttons.close')" color="primary" flat />
                  </div>
                </q-time>
              </q-popup-proxy>
            </q-icon>
          </template>
        </q-input>
      </div>
      <div class="col-md-6 col-xs-12">
        <q-input
          filled
          type="text"
          v-model="priceTable.fields.end"
          :rules="rules.end"
          :label="$t('fields.end')"
          readonly
        >
          <template v-slot:append>
            <q-icon name="timer" class="cursor-pointer">
              <q-popup-proxy ref="qTimeProxy2" transition-show="scale" transition-hide="scale">
                <q-time
                  v-model="priceTable.fields.end"
                  mask="HH:mm:ss"
                  with-seconds
                  :options="optionsFnTimeEnd"
                >
                  <div class="row items-center justify-end">
                    <q-btn v-close-popup :label="$t('buttons.close')" color="primary" flat />
                  </div>
                </q-time>
              </q-popup-proxy>
            </q-icon>
          </template>
        </q-input>
      </div>
      <div class="col-md-6 col-xs-12">
        <q-input
          filled
          type="text"
          v-model="priceTable.fields.multiplier"
          :rules="rules.multiplier"
          :label="$t('fields.multiplier')"
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
          start: null,
          end: null,
          multiplier: null
        }
      }
    }
  },
  computed: {
    rules () {
      return {
        start: [self.$rules.required(self.$t('validations.required.field'))],
        end: [self.$rules.required(self.$t('validations.required.field'))],
        multiplier: [
          self.$rules.required(self.$t('validations.required.field')),
          self.$rules.numeric(
            self.$t('validations.invalid_format.field_numeric')
          ),
          self.$rules.higherThan(0, self.$t('validations.value.minValue', [0]))
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
        start: null,
        end: null,
        multiplier: null
      }
      self.$refs.refForm.resetValidation()
    },
    optionsFnTimeStart (hr, min, sec) {
      if (!this.priceTable.fields.end) {
        return true
      }

      const endTime = this.priceTable.fields.end,
        endHours = +endTime.split(':')[0],
        endMinutes = +endTime.split(':')[1],
        endSeconds = +endTime.split(':')[2].split(' ')[0]

      if (endTime && hr > endHours) {
        return false
      }
      if (hr === endHours && endTime && min !== null && min > endMinutes) {
        return false
      }
      if (
        hr === endHours &&
        min === endMinutes &&
        endTime &&
        sec !== null &&
        sec >= endSeconds
      ) {
        return false
      }

      return true
    },
    optionsFnTimeEnd (hr, min, sec) {
      if (!this.priceTable.fields.start) {
        return false
      }

      const startTime = this.priceTable.fields.start,
        startHours = +startTime.split(':')[0],
        startMinutes = +startTime.split(':')[1],
        startSeconds = +startTime.split(':')[2].split(' ')[0]

      if (hr < startHours) {
        return false
      }
      if (hr === startHours && min !== null && min < startMinutes) {
        return false
      }
      if (
        hr === startHours &&
        min === startMinutes &&
        sec !== null &&
        sec <= startSeconds
      ) {
        return false
      }

      return true
    }
  }
}
</script>
<style lang="sass">
</style>
