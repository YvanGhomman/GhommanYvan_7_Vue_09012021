<template>

  <div class="home">
    <img class="img d-flex col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-12" alt="Groupomania logo" src="../assets/icon-above-font.svg">
    <div>
      <button class="offset-3 col-6 btn btn-primary mb-1 mt-1" @click="active = !active">S'inscrire</button>
      <div v-if="active" class="col-10 offset-1 text-center">
        <h3>S'INSCRIRE</h3>
        <Signup/>
      </div>
    </div>

    <div>
      <button class="offset-3 col-6 btn btn-primary mb-1 mt-1" @click="active = !active">S'identifier</button>
      <div v-if="!active" class="col-10 offset-1 text-center">
        <h3>SE CONNECTER</h3>
        <Login/>
      </div>
    </div>
  </div>
  
</template>

<script>

// @ is an alias to /src
import Signup from '@/components/Signup.vue'
import Login from '@/components/Login.vue'


export default {
  name: 'Home',
  data() {
    return {
      active: true,
    }
  },
  components: {
    Signup,
    Login
  }
}
</script>

<style>
.img {
  height: 600px;
  margin-top: -100px;
  margin-bottom: -100px;
}
</style>
