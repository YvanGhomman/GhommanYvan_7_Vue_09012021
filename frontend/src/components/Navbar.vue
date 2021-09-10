<template>
  <nav class="navbar navbar-expand-lg navbar-dark navbar-color">

    <router-link class="navbar-brand mx-2" to="/accueil">Groupomania</router-link>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse d-flex justify-content-end mx-2" id="navbarNav">
      <div class="navbar" id="navbarNav">
        <ul class="navbar-nav">
          <li class="nav-item active">
            <router-link class="col-4 nav-link" to="/about">Profil</router-link>
          </li>
          <li class="nav-item">
            <router-link class="col-4 nav-link" @click="goAccueil()" to="/">Déconnexion</router-link>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

            

<script>

export default {
    name: 'Navbar',
    methods:{
      goAccueil() {
        sessionStorage.clear();
        console.log(sessionStorage);
      }
      }
}
</script>
<style>
.navbar-color{
background-color: #091f43
}
</style>
