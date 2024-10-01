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
                    @click="$router.push('/proyectTypes/new')"
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
                    <q-td key="name" :props="props">{{ props.row.name }}</q-td>
                    <q-td key="details" :props="props">{{ props.row.details }}</q-td>
                    <q-td key="actions" :props="props">
                      <q-btn
                        color="primary"
                        icon="fas fa-edit"
                        flat
                        @click="editSelectedRow(props.row.id)"
                        size="10px"
                      />
                      <q-btn
                        color="negative"
                        icon="fas fa-trash"
                        flat
                        @click="deleteSelectedRow(props.row.id)"
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
      return [this.$t('menus.proyect_type')]
    },
    columnsServices () {
      return [
        {
          name: 'name',
          align: 'left',
          label: this.$t('fields.name'),
          field: 'name',
          sortable: true
        },
        {
          name: 'details',
          align: 'left',
          label: this.$t('fields.details'),
          field: 'details',
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
    ...mapActions('admin/proyectTypes', ['getTable', 'delete']),
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
      this.$router.push(`/proyectTypes/edit/${this.$encode(id)}`)
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
