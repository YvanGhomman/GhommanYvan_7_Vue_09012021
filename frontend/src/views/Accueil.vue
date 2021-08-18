<template>
  <div>
    <router-link class="col-10 offset-1 btn btn-dark mt-1 mb-1" to="/create"><span>Créer un post</span></router-link>
    <Articles/>
  </div>
</template>

<script>

import Articles from '@/components/Articles.vue'

export default {
  name: 'Accueil',
  components: {
    Articles
  },
}
</script>
