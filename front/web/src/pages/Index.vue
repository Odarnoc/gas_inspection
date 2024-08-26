<template>
  <q-page class="page-background flex flex-center">
    <img src="statics/Logo.png" style="width: 200px; height: 200px" />
  </q-page>
</template>

<script>
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'PageIndex',
  created () {
    if (this.$hasRoles([this.$typesRol.deliveryman, this.$typesRol.client])) {
      this.$router.push('/driverComplement')
    }
  }
})
</script>
