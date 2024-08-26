<template>
  <q-form ref="contactForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="col-12">
        <q-input
          filled
          type="text"
          v-model="contact.fields.fullName"
          :rules="rules.fullName"
          :label="$t('fields.fullName')"
        />
      </div>
      <div class="col-12">
        <q-input
          filled
          type="email"
          v-model="contact.fields.email"
          :rules="rules.email"
          :label="$t('fields.email')"
        />
      </div>
      <div class="col-12">
        <q-input
          filled
          type="text"
          v-model="contact.fields.subject"
          :rules="rules.subject"
          :label="$t('fields.subject')"
        />
      </div>
      <div class="col-12">
        <q-input
          filled
          type="textarea"
          v-model="contact.fields.message"
          :rules="rules.message"
          :label="$t('fields.message')"
        />
      </div>
      <slot name="actions"></slot>
    </div>
  </q-form>
</template>

<script>
export default {
  name: 'form-contact',
  data () {
    return {
      contact: {
        fields: {
          fullName: '',
          email: '',
          subject: '',
          message: ''
        }
      },
      isPwd: true
    }
  },
  props: {
  },
  computed: {
    rules () {
      return {
        fullName: [this.$rules.required(this.$t('validations.required.field'))],
        email: [
          this.$rules.required(this.$t('validations.required.email')),
          this.$rules.email(this.$t('validations.invalid_format.email'))
        ],
        subject: [this.$rules.required(this.$t('validations.required.field'))],
        message: [this.$rules.required(this.$t('validations.required.field'))]
      }
    }
  },
  created () {
  },
  methods: {
    async getData () {
      const isValid = await this.$refs.contactForm.validate()
      const params = { ...this.contact.fields }
      return {
        isValid: isValid,
        params: params
      }
    },
    setData (data) {
      this.contact.fields = data
    },
    resetFields () {
      this.contact.fields = {
        fullName: '',
        email: '',
        subject: '',
        message: ''
      }
      this.$refs.contactForm.resetValidation()
    }
  }
}
</script>
<style lang="sass">
</style>
