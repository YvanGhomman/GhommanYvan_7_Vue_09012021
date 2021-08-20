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
        <a class="offset-8 col-4 center btn btn-dark mt-1" @click="sendSignup()"><span class="white">Valider</span></a>
    </div>
</template>

<script>


export default {
   name: 'Signup',
   methods: {
    sendSignup(){

    //on verifie que la checkbox est checked

    //on vérifie que tout le formulaire est conforme
        let FormValid = document.getElementById('checked').checkValidity();

    //si formulaire pas conforme, alert le client
        if (FormValid == false ) {

            alert(`Vous n'avez pas rempli tous les champs requis !`);
    //sinon
        }else{
        
        //variable qui reccueille les infos de contact du client
            let contact = {
                firstname : document.getElementById('inputPrenom').value,
                name : document.getElementById('inputNom').value,
                job : document.getElementById('inputJob').value,
                password : document.getElementById('inputPassword').value,
                email : document.getElementById('inputEmail').value
            }; 
            console.log(contact);

        //on POST les infos reccueillies au serveur
            const envoi = fetch("http://localhost:3000/user/signup", {
                method: 'POST',
                body: JSON.stringify(contact),
                headers: {
                    'Content-Type': 'application/json'
                }
            });
        //traitement de la réponse du serveur
            envoi.then(async response =>{
                try{
                    console.log(response);
                //récupération de la réponse du serveur
                    let confirmation = await response.json();
                    console.log(confirmation);

                    sessionStorage.setItem("userId", confirmation.userId);
                    sessionStorage.setItem("token", confirmation.token);
                    sessionStorage.setItem("userName", confirmation.userName);
                    sessionStorage.setItem("userFirstname", confirmation.userFirstname);
                    console.log(sessionStorage);
                    window.location.href ="./accueil";

                    
            //traitement des erreurs
                } catch (error) {
                    console.log(error);
                    alert("Un problème est survenu, merci de réessayer plus tard");
                }
            });
        };
}

   }
}
</script>

<style >

</style>
