
<template class="justify-center">
  <q-avatar>
    <q-img :src="imageUrl" fit="scale-down" class="profile-image" />
  </q-avatar>
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
