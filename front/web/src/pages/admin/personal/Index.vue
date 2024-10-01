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
                        color="secondary"
                        icon="fas fa-lock"
                        flat
                        @click="changePasswordSelectedRow(props.row)"
                        size="10px"
                      />
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
    <q-dialog v-model="changePasswordDialog">
      <q-card class="q-dialog-plugin">
        <q-card-section>
          {{ $t('dialogs.changePassword', [
          selectedRow.firstName,
          selectedRow.email
          ]) }}
        </q-card-section>
        <q-card-section>
          <div class="row q-col-gutter-xs">
            <div class="col-12">
              <q-input
                outlined
                bg-color="primary-input-color"
                color="border-primary-input-color"
                label-color="primary-input-color"
                input-class="value-primary-input-color"
                :type="isPwd ? 'password' : 'text'"
                v-model="password"
                :rules="rules.password"
                :label="$t('fields.password')"
              >
                <template v-slot:append>
                  <q-icon
                    :name="isPwd ? 'visibility_off' : 'visibility'"
                    color="white"
                    class="cursor-pointer"
                    @click="isPwd = !isPwd"
                  />
                </template>
              </q-input>
            </div>
          </div>
        </q-card-section>
        <p></p>
        <q-card-actions align="right">
          <q-btn color="negative" :label="$t('buttons.cancel')" @click="hideChangePasswordDialog" />
          <q-btn color="secondary" :label="$t('buttons.save')" @click="updatePassword" />
        </q-card-actions>
      </q-card>
    </q-dialog>
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
      carrierId: 0,
      changePasswordDialog: false,
      selectedRow: {
        id: null,
        firstName: null,
        email: null
      },
      password: null,
      isPwd: true
    }
  },
  computed: {
    breadCrumRoutes () {
      return [this.$t('menus.personal')]
    },
    rules () {
      return {
        password: [this.$rules.required(this.$t('validations.required.field'))]
      }
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
    ...mapActions('users/auth', [
      'getTable',
      'delete',
      'updatePasswordByUserId'
    ]),
    hideChangePasswordDialog () {
      this.changePasswordDialog = false
      this.resetPasswordDialog()
    },
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
    changePasswordSelectedRow (row) {
      this.selectedRow = row
      this.changePasswordDialog = true
    },
    async updatePassword () {
      this.loading = true
      this.$showLoading()
      try {
        const response = await this.updatePasswordByUserId({
          userId: this.selectedRow.id,
          password: this.password
        })
        this.$showNotifySuccess(response)
        this.changePasswordDialog = false
        this.resetPasswordDialog()
        await this.fetchTableDataByFilters()
      } catch (error) {
        this.$showNotifyError(error)
      }
      this.$destroyLoading()
      this.loading = false
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
          case this.$typesRol.instalator:
            rolName = this.$t('roles.instalator')
            break
          default:
            break
        }
      }
      return rolName
    },
    resetPasswordDialog () {
      this.selectedRow = {
        id: null,
        firstName: null,
        email: null
      }
      this.password = null
    }
  }
}
</script>

<style>
</style>
