<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="'col-md-12 col-xs-2">
        <q-select
          filled
          type="text"
          v-model="questions.fields.category"
          :rules="rules.category"
          :label="$t('fields.category')"
          :options="options.category"
          map-options
          emit-value
        />
      </div>
      <div class="'col-md-12 col-xs-10">
        <q-input
          filled
          type="text"
          v-model="questions.fields.questions"
          :rules="rules.questions"
          :label="$t('fields.questions')"
        />
      </div>
      <div class="'col-md-12 col-xs-12"></div>
      <div class="'col-md-12 col-xs-12">
        <q-editor
          v-model="questions.fields.answer"
          :rules="rules.answer"
          :label="$t('fields.answer')"
          :toolbar="[
        [
          {
            label: $q.lang.editor.align,
            icon: $q.iconSet.editor.align,
            fixedLabel: true,
            options: ['left', 'center', 'right', 'justify']
          }
        ],
        ['bold', 'italic', 'strike', 'underline', 'subscript', 'superscript'],
        [
          {
            label: $q.lang.editor.formatting,
            icon: $q.iconSet.editor.formatting,
            list: 'no-icons',
            options: [
              'p',
              'h1',
              'h2',
              'h3',
              'h4',
              'h5',
              'h6',
              'code'
            ]
          },
          {
            label: $q.lang.editor.fontSize,
            icon: $q.iconSet.editor.fontSize,
            fixedLabel: true,
            fixedIcon: true,
            list: 'no-icons',
            options: [
              'size-1',
              'size-2',
              'size-3',
              'size-4',
              'size-5',
              'size-6',
              'size-7'
            ]
          },
          {
            label: $q.lang.editor.defaultFont,
            icon: $q.iconSet.editor.font,
            fixedIcon: true,
            list: 'no-icons',
            options: [
              'default_font',
              'arial',
              'arial_black',
              'comic_sans',
              'courier_new',
              'impact',
              'lucida_grande',
              'times_new_roman',
              'verdana'
            ]
          },
          'removeFormat'
        ],
        ['quote', 'unordered', 'ordered', 'outdent', 'indent'],
      ]"
          :fonts="{
        arial: 'Arial',
        arial_black: 'Arial Black',
        comic_sans: 'Comic Sans MS',
        courier_new: 'Courier New',
        impact: 'Impact',
        lucida_grande: 'Lucida Grande',
        times_new_roman: 'Times New Roman',
        verdana: 'Verdana'
      }"
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
      questions: {
        fields: {
          id: null,
          category: '',
          questions: '',
          answer: ''
        }
      },
      options: {
        category: [
          {
            value: 'customers',
            label: this.$t('options.questions_categories.customers')
          },
          {
            value: 'drivers',
            label: this.$t('options.questions_categories.drives')
          },
          {
            value: 'vehicles',
            label: this.$t('options.questions_categories.vehicles')
          },
          {
            value: 'general',
            label: this.$t('options.questions_categories.general')
          }
        ]
      }
    }
  },
  props: { edit_flag: Boolean },
  computed: {
    rules () {
      return {
        category: [self.$rules.required(self.$t('validations.required.field'))],
        questions: [
          self.$rules.required(self.$t('validations.required.field'))
        ],
        answer: [self.$rules.required(self.$t('validations.required.field'))]
      }
    }
  },
  created () {
    self = this
  },
  methods: {
    async getData () {
      const isValid = await self.$refs.refForm.validate()
      const params = { ...self.questions.fields }
      return {
        isValid: isValid,
        params: params
      }
    },
    setData (data) {
      self.questions.fields = data
    },
    resetFields () {
      self.questions.fields = {
        name: ''
      }
      self.$refs.refForm.resetValidation()
    }
  }
}
</script>
<style lang="sass">
</style>
