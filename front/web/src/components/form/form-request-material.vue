<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          v-model="state.fields.material"
          :rules="rules.material"
          :label="$t('fields.material')"
        />
      </div>
      <div class="col-md-3 col-xs-6 col-12">
        <q-input
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="number"
          v-model="state.fields.quantity"
          :rules="rules.quantity"
          :label="$t('fields.quantity')"
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
      state: {
        fields: {
          id: null,
          material: '',
          quantity: 1
        }
      }
    }
  },
  props: { edit_flag: Boolean },
  computed: {
    rules () {
      return {
        material: [self.$rules.required(self.$t('validations.required.field'))],
        quantity: [self.$rules.required(self.$t('validations.required.field'))]
      }
    }
  },
  created () {
    self = this
  },
  mounted () {},
  methods: {
    async getData () {
      const isValid = await self.$refs.refForm.validate()
      const params = {
        ...self.state.fields,
        quantity: +this.state.fields.quantity
      }
      return {
        isValid: isValid,
        params: params
      }
    },
    setData (data) {
      self.state.fields = data
    },
    resetFields () {
      self.state.fields = {
        id: null,
        material: '',
        quantity: 1
      }
      self.$refs.refForm.resetValidation()
    }
  }
}
</script>
<style lang="sass">
</style>
