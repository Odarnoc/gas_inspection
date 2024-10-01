<template>
  <q-card class="bg-transparent no-shadow no-border" bordered>
    <q-card-section class="q-pa-none">
      <div class="row q-col-gutter-sm">
        <div v-for="(item, index) in items" :key="index" class="col-md-3 col-sm-12 col-xs-12">
          <q-item :style="`background-color: ${item.color1}`" class="q-pa-none">
            <q-item-section
              v-if="icon_position === 'left'"
              side
              :style="`background-color: ${item.color2}`"
              class="q-pa-lg q-mr-none text-white"
            >
              <q-icon :name="item.icon" color="white" size="24px"></q-icon>
            </q-item-section>
            <q-item-section class="q-pa-md q-ml-none text-white">
              <q-item-label class="text-white text-h6 text-weight-bolder">{{ item.value }}</q-item-label>
              <q-item-label>{{ item.title }}</q-item-label>
            </q-item-section>
            <q-item-section v-if="icon_position === 'right'" side class="q-mr-md text-white">
              <q-icon :name="item.icon" color="white" size="44px"></q-icon>
            </q-item-section>
          </q-item>
        </div>
      </div>
    </q-card-section>
  </q-card>
</template>

<script>
import { defineComponent } from 'vue'
import { mapActions } from 'vuex'

export default defineComponent({
  name: 'CardSocial',
  data () {
    return {
      activeUsers: 0,
      completedProyects: 0,
      activeProyects: 0,
      executingProyects: 0
    }
  },
  props: {
    icon_position: {
      required: false,
      default: 'left'
    }
  },
  computed: {
    items: function () {
      return [
        {
          title: this.$t('fields.activeUsers'),
          icon: 'person',
          value: this.activeUsers,
          color1: '#006b65',
          color2: '#006b65'
        },
        {
          title: this.$t('fields.completedProyects'),
          icon: 'assignment',
          value: this.completedProyects,
          color1: '#1cb000',
          color2: '#1cb000'
        },
        {
          title: this.$t('fields.activeProyects'),
          icon: 'assignment',
          value: this.activeProyects,
          color1: '#fdad00',
          color2: '#fdad00'
        },
        {
          title: this.$t('fields.executingProyects'),
          icon: 'assignment',
          value: this.executingProyects,
          color1: '#fe634d',
          color2: '#fe634d'
        }
      ]
    }
  },
  mounted () {
    this.fetchFromServer()
  },
  methods: {
    ...mapActions('vendor/requestPetition', ['getAdminDashboard']),
    async fetchFromServer () {
      this.$showLoading()
      const response = await this.getAdminDashboard()
      this.activeUsers = response.data.activeUsers
      this.completedProyects = response.data.completedProyects
      this.activeProyects = response.data.activeProyects
      this.executingProyects = response.data.executingProyects
      this.$destroyLoading()
    }
  }
})
</script>
