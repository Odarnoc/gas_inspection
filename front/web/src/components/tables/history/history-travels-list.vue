<template>
  <base-table
    :columns="columnsHistory "
    :fetchData="getHistoryTravels"
    :pag="pagination"
    ref="vehicleTable"
  >
    <template v-slot:body="props">
      <q-tr :props="props">
        <q-td key="user.fullName" :props="props">{{ props.row.user.fullName }}</q-td>
        <q-td key="total" :props="props">${{ $formatNumber(props.row.total) }}</q-td>
        <q-td key="p.originAddress" :props="props">{{ props.row.originAddress }}</q-td>
        <q-td key="p.destinationAddress" :props="props">{{ props.row.destinationAddress }}</q-td>
        <q-td key="p.createdAt" :props="props">{{ $toUSADateTime(props.row.createdAt) }}</q-td>
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
          label: this.$t('fields.client'),
          field: 'user.fullName',
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
          name: 'p.originAddress',
          align: 'left',
          label: this.$t('fields.origin'),
          field: 'p.originAddress',
          sortable: true
        },
        {
          name: 'p.destinationAddress',
          align: 'left',
          label: this.$t('fields.destiny'),
          field: 'p.destinationAddress',
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
    ...mapActions('drivers/petitions', ['getHistoryTravels']),
    async fetchFromServer () {
      this.$showLoading()
      this.$destroyLoading()
    }
  }
}
</script>

<style>
</style>
