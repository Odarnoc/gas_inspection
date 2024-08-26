<template>
  <div>
    <router-view />
    <q-dialog
      v-if="globalLoading"
      v-model="globalLoading"
      persistent
      transition-show="scale"
      transition-hide="scale"
    >
      <div class="row q-col-gutter-none no-shadow">
        <div class="col-12">
          <q-spinner-cube color="primary" size="140" class="align-center" />
        </div>
        <div class="col-12">
          <p class="align-center">{{ $t('dialogs.loading') }} ...</p>
        </div>
      </div>
    </q-dialog>
  </div>
</template>
<script>
import { defineComponent } from 'vue'
import axios from 'axios'
import { mapGetters } from 'vuex'

export default defineComponent({
  name: 'App',
  data () {
    return {
      idleModal: false,
      persistent: true
    }
  },
  computed: {
    ...mapGetters('system/generals', ['globalLoading'])
  },
  // beforeCreate () {},
  created () {
    this.$initLanguaje()
    this.$setDefaultHTTPLanguajeCode()
    const JWT = localStorage.getItem('JWT')
    if (JWT !== null && JWT !== '') {
      axios.defaults.headers.common.Authorization = `Bearer ${JWT}`
    }
  },
  mounted () {}
})
</script>
<style scoped>
.align-center {
  display: block;
  margin: 0 auto;
  text-align: center;
}
</style>
