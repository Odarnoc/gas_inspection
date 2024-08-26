<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="'col-md-12 col-xs-12">
        <q-input
          filled
          type="text"
          v-model="version.fields.version"
          :rules="rules.version"
          :label="$t('fields.version')"
          mask="#.#.##"
          :readonly="version.fields.id != lastId"
        />
      </div>
      <div class="'col-md-12 col-xs-12">
        <q-editor
          :readonly="version.fields.id != lastId"
          v-model="version.fields.description"
          :rules="rules.description"
          :label="$t('fields.description')"
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
  name: 'form-system-versions',
  data () {
    return {
      version: {
        fields: {
          id: null,
          version: '',
          description: ''
        }
      }
    }
  },
  props: {
    isEdit: { type: Boolean, default: false },
    lastId: Number
  },
  computed: {
    rules () {
      return {
        version: [self.$rules.required(self.$t('validations.required.field'))],
        description: [
          self.$rules.required(self.$t('validations.required.field'))
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
      const params = { ...self.version.fields }
      return {
        isValid: isValid,
        params: params
      }
    },
    setData (data) {
      self.version.fields = data
    },
    resetFields () {
      self.version.fields = {
        version: ''
      }
      self.$refs.refForm.resetValidation()
    }
  }
}
</script>
<style lang="sass">
</style>
