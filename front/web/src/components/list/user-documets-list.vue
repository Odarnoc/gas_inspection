<template>
  <q-list bordered padding class="rounded-borders">
    <q-item-label header>{{ $t('menus.documents') }}</q-item-label>

    <documentExpansionItem
      :generalId="id"
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
      :docId="doc.user_document_id ?? 0"
      :expirationDate="doc.expiration_date"
      :notes="doc.return_notes"
      @onDocumentUpdated="onDocumentUpdated"
      :disable="$hasRoles([$typesRol.client]) ? !doc.requested : false"
      :uploadDocument="updateDocumentData"
      :updateExpiration="updateExpiration"
      :documentUrl="createFileRoute"
      :isAdminView="isAdminView"
      :document_identifier_boolean="doc.identifier"
      :document_identifier_string="doc.document_identifier"
    >
      <template v-slot:side>
        <div class="row items-center" v-if="$hasRoles([$typesRol.admin, $typesRol.verificator])">
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
    allVerify: {
      type: Boolean
    },
    isAdminView: {
      type: Boolean,
      default: false
    }
  },
  computed: {
    ...mapGetters('users/users', { role: 'role', userId: 'id' }),
    createFileRoute () {
      return `${GENERAL_ROUTES.user}${this.id}/${SPECIFIC_ROUTES_USERS.driverDocuments}${this.documentOpen}`
    }
  },
  mounted () {},
  created () {
    self = this
  },
  methods: {
    ...mapActions('system/driverDocuments', ['getTableToUsers']),
    ...mapActions('drivers/documents', [
      'getDocumentsToUser',
      'verify',
      'updateDocumentData',
      'updateExpiration'
    ]),
    isVerifyAvailable (doc) {
      if (doc.requested) {
        return true
      }
      if (!doc.user_document_id) {
        return true
      }
      return false
    },
    async fetchFromServer () {
      const response = await self.getDocumentsToUser(self.id)
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
        if (doc.verified) {
          self.$emit('unverified', true)
        }
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
      await self.fetchFromServer()
    },
    async onDocumentUpdated (e) {
      if (e.type === 'uploadDoc') {
        self.documentOpen = null
      }
      await self.fetchFromServer()
    },
    editSelectedRow (id) {
      self.$router.push(`/sysDocuments/edit/${self.$encode(id)}`)
    },
    show (id) {
      self.documentOpen = id
    },
    hide (id) {
      if (self.documentOpen === id) {
        self.documentOpen = null
      }
    },
    getImageByRole (doc) {
      if (self.$hasRoles([self.$typesRol.client])) {
        return doc.image_url
      }
      return doc.document_url
    }
  }
})
</script>
