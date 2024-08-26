
<template class="justify-center">
  <q-avatar size="200px">
    <img
      :src="imageUrl"
      onerror="this.src = 'https://firebasestorage.googleapis.com/v0/b/mikmic-3a9c2.appspot.com/o/system%2Fuser.png?alt=media&token=f06051ce-7999-4b80-a98c-5360ad8af46a'"
      fit="scale-down"
      class="profile-image"
    />
    <q-badge floating :color="imageStatus ? 'positive':'negative'" v-if="isAdministration">
      <q-icon size="sm" :name="imageStatus ? 'check' : 'close'" />
    </q-badge>
  </q-avatar>
</template>

<script>
export default {
  name: 'image-profile',
  props: {
    imageUrl: String,
    imageStatus: Boolean,
    isAdministration: Boolean
  }
}
</script>
<style lang="sass">
</style>
