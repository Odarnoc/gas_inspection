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
                      :rules="rules.startDate"
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
                      :rules="rules.limitDate"
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
              <q-card class="bg-transparent no-shadow no-border" bordered @click="downloadReport1">
                <q-card-section>
                  <div class="row q-col-gutter-sm">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                      <q-item class="q-pa-none bg-primary">
                        <q-item-section side class="q-pa-lg q-mr-none text-white bg-primary">
                          <q-icon name="download" color="white" size="24px"></q-icon>
                        </q-item-section>
                        <q-item-section class="q-pa-md q-ml-none text-white">
                          <q-item-label class="text-white text-h6 text-weight-bolder">En proceso</q-item-label>
                        </q-item-section>
                      </q-item>
                    </div>
                    <div class="col-md-12 col-sm-12 col-xs-12">
                      <q-item class="q-pa-none bg-primary">
                        <q-item-section side class="q-pa-lg q-mr-none text-white bg-primary">
                          <q-icon name="download" color="white" size="24px"></q-icon>
                        </q-item-section>
                        <q-item-section class="q-pa-md q-ml-none text-white">
                          <q-item-label class="text-white text-h6 text-weight-bolder">Efectividad</q-item-label>
                        </q-item-section>
                      </q-item>
                    </div>
                    <div class="col-md-12 col-sm-12 col-xs-12">
                      <q-item class="q-pa-none bg-primary">
                        <q-item-section side class="q-pa-lg q-mr-none text-white bg-primary">
                          <q-icon name="download" color="white" size="24px"></q-icon>
                        </q-item-section>
                        <q-item-section class="q-pa-md q-ml-none text-white">
                          <q-item-label class="text-white text-h6 text-weight-bolder">Rechazados</q-item-label>
                        </q-item-section>
                      </q-item>
                    </div>
                    <div class="col-md-12 col-sm-12 col-xs-12">
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
        startDate: [
          this.$rules.required(this.$t('validations.required.field'))
        ],
        limitDate: [this.$rules.required(this.$t('validations.required.field'))]
      }
    }
  },
  mounted () {},
  methods: {
    ...mapActions('users/auth', [
      'getTable',
      'delete',
      'updatePasswordByUserId'
    ]),
    downloadReport1 () {
      console.log('clie 1')
    }
  }
}
</script>

<style>
</style>
