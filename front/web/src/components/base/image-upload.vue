
<template>
  <div class="row">
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
              :accept="`${accepteFiles.images}, ${accepteFiles.docuemnts}`"
              max-files="1"
              :max-file-size="sizeFiles"
              @rejected="onRejected"
              @update:model-value="previewValidation"
            />
            <q-btn
              push
              color="primary"
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

    <q-dialog v-model="flags.editModal" persistent>
      <cropper-image @onCropperImage="setImageCropper" />
    </q-dialog>

    <q-dialog v-model="flags.preview">
      <q-card style="min-width: 50wv">
        <q-field
          class="q-ma-lg"
          filled
          readonly
          v-bind:key="filePrev"
          v-for="filePrev in file.fields.document"
        >
          <template v-slot:control>
            <div class="self-center full-width no-outline">{{ filePrev.name }}</div>
          </template>
        </q-field>

        <q-separator />

        <q-card-actions align="right">
          <q-btn v-close-popup color="negative" :label="$t('buttons.cancel')" />
          <q-btn @click="uploadFile()" color="positive" :label="$t('buttons.confirm')" />
        </q-card-actions>
      </q-card>
    </q-dialog>
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
        prevdiew: false,
        editModal: false
      }
    }
  },
  props: {
    route: String,
    icon: { type: String, default: 'create' },
    buttonText: { type: String, default: '' },
    round: { type: Boolean, default: true },
    needPreview: { type: Boolean, default: false },
    toolTipText: { type: String, default: 'buttons.upload_image' },
    stylesOptions: { type: String, default: '' },
    isProfileView: { type: Boolean, default: false }
  },
  methods: {
    pickFiles () {
      if (this.isProfileView) {
        this.flags.editModal = true
      } else {
        this.$refs.docInput.pickFiles()
      }
    },
    async uploadFile () {
      await this.$showLoading()
      let document = null
      document = this.file.image
      if (this.isProfileView) {
        document = this.file.image
      } else {
        document = this.file.fields.document[0]
      }
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
