<template>
    <form enctype="multipart/form-data" class="row" id="checked" v-if="mode == 'create'">
        <div class="form-group">
                <input type="file" accept="image/*" id="imageInput" name="profilPic" @change="onFileAdded(event)" required>
                <img :src="imagePreview" v-if="imagePreview" style="max-height: 100px;display:block;margin-top:10px">
            </div>
        <div class="space-form col-6 form-group">
            <input type="text" v-model="name" class="form-control" formControlName="name" id="inputNom" placeholder="👍 Nom" aria-label="Nom" pattern="[A-Za-z]{2,50}" required>
        </div>
        <div class="space-form col-6 form-group">
            <input type="text" v-model="firstname" class="form-control" formControlName="firstname" id="inputPrenom" placeholder="👉 Prénom" aria-label="Prenom" pattern="[A-Za-z]{2,50}" required>
        </div>
        <div class="space-form col-6 form-group">
            <input type="text" v-model="job" class="form-control" formControlName="job" id="inputJob" placeholder="💼 Job" aria-label="Job" pattern="[A-Za-z]{2,50}" required>
        </div>
        <div class="space-form col-6 form-group">
            <input type="email" v-model="email" class="form-control" formControlName="email" id="inputEmail" placeholder="📧 E-mail" aria-label="Email" pattern="^[a-z0-9._%+-]+@[a-z0-9.-]+.[a-z]{2,4}$" required>
        </div>
        <div class="space-form col-6 offset-3 form-group">
            <input type="text" v-model="password" class="form-control" formControlName="password" id="inputPassword" placeholder="🔐 Password" aria-label="Password" required>
        </div>
        
    </form>
    <div>
        <button class=" button_create " :class="{'button--disabled' : !validatedFields}" @click="sendSignup()"><span class="white">Valider</span></button>
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
            console.log(file);
            this.profilPic = file;
            console.log(this.profilPic);
            
            /* imageInput.setValue(file); */
           /*  this.sauceForm.updateValueAndValidity(); */
            const reader = new FileReader();
            reader.onload = () => {
            this.imagePreview = reader.result ;
            };
            reader.readAsDataURL(file);
        },

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
             /* let contact = {
                firstname : document.getElementById('inputPrenom').value,
                name : document.getElementById('inputNom').value,
                job : document.getElementById('inputJob').value,
                password : document.getElementById('inputPassword').value,
                email : document.getElementById('inputEmail').value,
                profilPic: this.pic
            }; 
            console.log(contact); */
            console.log(this.profilPic);
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
            console.log(formData);

        //on POST les infos reccueillies au serveur
            axios.post("http://localhost:3000/user/signup", formData ,  {

                headers: {
                     'Authorization': 'Bearer ', 
                     'content-Type': 'multipart/form-data'
                    /*  'Content-type':'application/json' */
                },
                /* firstname : document.getElementById('inputPrenom').value,
                name : document.getElementById('inputNom').value,
                job : document.getElementById('inputJob').value,
                password : document.getElementById('inputPassword').value,
                email : document.getElementById('inputEmail').value,
                profilPic: this.pic */

            })
        //traitement de la réponse du serveur
            .then(async function(response){
                
                    console.log(response.data);
                //récupération de la réponse du serveur
                    let confirmation =  await  response.data;
                    console.log(confirmation);
                    /* if (confirmation.error){
                            console.log("error")
                            alert("Invalide :"+ confirmation.message)
                    }else{ */
                    sessionStorage.setItem("isAdmin", confirmation.isAdmin);
                    sessionStorage.setItem("userId", confirmation.userId);
                    sessionStorage.setItem("token", confirmation.token);
                    sessionStorage.setItem("userName", confirmation.userName);
                    sessionStorage.setItem("userFirstname", confirmation.userFirstname);
                    sessionStorage.setItem("job", confirmation.job);
                    sessionStorage.setItem("email", confirmation.email);
                    sessionStorage.setItem("profilPic", confirmation.profilPic);
                    console.log(sessionStorage);
                    window.location.href ="./accueil";

                    /* } */
            //traitement des erreurs
                
            }).catch(function(error) { 
                console.log(error); 
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
