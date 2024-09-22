
<template>
  <q-btn v-if="!isProfileView" :color="color" :icon="icon" :label="buttonText" @click="pickFiles">
    <q-file
      class="hidden"
      ref="docInput"
      v-model="file.fields.document"
      filled
      rounded
      multiple
      :accept="`${accepteFiles.images}`"
      max-files="1"
      :max-file-size="sizeFiles"
      @rejected="onRejected"
      @update:model-value="previewValidation"
    />
  </q-btn>
  <div v-else class="row">
    <div class="col-xs-12 col-sm-3" />
    <div class="col-xs-12 col-sm-6">
      <div class="row justify-center">
        <div class="q-pt-md">
          <div class="q-gutter-x-md">
            <q-file
              class="hidden"
              ref="docInput"
              v-model="file.fields.document"
              filled
              rounded
              multiple
              :accept="`${accepteFiles.images}`"
              max-files="1"
              :max-file-size="sizeFiles"
              @rejected="onRejected"
              @update:model-value="previewValidation"
            />
            <q-btn
              v-if="isProfileView"
              push
              :color="color"
              @click="pickFiles"
              :round="round"
              :icon="icon"
              :style="stylesOptions"
            >
              {{ buttonText }}
              <q-tooltip>{{ $t(toolTipText) }}</q-tooltip>
            </q-btn>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { storage } from '../../commons/firebase'
import { getDownloadURL, ref, uploadBytes } from '@firebase/storage'
import { v4 } from 'uuid'
import { accepteFiles, sizeFiles } from '../../commons/generals'

export default {
  name: 'image-uploaded',
  data () {
    return {
      accepteFiles,
      sizeFiles,
      file: {
        fields: {
          document: null,
          imageUrl: null
        },
        image: null
      },
      flags: {
        prevdiew: false
      }
    }
  },
  props: {
    route: String,
    icon: { type: String, default: 'create' },
    color: { type: String, default: 'primary' },
    buttonText: { type: String, default: '' },
    round: { type: Boolean, default: true },
    needPreview: { type: Boolean, default: false },
    toolTipText: { type: String, default: 'buttons.upload_image' },
    stylesOptions: { type: String, default: '' },
    isProfileView: { type: Boolean, default: false }
  },
  methods: {
    pickFiles () {
      this.$refs.docInput.pickFiles()
    },
    async uploadFile () {
      await this.$showLoading()
      const document = this.file.fields.document[0]
      const imageRef = ref(storage, `${this.route}-${v4()}`)
      await uploadBytes(imageRef, document).then(async (data) => {
        await this.$showLoading()
        await getDownloadURL(imageRef).then((url) => {
          this.$emit('onUploadFile', url)
        })
      })
      await this.$destroyLoading()
    },
    onRejected () {
      this.$q.notify({
        position: 'top-right',
        type: 'negative',
        message: this.$t('messages.errorSpecific.whronFileFormat')
      })
    },
    async previewValidation () {
      await this.$showLoading()
      if (this.needPreview) {
        this.flags.preview = true
        return
      }
      await this.uploadFile()
      await this.$destroyLoading()
    },
    setImageCropper (image) {
      this.file.image = image
      this.uploadFile()
    }
  }
}
</script>
