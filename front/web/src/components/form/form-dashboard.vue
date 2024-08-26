<template>
  <q-form ref="refForm" class="q-gutter-md">
    <div class="row q-col-gutter-xs">
      <div class="col-12">
        <q-input
          readonly
          filled
          type="text"
          v-model="dashboard.fields.finishedOrderCount"
          :label="$t('fields.finishedOrderCount')"
        />
      </div>
      <div class="col-12">
        <q-input
          readonly
          filled
          type="text"
          v-model="dashboard.fields.cancelOrderCount"
          :label="$t('fields.cancelOrderCount')"
        />
      </div>
      <div class="col-12">
        <q-input
          readonly
          filled
          type="text"
          v-model="dashboard.fields.inProgressOrderCount"
          :label="$t('fields.inProgressOrderCount')"
        />
      </div>
      <div class="col-12">
        <q-input
          readonly
          filled
          type="text"
          v-model="dashboard.fields.allOrderCount"
          :label="$t('fields.allOrderCount')"
        />
      </div>
      <slot name="actions"></slot>
    </div>
  </q-form>
</template>

<script>
let self
export default {
  name: 'base-table',
  data () {
    return {
      dashboard: {
        fields: {
          finishedOrderCount: 0,
          cancelOrderCount: 0,
          inProgressOrderCount: 0,
          allOrderCount: 0
        }
      }
    }
  },
  props: {},
  created () {
    self = this
  },
  methods: {
    setData (data) {
      self.dashboard.fields = data
    }
  }
}
</script>
<style lang="sass">
</style>
