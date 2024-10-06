<template>
  <q-page>
    <header-pages :breadCrumRoutes="breadCrumRoutes" />

    <div class="q-pa-md bg-grey-3">
      <div class="row bg-white border-panel">
        <div class="col q-pa-md">
          <div class="row q-mb-sm q-mt-md">
            <div class="col-md-6 col-sm-12 col-xs-12">
              <q-form ref="refForm" class="q-gutter-md q-mt-sm">
                <div class="row q-col-gutter-xs">
                  <div class="col-12">
                    <q-input
                      outlined
                      bg-color="primary-input-color"
                      color="border-primary-input-color"
                      label-color="primary-input-color"
                      input-class="value-primary-input-color"
                      type="text"
                      v-model="start"
                      :rules="rules.start"
                      :label="$t('fields.startDate')"
                      readonly
                    >
                      <template v-slot:append>
                        <q-icon name="event" class="cursor-pointer">
                          <q-popup-proxy
                            ref="qDateProxyx2"
                            transition-show="scale"
                            transition-hide="scale"
                          >
                            <q-date :mask="$maskDate" color="primary" v-model="start">
                              <div class="row items-center justify-end">
                                <q-btn
                                  v-close-popup
                                  :label="$t('buttons.close')"
                                  color="primary"
                                  flat
                                />
                              </div>
                            </q-date>
                          </q-popup-proxy>
                        </q-icon>
                      </template>
                    </q-input>
                  </div>
                  <div class="col-12">
                    <q-input
                      outlined
                      bg-color="primary-input-color"
                      color="border-primary-input-color"
                      label-color="primary-input-color"
                      input-class="value-primary-input-color"
                      type="text"
                      v-model="end"
                      :rules="rules.end"
                      :label="$t('fields.endDate')"
                      readonly
                    >
                      <template v-slot:append>
                        <q-icon name="event" class="cursor-pointer">
                          <q-popup-proxy
                            ref="qDateProxyx2"
                            transition-show="scale"
                            transition-hide="scale"
                          >
                            <q-date :mask="$maskDate" color="primary" v-model="end">
                              <div class="row items-center justify-end">
                                <q-btn
                                  v-close-popup
                                  :label="$t('buttons.close')"
                                  color="primary"
                                  flat
                                />
                              </div>
                            </q-date>
                          </q-popup-proxy>
                        </q-icon>
                      </template>
                    </q-input>
                  </div>
                  <slot name="actions"></slot>
                </div>
              </q-form>
            </div>
            <div class="col-md-6 col-sm-12 col-xs-12">
              <q-card class="bg-transparent no-shadow no-border" bordered>
                <q-card-section>
                  <div class="row q-col-gutter-sm">
                    <div class="col-md-12 col-sm-12 col-xs-12" @click="downloadReport1">
                      <q-item class="q-pa-none bg-primary">
                        <q-item-section side class="q-pa-lg q-mr-none text-white bg-primary">
                          <q-icon name="download" color="white" size="24px"></q-icon>
                        </q-item-section>
                        <q-item-section class="q-pa-md q-ml-none text-white">
                          <q-item-label class="text-white text-h6 text-weight-bolder">En proceso</q-item-label>
                        </q-item-section>
                      </q-item>
                    </div>
                    <div class="col-md-12 col-sm-12 col-xs-12" @click="downloadReport2">
                      <q-item class="q-pa-none bg-primary">
                        <q-item-section side class="q-pa-lg q-mr-none text-white bg-primary">
                          <q-icon name="download" color="white" size="24px"></q-icon>
                        </q-item-section>
                        <q-item-section class="q-pa-md q-ml-none text-white">
                          <q-item-label class="text-white text-h6 text-weight-bolder">Efectividad</q-item-label>
                        </q-item-section>
                      </q-item>
                    </div>
                    <div class="col-md-12 col-sm-12 col-xs-12" @click="downloadReport3">
                      <q-item class="q-pa-none bg-primary">
                        <q-item-section side class="q-pa-lg q-mr-none text-white bg-primary">
                          <q-icon name="download" color="white" size="24px"></q-icon>
                        </q-item-section>
                        <q-item-section class="q-pa-md q-ml-none text-white">
                          <q-item-label class="text-white text-h6 text-weight-bolder">Rechazados</q-item-label>
                        </q-item-section>
                      </q-item>
                    </div>
                    <div class="col-md-12 col-sm-12 col-xs-12" @click="downloadReport4">
                      <q-item class="q-pa-none bg-primary">
                        <q-item-section side class="q-pa-lg q-mr-none text-white bg-primary">
                          <q-icon name="download" color="white" size="24px"></q-icon>
                        </q-item-section>
                        <q-item-section class="q-pa-md q-ml-none text-white">
                          <q-item-label class="text-white text-h6 text-weight-bolder">Por actor</q-item-label>
                        </q-item-section>
                      </q-item>
                    </div>
                  </div>
                </q-card-section>
              </q-card>
            </div>
            <div class="col-md-6 col-sm-12 col-xs-12"></div>
          </div>
        </div>
      </div>
    </div>
  </q-page>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  name: 'UserTypeList',
  data () {
    return {
      start: null,
      end: null
    }
  },
  computed: {
    breadCrumRoutes () {
      return [this.$t('menus.reports')]
    },
    rules () {
      return {
        start: [this.$rules.required(this.$t('validations.required.field'))],
        end: [this.$rules.required(this.$t('validations.required.field'))]
      }
    }
  },
  created () {
    this.start = this.$getFisrtDay()
    this.end = this.$getLastDay()
  },
  mounted () {},
  methods: {
    ...mapActions('pdf/request', [
      'getInProgressReport',
      'getRejectedReport',
      'getEfectivityReport',
      'getActorReport'
    ]),
    async downloadReport1 () {
      const params = {
        startDate: this.start,
        endDate: this.end,
        name: 'En proceso.pdf'
      }
      await this.getInProgressReport(params)
    },
    async downloadReport2 () {
      const params = {
        startDate: this.start,
        endDate: this.end,
        name: 'Efectividad.pdf'
      }
      await this.getEfectivityReport(params)
    },
    async downloadReport3 () {
      const params = {
        startDate: this.start,
        endDate: this.end,
        name: 'Rechazados.pdf'
      }
      await this.getRejectedReport(params)
    },
    async downloadReport4 () {
      const params = {
        startDate: this.start,
        endDate: this.end,
        name: 'Por actor.pdf'
      }
      await this.getActorReport(params)
    }
  }
}
</script>

<style>
</style>
