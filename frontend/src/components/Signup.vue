<template>
    <form class="row" id="checked">
        <div class="space-form col-6">
            <input type="text" class="form-control" id="inputNom" placeholder="Nom" aria-label="Nom" pattern="[A-Za-z]{2,50}" required>
        </div>
        <div class="space-form col-6">
            <input type="text" class="form-control" id="inputPrenom" placeholder="Prénom" aria-label="Prenom" pattern="[A-Za-z]{2,50}" required>
        </div>
        <div class="space-form col-6">
            <input type="text" class="form-control" id="inputJob" placeholder="Job" aria-label="Job" pattern="[A-Za-z]{2,50}" required>
        </div>
        <div class="space-form col-6">
            <input type="text" class="form-control" id="inputAdmin" placeholder="Admin" aria-label="Admin">
        </div>
        <div class="space-form col-6">
            <input type="text" class="form-control" id="inputPassword" placeholder="Password" aria-label="Password" required>
        </div>
        <div class="space-form col-6">
            <input type="email" class="form-control" id="inputEmail" placeholder="E-mail" aria-label="Email" pattern="^[a-z0-9._%+-]+@[a-z0-9.-]+.[a-z]{2,4}$" required>
        </div>

    </form>
    <div>
        <a class="offset-8 col-4 center btn btn-dark mt-1" id="validate"><span class="white" >Valider</span></a>
    </div>
</template>

<script>


export default {
   name: 'Signup',
}
</script>

<style >

</style>
