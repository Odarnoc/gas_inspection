<template>
  <q-page>
    <header-pages activateButtonBreadCrum :breadCrumRoutes="breadCrumRoutes" />

    <div class="q-pa-md bg-grey-3">
      <div class="row bg-white border-panel q-pa-md">
        <div class="col-3" />
        <div class="col-12">
          <form-request-approved ref="documentForm" edit_flag />
        </div>
        <div class="col-12" v-if="isometric || floorPlan">
          <q-carousel swipeable animated arrows v-model="slide" infinite>
            <q-carousel-slide class="uncropped-image" :name="1" :img-src="isometric" />
            <q-carousel-slide class="uncropped-image" :name="2" :img-src="floorPlan" />

            <template v-slot:control>
              <q-carousel-control
                position="bottom"
                :offset="[16, 8]"
                class="text-white text-center rounded-borders"
                style="background: rgba(0, 0, 0, .4); padding: 4px 8px;"
              >{{ slide == 1 ? $t('fields.isometric') : $t('fields.floorPlan') }}</q-carousel-control>
            </template>
          </q-carousel>
          <br />
        </div>
        <div class="col-12">
          <q-btn color="warning" icon="photo_camera" @click="showExtraDocuments" />
          <q-btn
            v-if="status == statusOrder.inspectionAproved"
            class="float-right q-mr-md"
            color="primary"
            icon="save"
            :label="$t('buttons.saveAndassign')"
            @click="saveAndAssign"
          />
          <q-btn
            v-if="status == statusOrder.inspectionAproved"
            class="float-right q-mr-md"
            color="secondary"
            icon="save"
            :label="$t('buttons.update')"
            @click="save"
          />
        </div>
      </div>
    </div>
    <q-dialog v-model="extraDocumentsDialog">
      <q-card class="q-dialog-plugin">
        <q-carousel
          v-if="extraDouments.length>0"
          swipeable
          animated
          arrows
          v-model="slideExtra"
          infinite
        >
          <q-carousel-slide
            v-bind:key="(element,index)"
            v-for="(element,index) in extraDouments"
            :name="index"
            class="uncropped-image"
            :img-src="element?.documentUrl"
          />
        </q-carousel>
        <center class="q-ma-md" v-if="extraDouments.length == 0">{{ $t('no_documents') }}</center>
        <q-card-actions align="right">
          <q-btn color="primary" :label="$t('buttons.close')" @click="hideExtraDocuments" />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </q-page>
</template>

<script>
import { statusOrder } from 'src/commons/status'
import { mapActions } from 'vuex'

let self
export default {
  name: 'UserTypeEdit',
  data () {
    return {
      id: null,
      floorPlan: null,
      isometric: null,
      status: null,
      slide: 1,
      slideExtra: 0,
      extraDocumentsDialog: false,
      statusOrder: {
        ...statusOrder
      },
      extraDouments: []
    }
  },
  created () {
    self = this
    self.id = this.$decode(this.$route.params.id)
  },
  mounted () {
    self.fetchFromServer()
  },
  computed: {
    breadCrumRoutes () {
      return [self.$t('menus.requests'), self.$t('buttons.approved')]
    }
  },
  methods: {
    ...mapActions('vendor/requestPetition', ['get', 'update']),
    ...mapActions('vendor/requestDocuments', ['getDocuments']),
    showExtraDocuments () {
      this.extraDocumentsDialog = true
    },
    hideExtraDocuments () {
      this.extraDocumentsDialog = false
    },
    async fetchFromServer () {
      self.$showLoading()
      const response = await self.get(self.id)
      await this.setDocuments()
      const data = response.data
      self.$refs.documentForm.setData(data.data)
      this.status = data.data.status
      this.floorPlan = data.data.floorPlan
      this.isometric = data.data.isometric
      self.$destroyLoading()
    },
    async setDocuments () {
      const response = await this.getDocuments(self.id)
      this.extraDouments = response.data.data
    },
    async save () {
      self.loading = true
      self.$showLoading()
      const formResult = await self.$refs.documentForm.getData()
      if (!formResult.isValid) {
        self.loading = false
        self.$destroyLoading()
        return
      }
      const params = { ...formResult.params }
      try {
        const response = await self.update(params)
        this.$showNotifySuccess(response)
        await self.fetchFromServer()
      } catch (error) {
        this.$showNotifyError(error)
      }
      self.$destroyLoading()
      self.loading = false
    },
    async saveAndAssign () {
      self.loading = true
      self.$showLoading()
      const formResult = await self.$refs.documentForm.getData()
      if (!formResult.isValid) {
        self.loading = false
        self.$destroyLoading()
        return
      }
      const params = {
        ...formResult.params,
        status: statusOrder.instalationAssigned,
        log: 'Se asigno el proyecto a instalación'
      }
      try {
        const response = await self.update(params)
        this.$showNotifySuccess(response)
        await self.fetchFromServer()
      } catch (error) {
        this.$showNotifyError(error)
      }
      self.$destroyLoading()
      self.loading = false
    }
  }
}
</script>

<style>
</style>
