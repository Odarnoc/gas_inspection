<template>
  <q-list bordered padding class="rounded-borders">
    <q-item-label header>{{ $t('menus.documents') }}</q-item-label>

    <documentExpansionItem
      :generalId="+vehicle_id"
      v-bind:key="doc"
      v-for="doc in documents"
      group="documentsGroup"
      :title="doc.name"
      @show="show(doc.id)"
      @hide="hide(doc.id)"
      :documentOpen="documentOpen"
      :subtitle="$documentStatus(doc.requested, doc.verified)"
      :description="doc.description"
      :docTypeId="doc.id"
      :icon="$documentIcon(role, doc.requested, doc.verified)"
      :image="getImageByRole(doc)"
      :docId="doc.vehicle_document_id ?? 0"
      :expirationDate="doc.expiration_date"
      :notes="doc.return_notes"
      @onDocumentUpdated="onDocumentUpdated"
      :disable="$hasRoles([$typesRol.deliveryman]) ? !doc.requested : false"
      :uploadDocument="updateDocumentData"
      :updateExpiration="updateExpiration"
      :documentUrl="createFileRoute"
      :isAdminView="isAdminView"
      :document_identifier_boolean="doc.identifier"
      :document_identifier_string="doc.document_identifier"
    >
      <template v-slot:side>
        <div
          class="row items-center"
          v-if="$hasRoles([$typesRol.admin, $typesRol.verificator, $typesRol.super_admin])"
        >
          <q-btn
            class="q-mr-sm"
            round
            :color="doc.verified?'positive':'negative'"
            icon="check"
            @click="onVerify(doc)"
          >
            <q-tooltip>{{ doc.verified ? $t('dialogs.document_verified') : $t('dialogs.document_not_verified') }}</q-tooltip>
          </q-btn>
        </div>
      </template>
    </documentExpansionItem>
  </q-list>
</template>

<script>
import { GENERAL_ROUTES, SPECIFIC_ROUTES_USERS } from 'src/commons/filesRoutes'
import { defineComponent } from 'vue'
import { mapActions, mapGetters } from 'vuex'

let self
export default defineComponent({
  name: 'Error404',
  data () {
    return {
      documents: [],
      documentOpen: null
    }
  },
  props: {
    id: [String, Number],
    vehicle_id: [String, Number],
    allVerify: {
      type: Boolean
    },
    isAdminView: {
      type: Boolean,
      default: false
    }
  },
  computed: {
    ...mapGetters('users/users', { role: 'role' }),
    createFileRoute () {
      return `${GENERAL_ROUTES.user}${this.id}/${SPECIFIC_ROUTES_USERS.vehiclesDocuments}${this.vehicle_id}/`
    }
  },
  created () {
    self = this
  },
  methods: {
    ...mapActions('system/vehicleDocuments', ['getTable']),
    ...mapActions('vehicles/documents', [
      'getDocuments',
      'verify',
      'updateDocumentData',
      'updateExpiration'
    ]),
    isVerifyAvailable (doc) {
      if (doc.requested) {
        return true
      }
      if (!doc.vehicle_document_id) {
        return true
      }
      return false
    },
    async fetchFromServer () {
      const response = await self.getDocuments(self.vehicle_id)
      if (response.data.document) {
        self.documents = response.data.document
      }
      let allComplete = true
      for (let index = 0; index < self.documents.length; index++) {
        if (!self.documents[index].verified) {
          allComplete = false
          break
        }
      }
      self.$emit('update:allVerify', allComplete)
    },
    async onVerify (doc) {
      this.$showLoading()
      self.$showLoading()
      let data = {}
      self.$showLoading()
      try {
        const response = await self.verify(doc)
        data = {
          message: self.$t(`messages.success.${response.data.message}`),
          result: response.data.result
        }
        await self.fetchFromServer()
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
      self.loading = false
      await this.fetchFromServer()
      if (doc.verified) {
        self.$emit('unverified', true)
      }
      this.$destroyLoading()
    },
    async onDocumentUpdated (e) {
      if (e.type === 'uploadDoc') {
        this.documentOpen = null
      }
      await this.fetchFromServer()
    },
    show (id) {
      this.documentOpen = id
    },
    hide (id) {
      if (this.documentOpen === id) {
        this.documentOpen = null
      }
    },
    getImageByRole (doc) {
      if (self.$hasRoles([self.$typesRol.deliveryman])) {
        return doc.image_url
      }
      return doc.document_url
    }
  }
})
</script>
