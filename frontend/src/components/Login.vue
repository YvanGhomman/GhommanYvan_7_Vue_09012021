<template>
    <form class="row" id="checked">
        <div class="space-form col-6">
            <input type="text" class="form-control" id="inputPassword" placeholder="Password" aria-label="Password" required>
        </div>
        <div class="space-form col-6">
            <input type="email" class="form-control" id="inputEmail" placeholder="E-mail" aria-label="Email" pattern="^[a-z0-9._%+-]+@[a-z0-9.-]+.[a-z]{2,4}$" required>
        </div>
    </form>
    <div>
        <a href="#" class="offset-8 col-4 center btn btn-dark mt-1" id="validate"><span class="white" >Valider</span></a>
    </div>
</template>

<script>


export default {
   name: 'Login',
}
</script>

<style >

</style>
