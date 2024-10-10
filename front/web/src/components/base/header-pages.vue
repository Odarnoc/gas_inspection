<template>
  <div class="q-pa-sm">
    <div class="row">
      <div class="col-sm-9 q-pt-md q-pl-md">
        <back-button-bread-crum v-if="activateButtonBreadCrum" :isClose="isCloseTab" />
      </div>
      <div class="col-sm-3 pull-right">
        <div class="q-pa-md q-gutter-sm">
          <q-breadcrumbs align="right">
            <q-breadcrumbs-el icon="home" color="primary" to="/" />
            <q-breadcrumbs-el
              :label="breadCrumText"
              v-bind:key="breadCrumText"
              v-for="breadCrumText in breadCrumRoutes"
            />
          </q-breadcrumbs>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'header-pages',
  props: {
    activateButtonBreadCrum: Boolean,
    breadCrumRoutes: Array,
    isCloseTab: {
      type: Boolean,
      default: false
    }
  }
}
</script>
<style lang="sass">
</style>
