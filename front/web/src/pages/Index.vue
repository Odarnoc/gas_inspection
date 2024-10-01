<template>
  <q-page class="q-pa-sm">
    <admin-dashboard v-if="$hasRoles([$typesRol.admin])" />
    <vendor-dashboard v-else />
  </q-page>
</template>

<script>
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'PageIndex',
  created () {}
})
</script>
