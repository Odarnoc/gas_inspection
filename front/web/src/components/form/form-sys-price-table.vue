<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="col-md-6 col-xs-12">
        <q-input
          filled
          type="text"
          v-model="priceTable.fields.name"
          :rules="rules.name"
          :label="$t('fields.name')"
        />
      </div>
      <div class="col-md-6 col-xs-12">
        <q-select
          filled
          v-model="priceTable.fields.regionId"
          :label="$t('fields.region')"
          map-options
          emit-value
          :options="options.regions"
          :rules="rules.regionId"
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
          name: '',
          regionId: null
        }
      }
    }
  },
  computed: {
    rules () {
      return {
        name: [self.$rules.required(self.$t('validations.required.field'))],
        regionId: [self.$rules.required(self.$t('validations.required.field'))]
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
        name: '',
        regionId: null
      }
      self.$refs.refForm.resetValidation()
    }
  }
}
</script>
<style lang="sass">
</style>
