<template>

  <Navbar/>
    <div>
      <button class="offset-3 col-6 btn btn--groupomania__blue mb-1 mt-1" @click="active = !active">Créer un post</button>
      <div v-if="active" class="col-10 offset-1 text-center">
        <CreatePost/>
      </div>
    </div>
    <Articles/>


<Footer />
</template>

<script>

import Articles from '@/components/Articles.vue'
import Navbar from '@/components/Navbar.vue'
import CreatePost from '@/components/CreatePost.vue'
import Footer from '@/components/Footer.vue'

export default {
  name: 'Accueil',
  data() {
    return {
      active: false,
    }
  },
  components: {
    Articles,
    Navbar,
    CreatePost,
    Footer
  },
}
</script>

<style>

</style>
