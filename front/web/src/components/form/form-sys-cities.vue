<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="'col-md-12 col-xs-6">
        <q-input
          filled
          type="text"
          v-model="city.fields.name"
          :rules="rules.name"
          :label="$t('fields.name')"
        />
      </div>
      <div class="'col-md-12 col-xs-6">
        <q-select
          filled
          type="text"
          v-model="city.fields.state.id"
          :label="$t('fields.state')"
          emit-value
          map-options
          :rules="rules.state"
          :options="options.states"
        />
      </div>
      <div class="'col-md-12 col-xs-2">
        <q-checkbox
          filled
          type="text"
          v-model="city.fields.isActive"
          :rules="rules.isActive"
          :label="$t('fields.active')"
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
      city: {
        fields: {
          id: null,
          name: '',
          isActive: false,
          state: {
            id: null
          }
        }
      },
      options: {
        states: []
      }
    }
  },
  props: { edit_flag: Boolean },
  computed: {
    rules () {
      return {
        name: [self.$rules.required(self.$t('validations.required.field'))],
        state: [self.$rules.required(self.$t('validations.required.field'))],
        isActive: [self.$rules.required(self.$t('validations.required.field'))]
      }
    }
  },
  created () {
    self = this
  },
  mounted () {
    this.getStatesOptions()
  },
  methods: {
    ...mapActions('system/states', ['getStates']),
    async getData () {
      const isValid = await self.$refs.refForm.validate()
      const params = { ...self.city.fields }
      return {
        isValid: isValid,
        params: params
      }
    },
    setData (data) {
      if (!data.state) {
        data.state = {
          id: null
        }
      }
      self.city.fields = data
    },
    resetFields () {
      self.city.fields = {
        name: '',
        isActive: false
      }
      self.$refs.refForm.resetValidation()
    },
    async getStatesOptions () {
      self.$showLoading()
      const response = await self.getStates()
      self.options.states = response.data
      self.$destroyLoading()
    }
  }
}
</script>
<style lang="sass">
</style>
