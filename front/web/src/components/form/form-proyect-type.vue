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
          v-model="state.fields.name"
          :rules="rules.name"
          :label="$t('fields.name')"
        />
      </div>
      <div class="col-md-9 col-xs-6 col-12">
        <q-input
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          type="text"
          v-model="state.fields.details"
          :rules="rules.details"
          :label="$t('fields.details')"
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
          name: '',
          details: ''
        }
      },
      options: {
        countries: []
      }
    }
  },
  props: { edit_flag: Boolean },
  computed: {
    rules () {
      return {
        name: [self.$rules.required(self.$t('validations.required.field'))],
        details: [self.$rules.required(self.$t('validations.required.field'))]
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
      const params = { ...self.state.fields }
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
        name: ''
      }
      self.$refs.refForm.resetValidation()
    }
  }
}
</script>
<style lang="sass">
</style>
