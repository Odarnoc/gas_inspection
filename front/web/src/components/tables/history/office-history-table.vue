<template>
  <base-table
    :columns="columnsHistory "
    :fetchData="getOfficeHistory"
    :pag="pagination"
    ref="officeOrdersTable"
  >
    <template v-slot:header="props">
      <q-tr :props="props">
        <q-th auto-width />
        <q-th v-for="col in props.cols" :key="col.name" :props="props">{{ col.label }}</q-th>
      </q-tr>
    </template>
    <template v-slot:body="props">
      <q-tr :props="props">
        <q-td auto-width>
          <q-btn
            size="sm"
            color="primary"
            round
            dense
            @click="fetchOrderInfo(props)"
            :icon="props.expand ? 'remove' : 'add'"
          />
        </q-td>
        <q-td key="user.fullName" :props="props">{{ props.row.user.fullName }}</q-td>
        <q-td key="p.clientName" :props="props">{{ props.row.clientName }}</q-td>
        <q-td key="p.clientPhone" :props="props">{{ props.row.clientPhone }}</q-td>
        <q-td key="p.status" :props="props">{{ $translateStatus(props.row.status) }}</q-td>
        <q-td key="total" :props="props">${{ $formatNumber(props.row.total) }}</q-td>
        <q-td key="p.createdAt" :props="props">{{ $toUSADateTime(props.row.createdAt) }}</q-td>
      </q-tr>
      <q-tr v-show="props.expand" :props="props">
        <q-td colspan="100%">
          <q-list>
            <q-item>
              <q-item-section avatar>
                <q-icon color="positive" name="location_on" />
              </q-item-section>

              <q-item-section>
                <q-item-label>{{ $t('fields.origin') }}:</q-item-label>
                <q-item-label caption>{{ props.row.originAddress }}</q-item-label>
              </q-item-section>
            </q-item>

            <q-item>
              <q-item-section avatar>
                <q-icon color="red" name="location_on" />
              </q-item-section>

              <q-item-section>
                <q-item-label>{{ $t('fields.destiny') }}:</q-item-label>
                <q-item-label caption>{{ props.row.destinationAddress }}</q-item-label>
              </q-item-section>
            </q-item>

            <q-item>
              <q-item-section avatar>
                <q-icon color="amber" name="notes" />
              </q-item-section>

              <q-item-section>
                <q-item-label>{{ $t('fields.notesForDriver') }}:</q-item-label>
                <q-item-label caption>{{ props.row.note }}</q-item-label>
              </q-item-section>
            </q-item>
          </q-list>
          <q-list v-if="props.row.deliveryman">
            <q-item>
              <q-item-section avatar>
                <q-icon color="primary" name="schedule" />
              </q-item-section>

              <q-item-section>
                <q-item-label>{{ $t('fields.pickUpTime') }}:</q-item-label>
                <q-item-label caption>{{ $toUSADateTime(props.row.pickUpTime) }}</q-item-label>
              </q-item-section>
            </q-item>

            <q-item>
              <q-item-section avatar>
                <q-icon color="primary" name="person" />
              </q-item-section>

              <q-item-section>
                <q-item-label>{{ $t('fields.driver') }}:</q-item-label>
                <q-item-label caption>{{ props.row.deliveryman.fullName }}</q-item-label>
              </q-item-section>
            </q-item>

            <q-item>
              <q-item-section avatar>
                <q-icon color="primary" name="phone" />
              </q-item-section>

              <q-item-section>
                <q-item-label>{{ $t('fields.phone') }}:</q-item-label>
                <q-item-label caption>{{ props.row.deliveryman.phone }}</q-item-label>
              </q-item-section>
            </q-item>

            <q-item v-bind:key="vehicle" v-for="vehicle in props.row.deliveryman.vehicles">
              <q-item-section avatar>
                <q-icon color="amber" name="directions_car" />
              </q-item-section>

              <q-item-section>
                <q-item-label>{{ $t('fields.vehicle') }}:</q-item-label>
                <q-item-label caption>{{ vehicle.mark }} {{ vehicle.model }}</q-item-label>
                <br />
                <q-item-label>{{ $t('fields.plate') }}:</q-item-label>
                <q-item-label caption>{{ vehicle.plate }}</q-item-label>
              </q-item-section>
            </q-item>
          </q-list>
        </q-td>
      </q-tr>
    </template>
  </base-table>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  name: 'office-history-table',
  data () {
    return {
      pagination: {
        sortBy: 'p.id'
      },
      loading: false,
      filter: '',
      carrierId: 0
    }
  },
  computed: {
    columnsHistory () {
      return [
        {
          name: 'user.fullName',
          align: 'left',
          label: this.$t('fields.createdBy'),
          field: 'user.fullName',
          sortable: true
        },
        {
          name: 'p.clientName',
          align: 'left',
          label: this.$t('fields.clientName'),
          field: 'p.clientName',
          sortable: true
        },
        {
          name: 'p.clientPhone',
          align: 'left',
          label: this.$t('fields.clientPhone'),
          field: 'p.clientPhone',
          sortable: true
        },
        {
          name: 'p.status',
          align: 'left',
          label: this.$t('fields.status'),
          field: 'p.status',
          sortable: true
        },
        {
          name: 'total',
          align: 'left',
          label: this.$t('fields.amount'),
          field: 'total',
          sortable: true
        },
        {
          name: 'p.createdAt',
          align: 'left',
          label: this.$t('fields.date'),
          field: 'p.createdAt',
          sortable: true
        }
      ]
    }
  },
  mounted () {
    this.fetchFromServer()
  },
  methods: {
    ...mapActions('drivers/petitions', ['getOfficeHistory']),
    async fetchFromServer () {
      this.$showLoading()
      this.$destroyLoading()
    },
    async fetchOrderInfo (props) {
      this.$showLoading()
      this.$refs.officeOrdersTable.setExpanded(props.key)
      this.$destroyLoading()
    },
    async refreshTable () {
      this.$showLoading()
      await this.$refs.officeOrdersTable.onRequest({
        pagination: this.$refs.officeOrdersTable.pagination,
        filter: undefined
      })
      this.$destroyLoading()
    }
  }
}
</script>

<style>
</style>
