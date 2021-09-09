<template>
        <nav class="navbar navbar-expand navbar-dark navbar-color">
            <div class="container-fluid ">
            <router-link class="navbar-brand" to="/accueil">Groupomania</router-link>
              <div class="navbar" id="navbarNav">
                <ul class="navbar-nav">
                  <li class="d-flex row nav-item active">
                        <router-link class="col-4 nav-link" to="/about">Profil</router-link>
                        <router-link class="col-4 nav-link" @click="goAccueil()" to="/">Déconnexion</router-link>
                  </li>
                </ul>
              </div>
            </div>
          </nav>
            <!-- <img class="center2 row col-12 col-sm-8 col-md-6 col-lg-4" src="https://user.oc-static.com/upload/2019/09/04/15675819263013_image1.png" alt="Logo Orinoco"> -->
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
