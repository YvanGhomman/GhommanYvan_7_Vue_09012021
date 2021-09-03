<template>
    <div>
        <Navbar/> 
        <div class="container">
          <div>
            <img class="img d-flex col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-12" alt="Groupomania logo" src="../assets/icon-above-font.svg">
          </div>

        <div class="card text-center pt-4 pb-4"> 
            <h1 class="text-center">Votre Profil</h1>
            <h2 class="">Nom : {{userName}}</h2>
            <h2 class="article-content">Prénom : {{userFirstname}}</h2>
            <h2 class="article-content">Poste : {{job}}</h2>
            <h2 class="article-content">E-mail : {{email}}</h2>
        
                <div class="container">
                    <!-- Trigger the modal with a button -->
                    <button type="button" id="btnModal" class="btn btn-secondary btn-lg col-4" data-toggle="modal" data-target="#myModal" aria-expanded="false">Éditer</button>
                    <!-- Modal -->
                    <div class="modal fade" id="myModal" role="dialog">
                        <div class="modal-dialog">
                        
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close btn btn-danger" data-dismiss="modal">X</button>
                                <h5 class="modal-title">Saisissez votre mot de passe</h5>
                            </div>
                            <div class="modal-body">
                                <form class="row" id="checked" >
                                    <div class="space-form col-6 offset-3">
                                        <input type="password" v-model="password" class="form-control" id="inputPassword2" placeholder="🔐 Password" aria-label="Password" required>
                                    </div>
                                </form>
                                <a @click="checkProfil()" class="btn btn-dark col-4 offset-4 m-2" id="modif">Valider</a>
                            </div> 
                        </div>
                    </div>
                    </div>
                </div>


                <div v-if="profil===true" class="row col-10 offset-1">
                    <button class="btn btn-primary col-4 offset-4 mt-2 mb-2" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                        Modifier
                    </button>
 
                    <div class="collapse" id="collapseExample">
                        <div>
                            <form enctype="multipart/form-data" class="row" id="checked" >
                                <div class="form-group">
                                    <input type="file" accept="image/*" id="imageInput" name="profilPic" @change="onFileAdded(event)">
                                    <img :src="imagePreview" v-if="imagePreview" style="max-height: 100px;display:block;margin-top:10px">
                                </div>
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
                    <button @click="deleteProfil(id)" class="btn btn-danger col-4 offset-4 mt-2 mb-2" id="suppr">Supprimer</button>
                </div>
            </div>             
        </div>

        <div v-if="isAdmin == 1"  class="text-center d-flex justify-content-center">
            <div class="col-lg-6  col-md-8 o col-12 ">
                <h1>Liste des Profils</h1>
                <div class="mt-2 mb-2 " v-if="utilisateurs" v-for="user in utilisateurs" :key="user.id">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h2 class="article-content text-success" v-if="user.admin == 1">Admin</h2>
                            <h3 class="">Nom : {{user.name}}</h3>
                            <h3 class="article-content">Prénom : {{user.firstname}}</h3>
                            <h3 class="article-content">Poste : {{user.job}}</h3>
                            <h3 class="article-content">E-mail : {{user.email}}</h3>

                            <a @click="getPosts(user.id)" class="col-4 btn btn-primary m-4" type="button" data-toggle="collapse" :data-target="'#collapseExample2'+user.id" aria-expanded="false" aria-controls="collapseExample">
                                Posts
                            </a>


                            <a v-if="isAdmin == 1" @click="deleteProfilAdmin(user.id)"  class="col-4 btn btn-danger m-4"><span>Supprimer</span></a>
                            

                            <div class="collapse" :id="'collapseExample2'+user.id">
                                <div class="card card-body" v-if="posts" v-for="post in posts" :key="post.id">
                                    <h5>{{post.user_name}} {{post.user_firstname}}</h5>
                                    <p>{{post.titre}}</p>
                                    <p>{{post.contenu}}</p>
                                    <a v-if="isAdmin == 1" @click="deletePostAdmin(post.id)"  class=" offset-8 col-4 Supp offset-1 btn btn-danger"><span class="gradient">Supprimer</span></a>
                                </div>
                                
                            </div>
                        </div>
                    </div>
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
        profil: "",
        posts:"",
        profilPic: '',
        imagePreview:'',
        isAdmin: VueJwtDecode.decode(sessionStorage.getItem("token")).isAdmin,
        utilisateurs: axios.get('http://localhost:3000/user', {
                    method: 'GET',
                    headers: {
                        'Authorization': 'Bearer ' + sessionStorage.getItem("token")
                    }
                })
                    .then((response) => {
                    console.log(response.data);
                    console.log(sessionStorage);
                    this.utilisateurs = response.data
                    })
    }
    
  },
  components: {
    Navbar,
    Footer
  },
  methods: {
        checkProfil(){
            let FormValid = document.getElementById('checked').checkValidity();
            if (FormValid == false ) {
                alert(`Vous n'avez pas rempli tous les champs requis !`);
            }else{
            
            //variable qui reccueille les infos de contact du client
                let contact = {
                    password : document.getElementById('inputPassword2').value,
                    email : sessionStorage.getItem("email")
                }; 
                console.log(contact);
                
            //on POST les infos reccueillies au serveur
                const envoi =  fetch("http://localhost:3000/user/login", {
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
                        if (confirmation.error){
                            console.log("error")
                            alert("Mot de passe invalide !")
                        }else{
                        document.querySelector(".modal-backdrop").remove()
                        document.getElementById('btnModal').remove()
                        document.getElementById('myModal').remove()
                        this.profil = true
                        }
                //traitement des erreurs
                    } catch (error) {
                        console.log(error);
                        alert("Un problème est survenu, merci de réessayer plus tard");
                    }
                });
            };

        },
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
            
               const firstname = document.getElementById('inputPrenom').value;
               const name = document.getElementById('inputNom').value;
               const job = document.getElementById('inputJob').value;
               const password = document.getElementById('inputPassword').value;
               const email = document.getElementById('inputEmail').value;
               const admin = this.isAdmin;
               const profilPic = this.profilPic
           
            
            const user_id = VueJwtDecode.decode(sessionStorage.getItem("token")).userId;

           
            console.log(this.profilPic);
            const formData = new FormData();
            formData.append('profilPic', profilPic);
            formData.append('firstname', firstname);
            formData.append('name', name);
            formData.append('job', job);
            formData.append('password', password);
            formData.append('email', email);
            formData.append('admin', admin);



        //on POST les infos reccueillies au serveur
            axios.put("http://localhost:3000/user/" + user_id, formData, {
                
                
                headers: {
                    'Content-Type': 'multipart/form-data',
                    'Authorization': 'Bearer ' + sessionStorage.getItem("token")
                }
            })
        //traitement de la réponse du serveur
            .then(async response =>{
                try{
                    console.log(response);
                //récupération de la réponse du serveur
                    let confirmation = await response.data;
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
    },
    deleteProfilAdmin(data) {
           if(confirm("Supprimer le profil ?")){
               axios.delete('http://localhost:3000/user/' + data, {
                   method: "DELETE",
                   headers: {
                    'Authorization': 'Bearer ' + sessionStorage.getItem("token")
                }})
               .then(function(response) {
                    console.log(response);
                    window.location.href= "/about";
                })
                .catch(function(error) {
                    console.log(error);
                }); 
           }
       },
       getPosts(data){
            this.posts = "";
            axios.get("http://localhost:3000/article/article/" + data, {
                headers: {
                    'Authorization': 'Bearer ' + sessionStorage.getItem("token")
                }})
            .then((response) => {
            this.posts = response.data;
            console.log(this.posts);
            })
            .catch((err) => console.log("Erreur : " + err));

        },
  }
}
</script>

<style scoped>
.img {
  height: 600px;
  margin-top: -100px;
  margin-bottom: -100px;
}
.card {
  max-width: 100%;
  display: flex;
  align-content: center;
  background-color: #e9e9e9;
  border-radius: 16px;
  padding:32px;
}

</style>