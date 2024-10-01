<template>
  <div class="q-pa-md bg-grey-3">
    <div class="row bg-white border-panel">
      <div class="col q-pa-md">
        <card-admin-stats />
        <br />
        <p class="text-h5">{{ $t('fields.logsRegistry') }}</p>
        <div class="row q-mb-sm q-mt-md">
          <div class="col-12">
            <base-table
              ref="table"
              :columns="columnsServices"
              :fetchData="getTable"
              :pag="pagination"
            >
              <template v-slot:body="props">
                <q-tr :props="props">
                  <q-td key="createdAt" :props="props">{{ $toUSADateTime(props.row.createdAt) }}</q-td>
                  <q-td key="user.firstName" :props="props">{{ props.row.user.firstName }}</q-td>
                  <q-td key="eventType" :props="props">{{ props.row.eventType }}</q-td>
                  <q-td key="log" :props="props">{{ props.row.log }}</q-td>
                  <q-td key="extraDetails" :props="props">{{ props.row.extraDetails }}</q-td>
                  <q-td key="details" :props="props">{{ props.row.details }}</q-td>
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
          name: 'createdAt',
          align: 'left',
          label: this.$t('fields.createdAt'),
          field: 'createdAt',
          sortable: true
        },
        {
          name: 'user.firstName',
          align: 'left',
          label: this.$t('fields.user'),
          field: 'user.firstName',
          sortable: true
        },
        {
          name: 'eventType',
          align: 'left',
          label: this.$t('fields.eventType'),
          field: 'eventType',
          sortable: true
        },
        {
          name: 'log',
          align: 'left',
          label: this.$t('fields.log'),
          field: 'log',
          sortable: true
        },
        {
          name: 'extraDetails',
          align: 'left',
          label: this.$t('fields.extraDetails'),
          field: 'extraDetails',
          sortable: true
        }
      ]
    }
  },
  mounted () {
    this.fetchFromServer()
  },
  methods: {
    ...mapActions('logs/request', ['getTable']),
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
    }
  }
}
</script>

<style>
</style>
