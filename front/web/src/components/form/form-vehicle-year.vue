<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="col-6">
        <q-input
          filled
          type="text"
          v-model="vehicle.fields.year"
          :rules="rules.year"
          :label="$t('fields.year')"
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
      vehicle: {
        fields: {
          year: null
        }
      },
      isPwd: true
    }
  },
  props: {},
  computed: {
    rules () {
      return {
        year: [self.$rules.required(self.$t('validations.required.field'))]
      }
    }
  },
  created () {
    self = this
  },
  methods: {
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
        year: null
      }
      self.$refs.refForm.resetValidation()
    }
  }
}
</script>
<style lang="sass">
</style>
