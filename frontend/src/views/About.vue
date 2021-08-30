<template>
    <div>
        <Navbar/> 
        <div class="container">
          <div>
    <img class="img d-flex col-4 offset-4" alt="Groupomania logo" src="../assets/icon-above-font.svg">
          </div>
        <div class="card text-center pt-4 pb-4"> 
            <h1 class="text-center card__title--user">Profil</h1>
            <h2 class="">Nom : {{userName}}</h2>
            <h2 class="article-content">Prénom : {{userFirstname}}</h2>
            <h2 class="article-content">Poste : {{job}}</h2>
            <h2 class="article-content">E-mail : {{email}}</h2>
            
            <div class="row col-10 offset-1">
                    <p>
                        <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                            Modifier
                        </button>
                    </p>
                    <div class="collapse" id="collapseExample">
                        <div>
                            <form class="row" id="checked" >
                              <div class="space-form col-6 offset-3">
                                  <input type="text" v-model="userName" class="form-control" id="inputNom" placeholder="👍 Nom" aria-label="Nom" pattern="[A-Za-z]{2,50}" required>
                              </div>
                              
                              <div class="space-form col-6 offset-3">
                                  <input type="text" v-model="userFirstname" class="form-control" id="inputPrenom" placeholder= "👉 Prénom" aria-label="Prenom" pattern="[A-Za-z]{2,50}" required>
                              </div>
                              <div class="space-form col-6 offset-3">
                                  <input type="text" v-model="job" class="form-control" id="inputJob" placeholder= "💼 Job" aria-label="Job" pattern="[A-Za-z]{2,50}" required>
                              </div>
                              <div class="space-form col-6 offset-3">
                                  <input type="email" v-model="email" class="form-control" id="inputEmail" placeholder= "📧 E-mail" aria-label="Email" pattern="^[a-z0-9._%+-]+@[a-z0-9.-]+.[a-z]{2,4}$" required>
                              </div>
                              <div class="space-form col-6 offset-3">
                                  <input type="text" v-model="password" class="form-control" id="inputPassword" placeholder="🔐 Password" aria-label="Password" required>
                              </div>
                              
                            </form>
                            <a @click="updateProfil()" class="btn btn-dark col-4 offset-4  m-2" id="modif">Valider</a>
                        </div>
                    </div>

              
              <a @click="deleteProfil(id)" class="btn btn-danger col-4 offset-4  m-2" id="suppr">Supprimer</a>
            </div>
        </div>
        </div>
        <Footer/>
    </div>
</template>

<script>
// @ is an alias to /src
import Navbar from '@/components/Navbar.vue';
import Footer from '@/components/Footer.vue'
import axios from 'axios';
import VueJwtDecode from "vue-jwt-decode";


export default {
  name: 'About',
  data(){
    return{

      userName: sessionStorage.getItem("userName"),
      userFirstname: sessionStorage.getItem("userFirstname"),
      job: sessionStorage.getItem("job"),
      id: sessionStorage.getItem("userId"),
      email: sessionStorage.getItem("email"),
    }
    
  },
  components: {
    Navbar,
    Footer
  },
  methods: {
    deleteProfil(data) {
           if(confirm("Supprimer le profil ?")){
             const user_id = VueJwtDecode.decode(sessionStorage.getItem("token")).userId;
               axios.delete('http://localhost:3000/user/' + user_id, {
                   method: "DELETE",
                   headers: {
                    'Authorization': 'Bearer ' + sessionStorage.getItem("token")
                }})
               .then(function(response) {
                 
                    console.log(response);
                    sessionStorage.clear();
                    window.location.href= "/";
                })
                .catch(function(error) {
                    console.log(error);
                }); 
           }
       },
       updateProfil(){
        let FormValid = document.getElementById('checked').checkValidity();
        if (FormValid == false ) {
            alert(`Vous n'avez pas rempli tous les champs requis !`);
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
            const user_id = VueJwtDecode.decode(sessionStorage.getItem("token")).userId;

        //on POST les infos reccueillies au serveur
            const envoi = fetch("http://localhost:3000/user/" + user_id, {
                method: 'PUT',
                body: JSON.stringify(contact),
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + sessionStorage.getItem("token")
                }
            });
        //traitement de la réponse du serveur
            envoi.then(async response =>{
                try{
                    console.log(response);
                //récupération de la réponse du serveur
                    let confirmation = await response.json();
                    console.log(confirmation);
                    sessionStorage.clear();
                    console.log(sessionStorage);
                    window.location.href ="/";

                    
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

<style scoped>
.img {
  height: 600px;
  margin-top: -100px;
  margin-bottom: -100px;
}

</style>