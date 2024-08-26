<template>
  <q-card :class="$q.platform.is.desktop ? 'desktop-device-size' : 'movil-device-size'">
    <q-card-section class="bg-primary">
      <div class="row">
        <div
          class="col-xs-11 col-sm-11 col-md-11 col-lg-11 text-h6 main-title"
        >{{$t('titles.edit_profil_image')}}</div>
        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 pull-right">
          <q-btn color="white" flat v-close-popup round dense icon="close" />
        </div>
      </div>
    </q-card-section>

    <q-card-section :class="!image ? 'q-ma-md hidden' : 'q-ma-md'">
      <div class="row justify-center">
        <div class="col-auto">
          <q-file
            ref="docInput"
            @update:model-value="previewValidation"
            max-files="1"
            class="hidden"
          />
          <q-avatar size="256px">
            <img ref="imageSet" class="q-pa-md" />
          </q-avatar>
        </div>
      </div>
    </q-card-section>

    <q-car-section class="col-auto q-pa-md" v-if="!image">
      <div class="row justify-center">
        <div class="col-12 q-px-md">{{$t('profile.imageSuget.characteristicTile')}}</div>
        <br />
        <div class="col-12 q-px-md">
          <ul>
            <li>{{$t('profile.imageSuget.characteristic1')}}</li>
            <li>{{$t('profile.imageSuget.characteristic2')}}</li>
            <li>{{$t('profile.imageSuget.characteristic3')}}</li>
            <li>{{$t('profile.imageSuget.characteristic4')}}</li>
            <li>{{$t('profile.imageSuget.characteristic5')}}</li>
          </ul>
        </div>
        <div class="col-12 q-px-md">{{$t('profile.imageSuget.preventTitle')}}</div>
        <br />
        <div class="col-12 q-px-md">
          <ul>
            <li>{{$t('profile.imageSuget.prevent1')}}</li>
            <li>{{$t('profile.imageSuget.prevent2')}}</li>
            <li>{{$t('profile.imageSuget.prevent3')}}</li>
            <li>{{$t('profile.imageSuget.prevent4')}}</li>
            <li>{{$t('profile.imageSuget.prevent5')}}</li>
            <li>{{$t('profile.imageSuget.prevent6')}}.</li>
          </ul>
        </div>
      </div>
    </q-car-section>

    <q-car-section class="col-auto q-pa-md" v-if="image">
      <div class="row justify-center">
        <div class="col-auto q-px-md">
          <li>{{$t('profile.cutGuide.zoom')}}</li>
        </div>
      </div>
      <div class="row justify-center">
        <div class="col-auto q-px-md">
          <li>{{$t('profile.cutGuide.movement')}}</li>
        </div>
      </div>
    </q-car-section>

    <q-card-section>
      <div class="row justify-center">
        <div class="col-auto">
          <q-btn
            push
            color="primary"
            @click="pickFile"
            icon="folder_open"
            v-if="!image"
          >{{ $t('titles.select_image') }}</q-btn>
        </div>
        <div class="col-auto">
          <q-btn
            push
            color="primary"
            @click="returnImageToSave"
            icon="save"
            v-if="image"
          >{{ $t('titles.save_image') }}</q-btn>
        </div>
      </div>
    </q-card-section>
  </q-card>
</template>

<script>
import Cropper from 'cropperjs'

export default {
  name: 'ImageCropper',
  data () {
    return {
      cropper: null,
      image: null
    }
  },
  methods: {
    pickFile () {
      this.$refs.docInput.pickFiles()
    },
    async previewValidation (file) {
      const baseImage = await this.$imageCompression(file, 100)
      this.$refs.imageSet.src = baseImage
      this.setCropperImage()
    },
    setCropperImage () {
      this.image = this.$refs.imageSet
      this.cropper = new Cropper(this.image, {
        aspectRatio: 1,
        minCropBoxWidth: 500,
        minCropBoxHeight: 500,
        viewMode: 3,
        dragMode: 'move',
        background: true,
        cropBoxMovable: false,
        zoomable: true,
        center: true
      })
    },
    returnImageToSave () {
      const croperImage = this.cropper
        .getCroppedCanvas()
        .toDataURL('image/jpeg', 100)

      this.$emit('onCropperImage', this.$imageSetBlobFromBase64(croperImage))
    }
  }
}
</script>

<style lang="sass">
.movil-device-size
  min-width: 200px

.desktop-device-size
  min-width: 800px

.main-title
  color: white
</style>
