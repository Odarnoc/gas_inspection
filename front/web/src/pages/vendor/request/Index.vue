<template>
  <q-page>
    <header-pages :breadCrumRoutes="breadCrumRoutes" />

    <div class="q-pa-md bg-grey-3">
      <div class="row bg-white border-panel">
        <div class="col q-pa-md">
          <div class="row q-mb-sm q-mt-md">
            <div class="col-12">
              <div class="row q-col-gutter-xs q-mb-md">
                <div class="col-12">
                  <q-btn
                    class="float-right"
                    color="secondary"
                    icon="add"
                    :label="$t('buttons.new')"
                    @click="$router.push('/request/new')"
                  />
                </div>
              </div>
              <base-table
                ref="table"
                :columns="columnsServices"
                :fetchData="getTable"
                :pag="pagination"
              >
                <template v-slot:body="props">
                  <q-tr :props="props">
                    <q-td key="firstName" :props="props">{{ props.row.firstName }}</q-td>
                    <q-td key="proyectType.name" :props="props">{{ props.row.proyectType.name }}</q-td>
                    <q-td key="phone" :props="props">{{ props.row.phone }}</q-td>
                    <q-td key="startDate" :props="props">{{ props.row.startDate }}</q-td>
                    <q-td key="limitDate" :props="props">{{ props.row.limitDate }}</q-td>
                    <q-td key="status" :props="props">{{ getStatusName(props.row.status) }}</q-td>
                    <q-td key="details" :props="props">{{ props.row.details }}</q-td>
                    <q-td key="actions" :props="props">
                      <q-btn
                        color="primary"
                        icon="fas fa-edit"
                        flat
                        @click="editSelectedRow(props.row.id)"
                        size="10px"
                      />
                    </q-td>
                  </q-tr>
                </template>
              </base-table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </q-page>
</template>

<script>
import { mapActions } from 'vuex'
import { statusOrder } from 'src/commons/status'
export default {
  name: 'UserTypeList',
  data () {
    return {
      pagination: {
        sortBy: 'id'
      },
      loading: false,
      filter: '',
      carrierId: 0
    }
  },
  computed: {
    breadCrumRoutes () {
      return [this.$t('menus.requests')]
    },
    columnsServices () {
      return [
        {
          name: 'firstName',
          align: 'left',
          label: this.$t('fields.firstName'),
          field: 'firstName',
          sortable: true
        },
        {
          name: 'proyectType.name',
          align: 'left',
          label: this.$t('fields.proyectType'),
          field: 'proyectType.name',
          sortable: true
        },
        {
          name: 'phone',
          align: 'left',
          label: this.$t('fields.phone'),
          field: 'phone',
          sortable: true
        },
        {
          name: 'startDate',
          align: 'left',
          label: this.$t('fields.startDate'),
          field: 'startDate',
          sortable: true
        },
        {
          name: 'limitDate',
          align: 'left',
          label: this.$t('fields.limitDate'),
          field: 'limitDate',
          sortable: true
        },
        {
          name: 'status',
          align: 'left',
          label: this.$t('fields.proyectStatus'),
          field: 'status',
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
  mounted () {
    this.fetchFromServer()
  },
  methods: {
    ...mapActions('vendor/requestPetition', ['getTable', 'delete']),
    async fetchFromServer () {
      this.$showLoading()
      this.$destroyLoading()
    },
    async fetchTableDataByFilters () {
      this.$showLoading()
      await this.$refs.table.onRequest({
        pagination: this.$refs.table.pagination,
        filter: undefined
      })
      this.$destroyLoading()
    },
    editSelectedRow (id) {
      this.$router.push(`/request/edit/${this.$encode(id)}`)
    },
    async deleteSelectedRow (id) {
      if (!(await this.$confirmDialog(this.$t('dialogs.deleteProyectType')))) {
        return
      }
      this.loading = true
      this.$showLoading()
      try {
        const response = await this.delete(id)
        this.$showNotifySuccess(response)
        await this.fetchTableDataByFilters()
      } catch (error) {
        console.log(error)
        this.$showNotifyError(error)
      }
      this.$destroyLoading()
      this.loading = false
    },
    getStatusName (status) {
      let statusName = ''
      switch (status) {
        case statusOrder.ASSIGNED:
          statusName = this.$t('requestPetitionStatus.assigned')
          break
        default:
          break
      }
      return statusName
    }
  }
}
</script>

<style>
</style>
