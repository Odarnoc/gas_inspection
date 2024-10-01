<template>
  <div class="q-pa-md bg-grey-3">
    <div class="row bg-white border-panel">
      <div class="col q-pa-md">
        <card-vendor-stats />
        <br />
        <p class="text-h5">{{ $t('menus.requests') }}</p>
        <div class="row q-mb-sm q-mt-md">
          <div class="col-12">
            <base-table
              ref="table"
              :columns="columnsServices"
              :fetchData="getTableAssigned"
              :pag="pagination"
            >
              <template v-slot:body="props">
                <q-tr :props="props">
                  <q-td key="firstName" :props="props">{{ props.row.firstName }}</q-td>
                  <q-td key="proyectType.name" :props="props">{{ props.row.proyectType.name }}</q-td>
                  <q-td key="phone" :props="props">{{ props.row.phone }}</q-td>
                  <q-td key="startDate" :props="props">{{ props.row.startDate }}</q-td>
                  <q-td key="limitDate" :props="props">{{ props.row.limitDate }}</q-td>
                  <q-td key="status" :props="props">{{ $translateStatus(props.row.status) }}</q-td>
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
</template>

<script>
import { mapActions } from 'vuex'
export default {
  name: 'UserTypeList',
  data () {
    return {
      pagination: {
        sortBy: 'id',
        rowsPerPage: 15
      },
      loading: false,
      filter: '',
      carrierId: 0
    }
  },
  computed: {
    breadCrumRoutes () {
      return [this.$t('menus.chageHistory'), this.$t('menus.requests')]
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
    ...mapActions('vendor/requestPetition', ['getTableAssigned', 'delete']),
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
    }
  }
}
</script>

<style>
</style>
