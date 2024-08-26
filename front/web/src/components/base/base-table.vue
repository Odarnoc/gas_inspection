<template>
  <q-table
    class="my-sticky-dynamic"
    :rows="rows"
    :columns="columns"
    @request="onRequest"
    v-model:pagination="pagination"
    :loading="loading"
    :rows-per-page-options="rowsPerPageOptions"
    flat
    bordered
    virtual-scroll
    binary-state-sort
    :no-data-label="$t('no_data')"
    :no-result-label="$t('no_data')"
    :rows-per-page-label="$t('rows_per_page_label')"
    ref="baseTable"
  >
    <template v-slot:header="props" v-if="$slots.header">
      <slot name="header" v-bind="props"></slot>
    </template>
    <template v-slot:body="props" v-if="$slots.body">
      <slot name="body" v-bind="props"></slot>
    </template>
    <template v-slot:loading>
      <q-inner-loading showing color="primary" />
    </template>
  </q-table>
</template>

<script>
let self
// import { mapActions, mapGetters } from 'vuex'
export default {
  name: 'base-table',
  data () {
    return {
      rows: [],
      pagination: {},
      rowsPerPageOptions: [5, 10, 15, 20, 25, 50],
      loading: false,
      filter: ''
    }
  },
  props: {
    fetchParams: {
      type: Object,
      default: function () {
        return {}
      }
    },
    fetchData: Function,
    columns: Array,
    pag: {
      type: Object,
      default: function () {
        return {}
      }
    }
  },
  computed: {
    // ...mapGetters('users', ['rowsPerPage']),
  },
  created () {
    self = this
    const { page, rowsPerPage, sortBy, descending, rowsNumber } = self.pag
    self.pagination = {
      page: page ?? 1,
      rowsPerPage: rowsPerPage ?? self.rowsPerPageOptions[0],
      rowsNumber: rowsNumber ?? 0,
      descending: descending ?? true,
      sortBy: sortBy ?? self.columns[1].name
    }
  },
  async mounted () {
    await self.onRequest({
      pagination: self.pagination,
      filter: undefined
    })
  },
  methods: {
    // ...mapActions('users', ['updateRowsPerPage'])
    async onRequest (props) {
      const { page, rowsPerPage, sortBy, descending } = props.pagination
      if (!localStorage.getItem('returnFlag')) {
        localStorage.setItem('page', page)
        localStorage.setItem('rowsPerPage', rowsPerPage)
        localStorage.setItem('sortBy', sortBy)
        localStorage.setItem('descending', descending)
      }
      const paginationParams = {
        page: !localStorage.getItem('returnFlag')
          ? page
          : Number(localStorage.getItem('page')),
        rowsPerPage: !localStorage.getItem('returnFlag')
          ? rowsPerPage
          : Number(localStorage.getItem('rowsPerPage')),
        sortBy: !localStorage.getItem('returnFlag')
          ? sortBy
          : Number(localStorage.getItem('sortBy')),
        descending: !localStorage.getItem('returnFlag')
          ? descending
          : Number(localStorage.getItem('descending'))
      }
      const params = Object.assign(paginationParams, self.fetchParams)
      self.loading = true
      const response = await self.fetchData(params)
      self.rows = response.data.tableData.items
      self.pagination.page = response.data.tableData.current
      self.pagination.rowsPerPage = response.data.tableData.limit
      self.pagination.rowsNumber = response.data.tableData.total_items
      self.pagination.sortBy = response.data.tableData.sortBy
      self.pagination.descending = response.data.tableData.descending
      self.loading = false
      if (localStorage.getItem('returnFlag') === 'true') {
        localStorage.removeItem('returnFlag')
      }
      this.$emit('request', self.pagination)
    },
    setExpanded (key) {
      const isExpanded = this.$refs.baseTable.isRowExpanded(key)
      this.$refs.baseTable.setExpanded([])
      if (!isExpanded) {
        this.$refs.baseTable.setExpanded([key])
      }
    }
  }
}
</script>
<style lang="sass">
.my-sticky-dynamic
  /* height or max-height is important */
  font-size: 1.5em
  max-height: 80vh

  .q-table__top,
  .q-table__bottom,
  thead tr:first-child th /* bg color is important for th; just specify one */
    background-color: #fff

  thead tr th
    position: sticky
    z-index: 1
  /* this will be the loading indicator */
  thead tr:last-child th
    /* height of all previous header rows */
    top: 48px
  thead tr:first-child th
    top: 0
  .q-inner-loading
    z-index: 1
</style>
