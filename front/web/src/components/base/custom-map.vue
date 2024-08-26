<template>
  <GMapMap :center="center" :zoom="zoom" :options="options" style="width: auto; min-height: 500px">
    <GMapMarker
      :key="m.key"
      v-for="m in markers"
      :position="m.position"
      :draggable="true"
      @click="center=m.position"
      @dragend="updateMarker(m.key, $event)"
      :icon="computedIcon(m)"
    />
  </GMapMap>
</template>
<script>
import { markerColors } from 'src/commons/generals'

export default {
  name: 'App',
  props: {
    zoom: {
      type: Number,
      default: 10
    },
    markers: {
      type: Array,
      default (rawProps) {
        return []
      }
    }
  },
  data () {
    return {
      options: {
        zoomControl: true,
        mapTypeControl: false,
        scaleControl: true,
        streetViewControl: false,
        rotateControl: true,
        fullscreenControl: false
      },
      center: { lat: 20.6738673, lng: -103.3766125 }
    }
  },
  computed: {
    computedIcon () {
      return (options) => ({
        path: 'm 9.8925 0 c -3.7859 0 -6.8659 3.0805 -6.8659 6.8665 c 0 3.6444 6.2295 12.1588 6.4948 12.5194 l 0.2475 0.3369 c 0.029 0.0396 0.0751 0.0627 0.1236 0.0627 c 0.0493 0 0.0951 -0.0232 0.1243 -0.0627 l 0.2474 -0.3369 c 0.2654 -0.3606 6.4948 -8.875 6.4948 -12.5194 c 0 -3.786 -3.0805 -6.8664 -6.8665 -6.8664 z m 0 4.4069 c 1.3565 0 2.4596 1.1031 2.4596 2.4596 c 0 1.3558 -1.1031 2.4596 -2.4596 2.4596 c -1.3557 0 -2.4596 -1.1038 -2.4596 -2.4596 c 0 -1.3565 1.1038 -2.4596 2.4596 -2.4596 z',
        fillColor: options.iconColor ?? markerColors.origin,
        fillOpacity: 1,
        strokeWeight: 2,
        rotation: 0,
        scale: 2,
        anchor: { x: 10, y: 18 }
      })
    }
  },
  created () {
    const self = this
    if ('geolocation' in navigator) {
      navigator.geolocation.getCurrentPosition(
        function (position) {
          self.centerMap(position.coords.latitude, position.coords.longitude)
        },
        function (error) {
          console.log(error)
        }
      )
    }
  },
  methods: {
    updateMarker (key, locationEvent) {
      this.$emit('on-update-marker', {
        key,
        lat: locationEvent.latLng.lat(),
        lon: locationEvent.latLng.lng()
      })
    },
    centerMap (lat, lng) {
      this.center = {
        lat,
        lng
      }
    }
  }
}
</script>
