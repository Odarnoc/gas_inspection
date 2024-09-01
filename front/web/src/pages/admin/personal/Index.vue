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
                    @click="$router.push('/personal/new')"
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
                    <q-td key="email" :props="props">{{ props.row.email }}</q-td>
                    <q-td key="firstName" :props="props">{{ props.row.firstName }}</q-td>
                    <q-td key="paternalName" :props="props">{{ props.row.paternalName }}</q-td>
                    <q-td key="maternalName" :props="props">{{ props.row.maternalName }}</q-td>
                    <q-td key="phone" :props="props">{{ props.row.phone }}</q-td>
                    <q-td key="cellphone" :props="props">{{ props.row.cellphone }}</q-td>
                    <q-td key="roles" :props="props">{{ getRolName(props.row.roles) }}</q-td>
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
        sortBy: 'id'
      },
      loading: false,
      filter: '',
      carrierId: 0
    }
  },
  computed: {
    breadCrumRoutes () {
      return [this.$t('menus.personal')]
    },
    columnsServices () {
      return [
        {
          name: 'email',
          align: 'left',
          label: this.$t('fields.email'),
          field: 'email',
          sortable: true
        },
        {
          name: 'firstName',
          align: 'left',
          label: this.$t('fields.firstName'),
          field: 'firstName',
          sortable: true
        },
        {
          name: 'paternalName',
          align: 'left',
          label: this.$t('fields.paternalName'),
          field: 'paternalName',
          sortable: true
        },
        {
          name: 'maternalName',
          align: 'left',
          label: this.$t('fields.maternalName'),
          field: 'maternalName',
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
          name: 'cellphone',
          align: 'left',
          label: this.$t('fields.cellphone'),
          field: 'cellphone',
          sortable: true
        },
        {
          name: 'roles',
          align: 'left',
          label: this.$t('fields.rol'),
          field: 'roles',
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
    ...mapActions('users/auth', ['getTable', 'delete']),
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
      this.$router.push(`/personal/edit/${this.$encode(id)}`)
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
        this.$showNotifyError(error)
      }
      this.$destroyLoading()
      this.loading = false
    },
    getRolName (roles) {
      let rolName = ''
      if (roles?.length > 0) {
        const rol = roles[0]
        switch (rol) {
          case this.$typesRol.admin:
            rolName = this.$t('roles.admin')
            break
          case this.$typesRol.vendor:
            rolName = this.$t('roles.vendor')
            break
          case this.$typesRol.inspector:
            rolName = this.$t('roles.inspector')
            break
          default:
            break
        }
      }
      return rolName
    }
  }
}
</script>

<style>
</style>
