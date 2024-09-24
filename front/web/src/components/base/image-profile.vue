
<template class="justify-center">
  <q-avatar size="200px">
    <img :src="imageUrl" @error="imageError = true" fit="scale-down" class="profile-image" />
  </q-avatar>
</template>

<script>
export default {
  name: 'image-profile',
  data () {
    return {
      imageError: false,
      defaultImage:
        'https://firebasestorage.googleapis.com/v0/b/livgas-cfd9d.appspot.com/o/user.png?alt=media&token=2c6d7c07-6dae-4a55-bc70-36f414302dfd'
    }
  },
  props: {
    imageUrl: String
  }
}
</script>
<style lang="sass">
</style>
