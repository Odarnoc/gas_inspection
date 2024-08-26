<template>
  <base-table
    :columns="columns"
    :fetchData="getTable"
    :pag="pagination"
    :fetchParams="{ driverId: driverId, isActive: isActive }"
    ref="vehicleTable"
  >
    <template v-slot:body="props">
      <q-tr :props="props">
        <q-td key="actions" :props="props">
          <q-btn
            color="primary"
            icon="fas fa-edit"
            flat
            @click="editSelectedRow(props.row.id)"
            size="10px"
            v-if="!isVerifyTable"
          />
          <q-btn
            color="negative"
            icon="fas fa-trash"
            flat
            @click="deleteSelectedRow(props.row.id)"
            size="10px"
            v-if="$hasRoles([$typesRol.deliveryman]) && !props.row.deletedAt"
          />
          <q-btn
            color="positive"
            icon="restore_from_trash"
            flat
            @click="restoreSelectedRow(props.row.id)"
            size="10px"
            v-if="$hasRoles([$typesRol.deliveryman]) && props.row.deletedAt"
          />
          <q-btn
            color="primary"
            icon="visibility"
            flat
            @click="editSelectedRow(props.row.id)"
            size="10px"
            v-if="isVerifyTable"
          />
        </q-td>
        <q-td key="mark" :props="props">{{ props.row.mark }}</q-td>
        <q-td key="model" :props="props">{{ props.row.model }}</q-td>
        <q-td key="year" :props="props">{{ props.row.year }}</q-td>
        <q-td key="plate" :props="props">{{ props.row.plate }}</q-td>
        <q-td key="color" :props="props">{{ props.row.color }}</q-td>
        <q-td key="default_vehicle" :props="props" v-if="!props.row.deletedAt">
          <q-btn
            icon="star"
            flat
            :color="$setColorDefaultVehicle(props.row.default_vehicle)"
            @click="setDefultVehicle(props.row.id, props.row.verified, props.row.default_vehicle)"
            size="20px"
            v-if="isVerifyTable"
          />
          <q-btn
            icon="star"
            flat
            :color="$setColorDefaultVehicle(props.row.default_vehicle)"
            size="20px"
            v-else
          />
        </q-td>
        <q-td key="verified" :props="props">
          <q-badge :color="$verifyColor(props.row.verified)">{{ $verifyLabel(props.row.verified) }}</q-badge>
        </q-td>
      </q-tr>
      <q-tr v-show="props.expand" :props="props">
        <q-td colspan="100%">
          <q-card class="my-card" v-bind:key="d" v-for="d in documents">
            <q-item>
              <q-item-section>
                <q-item-label>{{d.name}}</q-item-label>
              </q-item-section>
            </q-item>
            <image-reference :imageUrl="d.document_url" />
          </q-card>
        </q-td>
      </q-tr>
    </template>
  </base-table>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  name: 'DriverVehiclesList',
  data () {
    return {
      pagination: {
        sortBy: 'mark'
      },
      loading: false,
      filter: '',
      carrierId: 0,
      documents: []
    }
  },
  props: {
    driverId: {
      type: Number,
      default: null
    },
    isVerifyTable: {
      type: Boolean,
      default: false
    },
    isActive: {
      type: [String],
      default: null
    }
  },
  computed: {
    columns () {
      return [
        {
          name: 'actions',
          align: 'center',
          label: this.$t('buttons.actions'),
          field: 'actions',
          sortable: false
        },
        {
          name: 'mark',
          align: 'left',
          label: this.$t('fields.mark'),
          field: 'mark',
          sortable: true
        },
        {
          name: 'model',
          align: 'left',
          label: this.$t('fields.model'),
          field: 'model',
          sortable: true
        },
        {
          name: 'year',
          align: 'left',
          label: this.$t('fields.year'),
          field: 'year',
          sortable: true
        },
        {
          name: 'plate',
          align: 'left',
          label: this.$t('fields.plate'),
          field: 'plate',
          sortable: true
        },
        {
          name: 'color',
          align: 'left',
          label: this.$t('fields.color'),
          field: 'color',
          sortable: true
        },
        {
          name: 'default_vehicle',
          align: 'left',
          label: this.$t('fields.default_vehicle'),
          field: 'default_vehicle',
          sortable: true
        },
        ...(!this.isVerifyTable
          ? [
              {
                name: 'verified',
                align: 'left',
                label: this.$t('fields.verification'),
                field: 'verified',
                sortable: true
              }
            ]
          : [])
      ]
    }
  },
  methods: {
    ...mapActions('vehicles/vehicles', [
      'getTable',
      'setDefaultVehicle',
      'softDeleteVehicle',
      'restoreDeleteVehicle'
    ]),
    ...mapActions('vehicles/documents', ['getDocuments']),
    async fetchFromServer () {
      this.$showLoading()
      this.$destroyLoading()
    },
    editSelectedRow (id) {
      window.open(`/vehicles/edit/${this.$encode(id)}`)
    },
    async setDefultVehicle (id, isVerify, isDefault) {
      if (!this.isVerifyTable) {
        return
      }
      if (!(await this.$confirmDialog(this.$t('dialogs.setDefaultVehicle')))) {
        return
      }
      let data = {}
      if (!isVerify) {
        data = {
          message: this.$t('messages.errorSpecific.unverifyVehicle'),
          result: false
        }
        this.$showNotifyMessage(data)
        return false
      }
      if (isDefault) {
        data = {
          message: this.$t('messages.errorSpecific.defaultVehicleSet'),
          result: false
        }
        this.$showNotifyMessage(data)
        return false
      }

      this.$showLoading()
      const params = {
        id: id,
        default_vehicle: true
      }
      try {
        const response = await this.setDefaultVehicle(params)
        data = {
          message: this.$t(`messages.success.${response.data.message}`),
          result: response.data.result
        }
        await this.$refs.vehicleTable.onRequest({
          pagination: this.$refs.vehicleTable.pagination,
          filter: undefined
        })
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
    },
    async fetchTableDataByFilters () {
      this.$showLoading()
      await this.$refs.vehicleTable.onRequest({
        pagination: this.$refs.vehicleTable.pagination,
        filter: undefined
      })
      this.$destroyLoading()
    },
    async deleteSelectedRow (id) {
      if (!(await this.$confirmDialog(this.$t('dialogs.removeVehicle')))) {
        return
      }
      this.loading = true
      this.$showLoading()
      let data = {}
      try {
        const response = await this.softDeleteVehicle(id)
        data = {
          message: this.$t(`messages.success.${response.data.message}`),
          result: response.data.result
        }
        this.fetchTableDataByFilters()
      } catch (error) {
        if (error.response.data.codeError) {
          data = {
            message: this.$t(
              `messages.errorCode.${error.response.data.codeError}`
            ),
            result: false
          }
        } else {
          data = {
            message: this.$t(
              `messages.errorSpecific.${error.response.data.message[0]}`
            ),
            result: false
          }
        }
      }
      this.$showNotifyMessage(data)
      this.$destroyLoading()
      this.loading = false
    },
    async restoreSelectedRow (id) {
      if (!(await this.$confirmDialog(this.$t('dialogs.restoreVehicle')))) {
        return
      }
      this.loading = true
      this.$showLoading()
      let data = {}
      try {
        const response = await this.restoreDeleteVehicle(id)
        data = {
          message: this.$t(`messages.success.${response.data.message}`),
          result: response.data.result
        }
        await this.fetchTableDataByFilters()
      } catch (error) {
        if (error.response.data.codeError) {
          data = {
            message: this.$t(
              `messages.errorCode.${error.response.data.codeError}`
            ),
            result: false
          }
        } else {
          data = {
            message: this.$t(
              `messages.errorSpecific.${error.response.data.message[0]}`
            ),
            result: false
          }
        }
      }
      this.$showNotifyMessage(data)
      this.$destroyLoading()
      this.loading = false
    },
    async getVehicleDocuments (id) {
      const response = await this.getDocuments(id)
      this.documents = response.data.document
    }
  }
}
</script>

<style>
</style>
