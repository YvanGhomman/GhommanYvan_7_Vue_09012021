<template>
    <form enctype="multipart/form-data" class="row justify-content-center" id="checked" v-if="mode == 'create'">
        <div class="form-group  m-1">
            <input type="file" accept="image/*" id="imageInput" name="profilPic" class="text-truncate justify-content-center col-sm-8 offset-sm-2 col-12" @change="onFileAdded(event)" required>
            <div class="d-flex justify-content-center">
                <img :src="imagePreview" v-if="imagePreview" class="imgProfilPic m-2">   
            </div>
        </div>
        <div class="space-form col-sm-8 col-12 m-1 form-group">
            <input type="text" v-model="name" class="form-control" formControlName="name" id="inputNom" placeholder="👍 Nom" aria-label="Nom" pattern="[A-Za-z]{2,50}" required>
        </div>
        <div class="space-form col-sm-8 col-12 m-1 form-group">
            <input type="text" v-model="firstname" class="form-control" formControlName="firstname" id="inputPrenom" placeholder="👉 Prénom" aria-label="Prenom" pattern="[A-Za-z]{2,50}" required>
        </div>
        <div class="space-form col-sm-8 col-12  m-1 form-group">
            <input type="text" v-model="job" class="form-control" formControlName="job" id="inputJob" placeholder="💼 Job" aria-label="Job" pattern="[A-Za-z]{2,50}" required>
        </div>
        <div class="space-form col-sm-8 col-12  m-1 form-group">
            <input type="email" v-model="email" class="form-control" formControlName="email" id="inputEmail" placeholder="📧 E-mail" aria-label="Email" pattern="^[a-z0-9._%+-]+@[a-z0-9.-]+.[a-z]{2,4}$" required>
        </div>
        <div class="space-form col-sm-8 col-12  m-1 form-group">
            <input type="password" v-model="password" class="form-control" formControlName="password" id="inputPassword" placeholder="🔐 Password" aria-label="Password" required>
        </div>
    </form>
    <div>
        <button class="button_create" :class="{'button--disabled' : !validatedFields}" @click="sendSignup()"><span class="white">Valider</span></button>
    </div>
</template>

<script>
import axios from 'axios'

export default {


   name: 'Signup',
   data() {
    return {
        mode: 'create',
        name: '',
        firstname: '',
        job: '',
        admin: '',
        password: '',
        email: '',
        imagePreview:'',
        profilPic:''
    }
  },
   methods: {

       onFileAdded(event){
            const imageInput = document.querySelector('input[type="file"]')
            const file = imageInput.files[0];
            this.profilPic = file;
            const reader = new FileReader();
            reader.onload = () => {
            this.imagePreview = reader.result ;
            };
            reader.readAsDataURL(file);
        },

    sendSignup(){
    //on vérifie que tout le formulaire est conforme
        let FormValid = document.getElementById('checked').checkValidity();

    //si formulaire pas conforme, alert le client
        if (FormValid == false ) {

            alert(`Vous n'avez pas rempli tous les champs requis !`);
    //sinon
        }else{
            const firstname = document.getElementById('inputPrenom').value;
            const name = document.getElementById('inputNom').value;
            const job = document.getElementById('inputJob').value;
            const password = document.getElementById('inputPassword').value;
            const email = document.getElementById('inputEmail').value;
            const profilPic = this.profilPic

            
            const formData = new FormData();
            formData.append('profilPic', profilPic);
            formData.append('firstname', firstname);
            formData.append('name', name);
            formData.append('job', job);
            formData.append('password', password);
            formData.append('email', email);

        //on POST les infos reccueillies au serveur
            axios.post("http://localhost:3000/user/signup", formData ,  {

                headers: {
                     'Authorization': 'Bearer ', 
                     'content-Type': 'multipart/form-data',
                },

            })
        //traitement de la réponse du serveur
            .then(async function(response){
                //récupération de la réponse du serveur
                    let confirmation =  await  response.data;                    
                    sessionStorage.setItem("token", confirmation.token);
                    window.location.href ="./accueil";

                    
            //traitement des erreurs
                
            }).catch(function(error) { 
                console.log(error); 
                 alert("Mot de passe ou email invalide ! Il faut au minimum 8 caractères non espacés dont une majuscule, une minuscule et 2 chiffres")
            });
        };
    }

   },
   computed: {
    validatedFields: function () {
        if (this.mode == 'create') {
        if (this.email != "" && this.firstname != "" && this.name != "" && this.password != "" && this.job != "" && this.profilPic !="") {
          return true;
        } else {
          return false;
        }}
      }
    },
}
</script>

<style >
body{

  background:  url("../assets/city-407703_1920(12).jpg") no-repeat center fixed ;
    background-size: cover;
}

.imgProfilPic{
    border-radius: 50%;
    border:#FD2D01 solid 5px;
    object-fit: cover;
    object-position: 50% 50%;
    height: 100px;
    width: 100px;
}

.button_create {
    background: #091f43;
    color:white;
    border-radius: 8px;
    font-weight: 800;
    font-size: 15px;
    border: none;
    width: 100%;
    padding: 16px;
    transition: .4s background-color;
  }

  .button_create:hover {
    background-color: #244982;
    color: white;
  }
  .button--disabled {
    background:#cecece;
    color:#ececec;
    border: none;
  }
  .button--disabled:hover {
    cursor:not-allowed;
    background:#cecece;
    color:#ececec
  }
</style>
