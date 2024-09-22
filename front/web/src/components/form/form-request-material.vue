<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="col-md-6 col-xs-6 col-12">
        <q-select
          outlined
          bg-color="primary-input-color"
          color="border-primary-input-color"
          label-color="primary-input-color"
          input-class="value-primary-input-color"
          filled
          v-model="state.fields.material"
          :rules="rules.material"
          use-input
          input-debounce="0"
          :options="materialOptionFiltered"
          @filter="filterFn"
          :label="$t('fields.material')"
        >
          <template v-slot:no-option>
            <q-item>
              <q-item-section class="text-grey">No results</q-item-section>
            </q-item>
          </template>
        </q-select>
      </div>
      <div class="col-md-6 col-xs-6 col-12">
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
      },
      materialOptions: [
        'Válvulas - 1/2"',
        'Codo reductor - 3/4" a 1/2"',
        'Codo 90° - 3/4"',
        'Tee - 3/4"',
        'Cupla - 3/4"',
        'Tapón macho - 3/4"',
        'Codo M-H 90° de 3/4"',
        'Niple - 3/4"',
        'Codo M-H 90° - 1/2"',
        'Rejillas',
        'Funda',
        'Regulador - 1/2"',
        'Gasolina 1lt',
        'Teflón',
        'Carburo'
      ],
      materialOptionFiltered: this.materialOptions
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
    filterFn (val, update, abort) {
      update(() => {
        const needle = val.toLowerCase()
        this.materialOptionFiltered = this.materialOptions.filter(
          (v) => v.toLowerCase().indexOf(needle) > -1
        )
      })
    },
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
      self.$refs.refForm.reset()
    }
  }
}
</script>
<style lang="sass">
</style>
