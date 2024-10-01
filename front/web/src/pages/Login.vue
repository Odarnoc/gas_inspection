<template>
  <q-layout>
    <q-page-container class="page-background">
      <q-page>
        <div class="row justify-center q-mb-xl" style="padding-top: 10vh;">
          <img src="statics/Logo.png" style="width: 192px;height: 192px" />
        </div>
        <q-form ref="loginForm" class="q-gutter-md">
          <div class="row justify-center">
            <div class="col-sm-4 q-pa-md">
              <div class="row justify-center q-col-gutter-md">
                <div class="col-12">
                  <q-input
                    v-model="email"
                    standout
                    rounded
                    color="accent"
                    input-class="text-accent"
                    bg-color="white"
                    :label="$t('fields.email')"
                    v-on:keyup.enter="logIn()"
                    :rules="rules.email"
                  />
                </div>
                <div class="col-12">
                  <q-input
                    v-model="password"
                    standout
                    rounded
                    color="accent"
                    input-class="text-accent"
                    bg-color="white"
                    :label="$t('fields.password')"
                    :type="isPwd ? 'password' : 'text'"
                    v-on:keyup.enter="logIn()"
                    :rules="rules.password"
                  >
                    <template v-slot:append>
                      <q-icon
                        color="accent"
                        :name="isPwd ? 'visibility_off' : 'visibility'"
                        class="cursor-pointer"
                        @click="isPwd = !isPwd"
                      />
                    </template>
                  </q-input>
                </div>
                <div class="col-12 text-center self-center q-mt-sm">
                  <q-btn
                    class="self-center"
                    color="secondary"
                    rounded
                    :label="$t('buttons.log_in')"
                    :loading="loading"
                    @click="logIn()"
                  />
                </div>
                <!-- <div class="col-12 text-center self-center q-mt-sm">
                    <q-btn
                      class="self-center"
                      color="white"
                      :label="$t('buttons.forgot_password')"
                      flat
                      rounded
                      to="/forgotPassword"
                    />
                </div>-->
              </div>
            </div>
          </div>
        </q-form>
      </q-page>
    </q-page-container>
  </q-layout>
</template>

<script>
import api from '../commons/api.js' // El api pasa los params por: 'qs.stringify'
import { defineComponent } from 'vue'
import axios from 'axios'

export default defineComponent({
  name: 'Login',
  data () {
    return {
      stripe: {},
      marginMovil: '',
      elements: {},
      card: {},
      email: null,
      password: null,
      isPwd: true,
      loading: false,
      medium: false,
      type: null,
      modals: {
        emailVerification: false
      }
    }
  },
  computed: {
    rules () {
      return {
        email: [
          this.$rules.required(this.$t('validations.required.email')),
          this.$rules.email(this.$t('validations.invalid_format.email'))
        ],
        password: [this.$rules.required(this.$t('validations.required.field'))]
      }
    }
  },
  created () {},
  async mounted () {
    if (this.$q.platform.is.mobile) {
      this.marginMovil = 'q-mt-md'
    } else {
      this.marginMovil = ''
    }
    if (this.$route.query.verified !== undefined) {
      this.$q.notify({
        message: this.$t(
          `notify.${
            this.$route.query.verified === '1'
              ? 'email_verified'
              : 'email_cant_verify'
          }`
        ),
        timeout: 3000,
        type: 'green',
        color: this.$route.query.verified === '1' ? 'green' : 'red',
        textColor: 'white', // if default 'white' doesn't fits
        icon: this.$route.query.verified === '1' ? 'done' : 'warning',
        position: 'top-right' // 'top', 'left', 'bottom-left' etc
      })
    }
  },
  methods: {
    async logIn () {
      const isValid = await this.$refs.loginForm.validate()
      if (!isValid) {
        return
      }
      const params = {
        email: this.email,
        password: this.password
      }
      const params2 = {
        email: this.email,
        password: this.password,
        type: this.type
      }
      this.loading = true
      api
        .post('/auth/loginWeb', this.type == null ? params : params2)
        .then(({ data }) => {
          this.loading = false
          localStorage.setItem('JWT', data.token)
          axios.defaults.headers.common.Authorization = `Bearer ${data.token}`
          this.$router.push('/dashboard')
        })
        .catch((error) => {
          this.$showNotifyError(error)
          this.loading = false
        })
    },
    signin () {
      this.$router.push('/reg/new')
    },
    closeModal () {
      this.modals.emailVerification = false
    }
  }
})
</script>
