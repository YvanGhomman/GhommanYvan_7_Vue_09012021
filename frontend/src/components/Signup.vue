<template>
    <form class="row" id="checked" v-if="mode == 'create'">
        <div class="space-form col-6">
            <input type="text" v-model="name" class="form-control" id="inputNom" placeholder="👍 Nom" aria-label="Nom" pattern="[A-Za-z]{2,50}" required>
        </div>
        <div class="space-form col-6">
            <input type="text" v-model="firstname" class="form-control" id="inputPrenom" placeholder="👉 Prénom" aria-label="Prenom" pattern="[A-Za-z]{2,50}" required>
        </div>
        <div class="space-form col-6">
            <input type="text" v-model="job" class="form-control" id="inputJob" placeholder="💼 Job" aria-label="Job" pattern="[A-Za-z]{2,50}" required>
        </div>
        <div class="space-form col-6">
            <input type="email" v-model="email" class="form-control" id="inputEmail" placeholder="📧 E-mail" aria-label="Email" pattern="^[a-z0-9._%+-]+@[a-z0-9.-]+.[a-z]{2,4}$" required>
        </div>
        <div class="space-form col-6 offset-3">
            <input type="text" v-model="password" class="form-control" id="inputPassword" placeholder="🔐 Password" aria-label="Password" required>
        </div>
        
    </form>
    <div>
        <button class=" button_create " :class="{'button--disabled' : !validatedFields}" @click="sendSignup()"><span class="white">Valider</span></button>
    </div>
</template>

<script>


export default {
   name: 'Signup',
   data() {
    return {
        mode: 'create',
        name: '',
        firstname: '',
        position: '',
        admin: '',
        password: '',
        email: '',
    }
  },
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
                    sessionStorage.setItem("isAdmin", confirmation.isAdmin);
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

   },
   computed: {
    validatedFields: function () {
        if (this.mode == 'create') {
        if (this.email != "" && this.firstname != "" && this.name != "" && this.password != "" && this.job != "") {
          return true;
        } else {
          return false;
        }}
      }
    },
}
</script>

<style >


.button_create {
    background: #2196F3;
    color:white;
    border-radius: 8px;
    font-weight: 800;
    font-size: 15px;
    border: none;
    width: 100%;
    padding: 16px;
    transition: .4s background-color;
  }

  .button:hover {
    cursor:pointer;
    background: #1976D2;
  }
  .button--disabled {
    background:#cecece;
    color:#ececec
  }
  .button--disabled:hover {
    cursor:not-allowed;
    background:#cecece;
  }
</style>
