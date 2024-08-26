<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="col-6">
        <q-select
          filled
          map-options
          emit-value
          v-model="vehicle.fields.mark_id"
          :rules="rules.mark_id"
          :label="$t('fields.mark')"
          :options="markOptions"
        ></q-select>
      </div>
      <div class="col-6">
        <q-input
          filled
          type="text"
          v-model="vehicle.fields.name"
          :rules="rules.name"
          :label="$t('fields.model')"
        />
      </div>
      <slot name="actions"></slot>
    </div>
  </q-form>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
let self
export default {
  name: 'base-table',
  data () {
    return {
      vehicle: {
        fields: {
          mark_id: null,
          name: null
        }
      },
      isPwd: true
    }
  },
  props: {},
  computed: {
    ...mapGetters('vehicles/vehicleMarks', { markOptions: 'options' }),
    rules () {
      return {
        mark_id: [self.$rules.required(self.$t('validations.required.field'))],
        name: [self.$rules.required(self.$t('validations.required.field'))]
      }
    }
  },
  created () {
    self = this
  },
  async mounted () {
    await self.fetchFromServer()
  },
  methods: {
    ...mapActions('vehicles/vehicleMarks', { getAllMarks: 'getAll' }),
    async fetchFromServer () {
      self.$showLoading()
      await self.getAllMarks()
      self.$destroyLoading()
    },
    async getData () {
      const isValid = await self.$refs.refForm.validate()
      const params = { ...self.vehicle.fields }
      return {
        isValid: isValid,
        params: params
      }
    },
    setData (data) {
      self.vehicle.fields = data
    },
    resetFields () {
      self.vehicle.fields = {
        mark_id: null,
        name: null
      }
      self.$refs.refForm.resetValidation()
    }
  }
}
</script>
<style lang="sass">
</style>
