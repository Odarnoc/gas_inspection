
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
        'https://firebasestorage.googleapis.com/v0/b/mikmic-3a9c2.appspot.com/o/system%2Fuser.png?alt=media&token=f06051ce-7999-4b80-a98c-5360ad8af46a'
    }
  },
  props: {
    imageUrl: String
  }
}
</script>
<style lang="sass">
</style>
