<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div :class="edit_flag ? 'col-md-6 col-xs-12':'col-md-12 col-xs-12'">
        <q-input
          filled
          type="text"
          v-model="group.fields.name"
          :rules="rules.name"
          :label="$t('fields.name')"
        />
      </div>
      <div :class="edit_flag ? 'col-md-6 col-xs-12':'col-md-12 col-xs-12'">
        <q-input
          filled
          type="text"
          v-model="group.fields.commissionPercentage"
          :rules="rules.commissionPercentage"
          :label="$t('fields.commissionPercentage')"
        />
      </div>
      <div class="col-md-6 col-xs-12" v-if="edit_flag">
        <q-input filled disable type="text" v-model="group.fields.code" :label="$t('fields.code')" />
      </div>
      <slot name="actions"></slot>
    </div>
  </q-form>
</template>

<script>
import { precentRange } from '../../commons/generals'
let self
export default {
  name: 'base-table',
  data () {
    return {
      group: {
        fields: {
          id: null,
          name: '',
          code: '',
          commissionPercentage: 0
        }
      },
      isPwd: true
    }
  },
  props: { edit_flag: Boolean },
  computed: {
    rules () {
      return {
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
        ]
      }
    }
  },
  created () {
    self = this
  },
  methods: {
    async getData () {
      const isValid = await self.$refs.refForm.validate()
      const params = { ...self.group.fields }
      return {
        isValid: isValid,
        params: params
      }
    },
    setData (data) {
      self.group.fields = data
    },
    resetFields () {
      self.group.fields = {
        name: ''
      }
      self.$refs.refForm.resetValidation()
    }
  }
}
</script>
<style lang="sass">
</style>
