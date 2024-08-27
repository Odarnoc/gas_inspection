<template>
  <div class="fullscreen page-background text-white text-center q-pa-md flex flex-center">
    <div>
      <div style="font-size: 20vh">404</div>

      <div class="text-h3" style="opacity:.4">{{$t('dialogs.page_not_found')}}</div>

      <q-btn
        class="q-mt-xl"
        color="white"
        text-color="blue"
        unelevated
        @click="$router.go(-1)"
        :label="$t('buttons.go_back')"
        no-caps
      />
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'Error404'
})
</script>
