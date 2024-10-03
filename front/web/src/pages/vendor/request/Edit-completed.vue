<template>
  <q-page>
    <header-pages activateButtonBreadCrum :breadCrumRoutes="breadCrumRoutes" />

    <div class="q-pa-md bg-grey-3">
      <div class="row bg-white border-panel q-pa-md">
        <div class="col-3" />
        <div class="col-12">
          <form-request-completed ref="documentForm" edit_flag />
        </div>
        <div class="col-12">
          <q-carousel
            v-if="allDocumentList.length>0"
            swipeable
            animated
            arrows
            v-model="slide"
            infinite
          >
            <q-carousel-slide
              v-bind:key="(element,index)"
              v-for="(element,index) in allDocumentList"
              :name="index"
              class="uncropped-image"
              :img-src="element?.url"
            >
              <div class="absolute-bottom custom-caption">
                <div class="text-subtitle1">
                  {{ element?.name }}
                  <q-btn
                    v-if="status == statusOrder.store && !element?.selected"
                    color="primary"
                    round
                    icon="check_box_outline_blank"
                    size="18px"
                    @click="selectDocument(index)"
                  />
                  <q-btn
                    v-if="status == statusOrder.store && element?.selected"
                    color="primary"
                    round
                    icon="check_box"
                    size="18px"
                    @click="unSelectDocument(index)"
                  />
                </div>
              </div>
            </q-carousel-slide>
            <!-- <template v-slot:control>
              <q-carousel-control
                position="bottom"
                :offset="[16, 8]"
                class="text-white text-center rounded-borders"
                style="background: rgba(0, 0, 0, .4); padding: 4px 8px;"
              >{{ allDocumentList[slide]?.name }}</q-carousel-control>
            </template>-->
          </q-carousel>
          <br />
        </div>
        <div class="col-12">
          <image-upload
            v-if="status == statusOrder.done"
            color="warning"
            icon="photo_camera"
            :label="$t('buttons.addDocument')"
            :route="createDocumentRoute"
            @onUploadFile="addExtraDocument"
          />
          <q-btn
            v-if="status == statusOrder.store"
            class="float-right"
            color="primary"
            icon="download"
            :label="$t('buttons.download_proyect')"
            @click="getProyectOnPdf"
          />
          <q-btn
            v-if="status == statusOrder.done"
            class="float-right q-mr-md"
            color="secondary"
            icon="folder"
            :label="$t('buttons.store')"
            @click="storeRequest"
          />
        </div>
      </div>
    </div>
  </q-page>
</template>

<script>
import { GENERAL_ROUTES } from 'src/commons/filesRoutes'
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
      materials: null,
      status: null,
      slide: 0,
      extraDocumentsDialog: false,
      statusOrder: {
        ...statusOrder
      },
      allDocumentList: [],
      extraDouments: [],
      selectedExtraDocumentIDS: [],
      isometricSelected: false,
      floorPlanSelected: false,
      materialsSelected: false,
      where: {
        where: {
          requestPetition: {
            id: null
          }
        }
      }
    }
  },
  created () {
    self = this
    self.id = this.$decode(this.$route.params.id)
    self.where.where.requestPetition.id = self.id
  },
  mounted () {
    self.fetchFromServer()
  },
  computed: {
    breadCrumRoutes () {
      return [self.$t('menus.requests'), self.$t('menus.approved')]
    },
    createDocumentRoute () {
      return `${GENERAL_ROUTES.user}identityCard/${new Date().getTime()}/`
    },
    columnsServices () {
      return [
        {
          name: 'material',
          align: 'left',
          label: this.$t('fields.material'),
          field: 'material',
          sortable: true
        },
        {
          name: 'quantity',
          align: 'left',
          label: this.$t('fields.quantity'),
          field: 'quantity',
          sortable: true
        },
        {
          name: 'actions',
          align: 'center',
          label: this.$t('buttons.actions'),
          field: 'actions',
          sortable: false
        }
      ]
    }
  },
  methods: {
    ...mapActions('vendor/requestPetition', ['get', 'update']),
    ...mapActions('vendor/requestDocuments', ['getDocuments', 'create']),
    ...mapActions('pdf/request', ['getProyectPdf']),
    async getProyectOnPdf () {
      const params = {
        id: self.id,
        name: `proyecto-${self.id}.pdf`,
        isometricSelected: this.isometricSelected,
        floorPlanSelected: this.floorPlanSelected,
        materialsSelected: this.materialsSelected,
        selectedExtraDocumentIDS: this.selectedExtraDocumentIDS
      }
      await this.getProyectPdf(params)
    },
    async addExtraDocument (url) {
      self.loading = true
      self.$showLoading()
      const formResult = await self.$refs.documentForm.getData()
      if (!formResult.isValid) {
        self.loading = false
        self.$destroyLoading()
        return
      }
      const params = { requestPetition: { id: self.id }, documentUrl: url }
      try {
        const response = await self.create(params)
        this.$showNotifySuccess(response)
        await self.fetchFromServer()
      } catch (error) {
        this.$showNotifyError(error)
      }
      self.$destroyLoading()
      self.loading = false
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
      this.materials = data.data.materials

      const tempArray = []

      if (this.isometric) {
        tempArray.push({
          canDelete: true,
          id: 0,
          documentType: 'isometric',
          selected: false,
          url: this.isometric,
          name: this.$t('fields.isometric')
        })
      }
      if (this.floorPlan) {
        tempArray.push({
          canDelete: true,
          id: 0,
          documentType: 'floorPlan',
          selected: false,
          url: this.floorPlan,
          name: this.$t('fields.floorPlan')
        })
      }
      if (this.materials) {
        tempArray.push({
          canDelete: true,
          id: 0,
          documentType: 'materials',
          selected: false,
          url: this.materials,
          name: this.$t('fields.materials')
        })
      }

      const resultArray = this.extraDouments.map((document) => ({
        canDelete: true,
        id: document.id,
        documentType: '',
        selected: false,
        url: document.documentUrl,
        name: this.$t('extra_document')
      }))

      this.allDocumentList = [...tempArray, ...resultArray]
      self.$destroyLoading()
    },
    selectDocument (index) {
      this.allDocumentList[index].selected = true
      if (this.allDocumentList[index].documentType === 'isometric') {
        this.isometricSelected = true
      }
      if (this.allDocumentList[index].documentType === 'floorPlan') {
        this.floorPlanSelected = true
      }
      if (this.allDocumentList[index].documentType === 'materials') {
        this.materialsSelected = true
      }
      if (this.allDocumentList[index].id > 0) {
        this.selectedExtraDocumentIDS.push(this.allDocumentList[index].id)
      }
    },
    unSelectDocument (index) {
      this.allDocumentList[index].selected = false
      if (this.allDocumentList[index].documentType === 'isometric') {
        this.isometricSelected = false
      }
      if (this.allDocumentList[index].documentType === 'floorPlan') {
        this.floorPlanSelected = false
      }
      if (this.allDocumentList[index].documentType === 'materials') {
        this.materialsSelected = false
      }
      if (this.allDocumentList[index].id > 0) {
        const id = this.allDocumentList[index].id
        const newIDArray = this.selectedExtraDocumentIDS.filter(function (e) {
          return e !== id
        })
        this.selectedExtraDocumentIDS = [...newIDArray]
      }
    },
    async setDocuments () {
      const response = await this.getDocuments(self.id)
      this.extraDouments = response.data.data
    },
    async storeRequest () {
      self.loading = true
      self.$showLoading()
      const params = {
        id: +self.id,
        status: statusOrder.store,
        log: 'Se archivo el proyecto'
      }
      try {
        const response = await self.update(params)
        this.$showNotifySuccess(response)
        this.$router.push('/stored')
      } catch (error) {
        this.$showNotifyError(error)
      }
      self.$destroyLoading()
      self.loading = false
    }
  }
}
</script>

<style lang="sass" scoped>
.custom-caption
  text-align: center
  padding: 12px
  color: white
  background-color: rgba(0, 0, 0, .3)
</style>
