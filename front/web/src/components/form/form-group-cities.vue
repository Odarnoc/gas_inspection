<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="'col-md-5 col-xs-4">
        <q-select
          filled
          type="text"
          v-model="city.fields.cityId"
          :rules="rules.cityId"
          :label="$t('fields.city')"
          :options="options.cities"
          map-options
          emit-value
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
          cityId: ''
        }
      },
      options: {
        cities: []
      }
    }
  },
  props: { edit_flag: Boolean, groupId: Number },
  computed: {
    rules () {
      return {
        cityId: [self.$rules.required(self.$t('validations.required.field'))]
      }
    }
  },
  created () {
    self = this
    self.setCitiesOptions()
  },
  methods: {
    ...mapActions('system/citiesByGroups', ['getOptionsByGroup']),
    async getData () {
      const isValid = await self.$refs.refForm.validate()
      const params = { ...self.city.fields }
      return {
        isValid: isValid,
        params: params
      }
    },
    async setCitiesOptions () {
      const response = await self.getOptionsByGroup(self.groupId)
      self.options.cities = response.data
    },
    setData (data) {
      self.city.fields = data
    },
    resetFields () {
      self.city.fields = {
        cityId: ''
      }
      self.$refs.refForm.resetValidation()
    }
  }
}
</script>
<style lang="sass">
</style>
