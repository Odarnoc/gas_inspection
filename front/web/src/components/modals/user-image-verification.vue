<template>
  <q-card>
    <q-card-section class="bg-primary">
      <div class="row">
        <div
          class="col-xs-11 col-sm-11 col-md-11 col-lg-11 text-h6 main-title"
        >{{$t('titles.user_image_valaditaion')}}</div>
        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 pull-right">
          <q-btn color="white" flat v-close-popup round dense icon="close" />
        </div>
      </div>
    </q-card-section>

    <q-card-section>
      <div class="row">
        <div class="col-12 q-mt-md" align="center">
          <image-profile
            :imageUrl="userImage"
            :isAdministration="true"
            :imageStatus="userImageVerified"
          />
        </div>
        <div
          class="col-12 q-mt-md q-mb-md"
          align="center"
          v-if="!userImageVerified && userImage && !userImageRequest"
        >
          <div class="row">
            <div class="col-5" />
            <div class="col-2" align="center">
              <q-btn
                round
                icon="check"
                class="q-ml-md"
                color="positive"
                @click="requestedImageProfile(true)"
              ></q-btn>
            </div>
            <div class="col-5" />
          </div>
        </div>
        <div class="col-12 q-pt-md q-mb-md" align="center">
          <q-btn
            class="q-ml-md"
            color="negative"
            :label="$t('buttons.request_profile_image')"
            @click="requestedImageProfile(false)"
          >
            <q-tooltip>{{ $t('dialogs.requestedDocument') }}</q-tooltip>
          </q-btn>
        </div>
      </div>
    </q-card-section>
  </q-card>
</template>

<script>
import { mapActions } from 'vuex'

let self

export default {
  name: 'Login',
  data () {
    return {
      userImage: null,
      userImageRequest: false,
      userImageVerified: false
    }
  },
  props: {
    userData: []
  },
  created () {
    self = this
  },
  mounted () {
    self.userImage = self.userData.isImageVerified
      ? self.userData.image
      : self.userData.isImageRequested ||
        (!self.userData.isImageVerified && !self.userData.image) ||
        (!self.userData.isImageVerified &&
          self.userData.image &&
          !self.userData.isImageRequested)
        ? self.userData.imageToChange
        : self.userData.image
    self.userImageRequest = self.userData.isImageRequested
    self.userImageVerified = self.userData.isImageVerified
  },
  methods: {
    ...mapActions('users/users', ['requestProfilePicture']),
    async requestedImageProfile (verified) {
      self.$showLoading()
      const params = {
        id: self.userData.id,
        isImageRequested: !verified,
        isToUpdate: false,
        isImageVerified: verified
      }
      let data = {}
      self.$showLoading()
      try {
        const response = await self.requestProfilePicture(params)
        data = {
          message: self.$t(`messages.success.${response.data.message}`),
          result: response.data.result
        }
        this.$emit('closeUserImageProfileVerificationModal')
      } catch (error) {
        data = {
          message: self.$t(
            `messages.errorCode.${error.response.data.codeError}`
          ),
          result: false
        }
      }
      self.$showNotifyMessage(data)
      self.$destroyLoading()
      await this.fetchFromServer()
    }
  }
}
</script>

<style lang="sass">
.main-title
  color: white
</style>
