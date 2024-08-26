
<template class="justify-center">
  <q-img :src="imageUrl" :ratio="4/2" fit="scale-down"/>
</template>

<script>
export default {
  name: 'image-uploaded',
  props: {
    imageUrl: String
  }
}
</script>
<style lang="sass">
</style>
