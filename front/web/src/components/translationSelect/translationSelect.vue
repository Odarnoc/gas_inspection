<template>
  <q-btn-dropdown color="white" flat icon="fas fa-language">
    <q-list>
      <q-item
        v-bind:key="(currentlang, index)"
        v-for="(currentlang, index) in langOptions"
        :disable="$i18n.locale == currentlang.value"
        clickable
        v-close-popup
        @click="changeLanguaje(currentlang.value)"
      >
        <q-item-section avatar>
          <q-avatar :icon="`img:statics/countryFlags/${currentlang.icon}`" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{currentlang.label}}</q-item-label>
        </q-item-section>
      </q-item>
    </q-list>
  </q-btn-dropdown>
</template>

<script>
import { defineComponent } from 'vue'
export default defineComponent({
  name: 'translationSelect',
  data () {
    return {}
  },
  props: {},
  computed: {
    langOptions () {
      return [
        {
          value: 'en',
          label: this.$t('lang.en'),
          icon: 'united-states-round.png'
        },
        { value: 'es', label: this.$t('lang.es'), icon: 'mexico-round.png' }
      ]
    }
  },
  methods: {
    changeLanguaje (lang) {
      this.$i18n.locale = lang
      this.$setDefaultHTTPLanguajeCode()
    }
  }
})
</script>
<style lang="sass">
</style>
