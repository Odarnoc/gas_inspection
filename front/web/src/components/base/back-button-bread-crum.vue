<template>
  <q-breadcrumbs align="left">
    <q-breadcrumbs-el>
      <q-btn round color="primary" icon="arrow_back" @click="goBack()" />
    </q-breadcrumbs-el>
  </q-breadcrumbs>
</template>

<script>
export default {
  name: 'back-button-bread-crum',
  props: {
    baseRout: String,
    actualRout: String,
    isClose: Boolean
  },
  methods: {
    goBack () {
      history.back()
    }
  }
}
</script>
<style lang="sass">
</style>
