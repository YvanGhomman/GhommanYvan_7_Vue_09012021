<template>
<div class="footer fixed-bottom">


    <nav class="navbar navbar-expand-lg navbar-dark navbar-color space-between">
        <div class="offset-3 col-6 text-center">
            <router-link class="navbar-brand " to="/accueil"><img class="img__footer" src="../assets/icon-left-font-monochrome-white.svg" alt="Allons à l'accueil"></router-link>
        </div>
    </nav>
</div>
</template>

<script>

export default {
     name: 'Footer',
}
</script>

<style>

.img__footer{
    width: 30%;
}
@media screen and (max-width: 750px) {
.img__footer{
    width: 60%;
}}
.navbar-color{
background-color: #091f43
}
</style>