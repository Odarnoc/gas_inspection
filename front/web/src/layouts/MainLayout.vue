<template>
  <q-layout view="hHh Lpr lff">
    <q-header elevated>
      <q-toolbar>
        <q-btn
          flat
          dense
          round
          icon="menu"
          :aria-label="$t('menus.menu')"
          @click="toggleLeftDrawer"
        />

        <q-toolbar-title class="float-left">
          <img
            class="float-left"
            src="statics/Logo.png"
            style="height: 42px;vertical-align: bottom;"
          />
        </q-toolbar-title>

        <!--<translationSelect />-->
        <div>
          <q-btn-dropdown color="white" flat icon="fas fa-user">
            <q-list>
              <!-- <q-item clickable @click="driverProfile(userid)" v-close-popup>
                <q-item-section>
                  <q-item-label>{{$t('menus.profile')}}</q-item-label>
                </q-item-section>
              </q-item>-->

              <q-item clickable v-close-popup @click="logOut()">
                <q-item-section>
                  <q-item-label>{{$t('menus.log_out')}}</q-item-label>
                </q-item-section>
              </q-item>
            </q-list>
          </q-btn-dropdown>
        </div>
      </q-toolbar>
    </q-header>

    <q-drawer
      class="q-pa-md bg-info"
      v-model="leftDrawerOpen"
      bordered
      :width="256"
      :breakpoint="700"
      :mini="false"
    >
      <q-list class="menu-list">
        <q-item to="/personal" v-ripple v-if="$hasRoles([$typesRol.admin])">
          <q-item-section avatar>
            <q-icon name="groups" />
          </q-item-section>
          <q-item-section>
            <q-item-label>{{$t('menus.personal')}}</q-item-label>
          </q-item-section>
        </q-item>
        <q-separator />
        <q-item to="/proyectTypes" v-if="$hasRoles([$typesRol.admin])">
          <q-item-section avatar>
            <q-icon name="person" />
          </q-item-section>
          <q-item-section>
            <q-item-label>{{$t('menus.proyect_type')}}</q-item-label>
          </q-item-section>
        </q-item>
        <q-separator />
        <q-item to="/coverageMap" v-if="$hasRoles([$typesRol.admin])">
          <q-item-section avatar>
            <q-icon name="map" />
          </q-item-section>
          <q-item-section>
            <q-item-label>{{$t('menus.coverage_map')}}</q-item-label>
          </q-item-section>
        </q-item>
        <q-separator />
        <q-expansion-item
          :content-inset-level="0.5"
          expand-separator
          :label="$t('menus.reports')"
          icon="folder_open"
          v-if="$hasRoles([$typesRol.admin])"
        >
          <q-item to="/reports">
            <q-item-section avatar>
              <q-icon name="description" />
            </q-item-section>
            <q-item-section>
              <q-item-label>{{$t('menus.reports')}}</q-item-label>
            </q-item-section>
          </q-item>
        </q-expansion-item>
        <q-expansion-item
          :content-inset-level="0.5"
          expand-separator
          :label="$t('menus.chageHistory')"
          icon="history"
          v-if="$hasRoles([$typesRol.admin])"
        >
          <q-item to="/logs/request">
            <q-item-section avatar>
              <q-icon name="description" />
            </q-item-section>
            <q-item-section>
              <q-item-label>{{$t('menus.requests')}}</q-item-label>
            </q-item-section>
          </q-item>
        </q-expansion-item>
        <q-separator />
        <q-expansion-item
          :content-inset-level="0.5"
          expand-separator
          :label="$t('menus.requests')"
          icon="format_list_bulleted"
          v-if="$hasRoles([$typesRol.vendor])"
        >
          <q-item to="/request">
            <q-item-section avatar>
              <q-icon name="assignment" />
            </q-item-section>
            <q-item-section>
              <q-item-label>{{$t('menus.assigned')}}</q-item-label>
            </q-item-section>
          </q-item>
          <q-item to="/observed">
            <q-item-section avatar>
              <q-icon name="assignment_late" />
            </q-item-section>
            <q-item-section>
              <q-item-label>{{$t('menus.observed')}}</q-item-label>
            </q-item-section>
          </q-item>
          <q-item to="/approved">
            <q-item-section avatar>
              <q-icon name="assignment_turned_in" />
            </q-item-section>
            <q-item-section>
              <q-item-label>{{$t('menus.approved')}}</q-item-label>
            </q-item-section>
          </q-item>
          <q-item to="/rejected">
            <q-item-section avatar>
              <q-icon name="assignment_returned" />
            </q-item-section>
            <q-item-section>
              <q-item-label>{{$t('menus.rejected')}}</q-item-label>
            </q-item-section>
          </q-item>
        </q-expansion-item>
        <q-separator />
      </q-list>
    </q-drawer>

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script>
import { defineComponent } from 'vue'
import { mapGetters } from 'vuex'

export default defineComponent({
  name: 'MainLayout',

  components: {},
  data () {
    return {
      leftDrawerOpen: this.$q.platform.is.desktop
    }
  },
  computed: {
    ...mapGetters('users/auth', { role: 'role' })
  },
  created () {},
  methods: {
    toggleLeftDrawer () {
      this.leftDrawerOpen = !this.leftDrawerOpen
    },
    logOut () {
      localStorage.removeItem('JWT')
      window.location.reload()
    }
  }
})
</script>
