<template>
  <q-form ref="formData" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="col-12">
        <q-input
          filled
          type="text"
          v-model="notify.fields.title"
          :label="$t('fields.title')"
          :rules="rules.title"
        />
      </div>
      <div class="col-12">
        <q-input
          filled
          type="text"
          v-model="notify.fields.text"
          :label="$t('fields.message')"
          :rules="rules.text"
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
      notify: {
        fields: {
          title: '',
          text: ''
        }
      }
    }
  },
  computed: {
    rules () {
      return {
        title: [self.$rules.required(self.$t('validations.required.field'))],
        text: [self.$rules.required(self.$t('validations.required.field'))]
      }
    }
  },
  created () {
    self = this
  },
  mounted () {},
  methods: {
    async getData () {
      const isValid = await self.$refs.formData.validate()
      const params = { ...self.notify.fields }
      return {
        isValid: isValid,
        params: params
      }
    },
    resetFields () {
      self.notify.fields = {
        title: '',
        text: ''
      }
      self.$refs.formData.resetValidation()
    }
  }
}
</script>
<style lang="sass">
</style>
