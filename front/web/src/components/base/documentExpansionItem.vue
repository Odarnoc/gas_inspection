<template>
  <q-expansion-item
    expand-icon-toggle
    :group="group"
    @show="show()"
    @hide="hide()"
    :default-opened="documentOpen === docTypeId"
    expand-separator
    icon="perm_identity"
    :disable="disable"
  >
    <template v-slot:header>
      <slot name="tooltip"></slot>
      <q-item-section avatar top>
        <q-avatar :icon="icon" color="primary" text-color="white" />
      </q-item-section>

      <q-item-section>
        <q-item-label lines="1">{{ title }}</q-item-label>
        <q-item-label caption>{{ subtitle }}</q-item-label>
      </q-item-section>

      <q-item-section side>
        <slot name="side"></slot>
      </q-item-section>
    </template>

    <q-card>
      <q-card-section>
        <q-card-section
          v-if="($hasRoles([$typesRol.admin, $typesRol.verificator, $typesRol.super_admin])) && (docId !== null && docId !== '' && docId !== 0)"
        >
          <div class="row q-col-gutter-xs">
            <div class="col-3" v-if="document_identifier_boolean">
              <q-input
                filled
                type="text"
                v-model="document_identifier"
                :label="$t('fields.identifier')"
                @blur="updateExpirationReq()"
              ></q-input>
            </div>
            <div :class="document_identifier_boolean ? 'col-9' : 'col-12'">
              <q-input
                filled
                type="text"
                v-model="expiration"
                :rules="rules.expiration"
                :label="$t('fields.expiration')"
                readonly
              >
                <template v-slot:append>
                  <q-icon name="event" class="cursor-pointer">
                    <q-popup-proxy
                      ref="qDateProxyx2"
                      transition-show="scale"
                      transition-hide="scale"
                    >
                      <q-date
                        :mask="$maskDate"
                        :options="date => date >= mydatenow"
                        color="primary"
                        v-model="expiration"
                      >
                        <div class="row items-center justify-end">
                          <q-btn v-close-popup :label="$t('buttons.close')" color="primary" flat />
                        </div>
                      </q-date>
                    </q-popup-proxy>
                  </q-icon>
                </template>
              </q-input>
            </div>
            <div class="col-12">
              <q-input
                filled
                type="text"
                v-model="return_notes"
                :label="$t('fields.note')"
                @blur="updateExpirationReq()"
              ></q-input>
            </div>
            <div class="col-12">
              <q-btn color="primary" @click="updateExpirationReq()">{{ $t('buttons.update') }}</q-btn>
            </div>
          </div>
        </q-card-section>

        <q-card-section v-if="image">
          <!-- <iframe
            :src="image"
            style="width:100%; max-height: 90vh; min-height: 70vh;"
            frameborder="0"
            v-if="isAdminView"
          />-->
          <q-img class="justify-center" :src="image" />
        </q-card-section>

        <q-card-section>
          <p>{{ description }}</p>
        </q-card-section>

        <q-card-actions vertical>
          <image-upload
            :route="documentUrl"
            @onUploadFile="updateUrlDocument"
            v-if="$hasRoles([$typesRol.deliveryman, $typesRol.client])"
            :buttonText="$t('buttons.upload_document')"
            :round="false"
            icon="upload"
          />
        </q-card-actions>
      </q-card-section>
    </q-card>
  </q-expansion-item>
</template>

<script>
import { mapGetters } from 'vuex'
import { defineComponent } from 'vue'
import { date } from 'quasar'

export default defineComponent({
  name: 'documentExpansionItem',
  data () {
    return {
      mydatenow: date.formatDate(Date.now(), 'YYYY/MM/DD'),
      expiration: null,
      previewData: null,
      preview: false,
      filesImages: null,
      return_notes: null,
      document_identifier: null
    }
  },
  props: {
    generalId: Number,
    actionsPath: {
      type: String,
      default: ''
    },
    docTypeId: {
      type: Number,
      default: 1
    },
    docId: {
      type: Number,
      default: 0
    },
    expirationDate: String,
    group: String,
    title: String,
    subtitle: String,
    description: String,
    verified: Boolean,
    disable: Boolean,
    documentOpen: Number,
    icon: {
      type: String,
      default: 'folder'
    },
    image: {
      type: [String, Number],
      default: '/statics/identificacion.png'
    },
    uploadDocument: Function,
    updateExpiration: Function,
    documentUrl: String,
    notes: String,
    isAdminView: Boolean,
    document_identifier_boolean: Boolean,
    document_identifier_string: String
  },
  computed: {
    ...mapGetters('users/users', { role: 'role', userId: 'id' }),
    rules () {
      return {
        expiration: [
          this.$rules.required(this.$t('validations.required.field'))
        ]
      }
    }
  },
  created () {
    if (this.expirationDate !== null && this.expirationDate !== '') {
      this.expiration = this.$toUSADate(this.expirationDate)
    }
    if (this.notes !== null && this.notes !== '') {
      this.return_notes = this.notes
    }
    if (this.document_identifier_boolean) {
      this.document_identifier = this.document_identifier_string
    }
  },
  methods: {
    async updateExpirationReq () {
      this.$showLoading()
      this.loading = true
      const params = {
        user_document_id: this.docId,
        document_vehicle_id: this.docId,
        expiration: this.$toDBDate(this.expiration),
        return_notes: this.return_notes,
        document_identifier: this.document_identifier
      }
      let data = {}
      try {
        const response = await this.updateExpiration(params)
        data = {
          message: this.$t(`messages.success.${response.data.message}`),
          result: response.data.result
        }
      } catch (error) {
        data = {
          message: this.$t(
            `messages.errorCode.${error.response.data.codeError}`
          ),
          result: false
        }
      }
      this.$showNotifyMessage(data)
      this.$destroyLoading()
      this.loading = false

      this.$emit('onDocumentUpdated', { type: 'updateExpiration' })
    },
    show () {
      this.$emit('show')
    },
    hide () {
      this.$emit('hide')
    },
    async updateUrlDocument (urlDocument) {
      await this.$showLoading()
      const params = {
        id: this.docId,
        document_url: urlDocument,
        document_type_id: this.documentOpen,
        vehicleId: this.generalId
      }
      let data = {}
      try {
        const response = await this.uploadDocument(params)
        data = {
          message: this.$t(`messages.success.${response.data.message}`),
          result: response.data.result
        }
        this.$emit('onDocumentUpdated', { type: 'uploadDoc' })
      } catch (error) {
        data = {
          message: this.$t(
            `messages.errorCode.${error.response.data.codeError}`
          ),
          result: false
        }
      }
      await this.$showNotifyMessage(data)
      await this.$destroyLoading()
    }
  }
})
</script>
<style lang="sass">
</style>
