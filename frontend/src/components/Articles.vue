<template>
    <div class="d-flex flex-column-reverse align-items-center col-10 offset-1">
        <div class="d-flex col-12 justify-content-center" v-if="donnees" v-for="item in donnees" :key="item.id">
            <div class="card col-10 offset-1 center">
                <div class="card-body">
                    <div class="d-flex">
                        <img class="imgProfilPic col-2 " v-if="item.user_profilPic" :src="item.user_profilPic" alt="">
                        <h5 class="card-title mx-3 d-flex align-items-center">{{item.user_name}} {{item.user_firstname}}</h5>
                    </div>
                    
                    <h5 class="card-title text-center">{{item.titre}}</h5>    
                    <p class="card-text text-center">{{item.contenu}}</p>
                    <img class="col-lg-6 col-md-8 col-12 imgCard" v-if="item.imageUrl" :src="item.imageUrl" alt="">
                    <div class="row m-2">
                        <!-- Trigger the modal with a button -->
                        <button @click="getCom(item.id)" type="button" id="btnModal" class="col-4 btn btn-primary" data-toggle="modal" :data-target="'#myModal'+item.id" aria-expanded="false">Commentaires</button>
                        <!-- Modal -->
                        <div class="modal fade" :id="'myModal'+item.id" role="dialog">
                            <div class="modal-dialog">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close btn btn-danger" data-dismiss="modal">X</button>
                                    <h5>Commentaires</h5>
                                </div>
                                <div class="modal-body">
                                    <div class="card card-body" v-if="commentaires" v-for="comm in commentaires" :key="comm.id">
                                        <h5>{{comm.user_name}} {{comm.user_firstname}}</h5>
                                        <p>{{comm.commentary}}</p>
                                        <a v-if="comm.id_user == userIdSession || isAdmin == 1" @click="deleteComm(comm.id)"  class=" offset-8 col-4 Supp offset-1"><i class="offset-11  far fa-trash-alt poubelle text-danger"></i></a>
                                    </div>
                                    <div v-else>
                                        <h5>Il n'y a pas de commentaires pour l'instant 😅</h5>
                                    </div>
                                    <div>
                                </div>
                                <div class="row modal-footer ">
                                    <form class="row col-12" id="checked">
                                        <div class="space-form ">
                                            <textarea class="form-control" v-bind:id="item.id" placeholder="What are you thinking about ?" aria-label="Textarea" required></textarea>
                                        </div>
                                    </form>
                                    <a @click="createComm(item.id)" class=" col-4  center btn btn-dark mt-1" id="validateComment"><span>Commenter</span></a>
                                </div>
                                </div>
                            </div>
                        </div>
                        </div>
                        
                        <a v-if="item.id_user == userIdSession || isAdmin == 1" @click="deletePost(item.id)"  class="col-8 d-flex  align-items-center "><i class="offset-11  far fa-trash-alt poubelle text-danger"></i></a>
                        
                    </div>
                                      
                    
                </div>
              </div>
        </div>
    </div>
</template>


<script>
import axios from 'axios'
import VueJwtDecode from "vue-jwt-decode";

export default {

    name: 'Articles',
    data() {
        return {
            id_article: '',
            commentary: '',
            user_name: '',
            user_firstname: '',
            id_user: '',
            userIdSession: sessionStorage.getItem("userId"),
            isAdmin: VueJwtDecode.decode(sessionStorage.getItem("token")).isAdmin,
            commentaires: '',
            donnees: 
                axios.get('http://localhost:3000/article', {
                    method: 'GET',
                    headers: {
                        'Authorization': 'Bearer ' + sessionStorage.getItem("token")
                    }
                })
                    .then((response) => {
                    console.log(response.data);
                    console.log(sessionStorage);
                    this.donnees = response.data
                    }) 
        }        
        
    },
     methods: {

        deletePost(data) {
            if(confirm("Voulez-vous vraiment supprimer ce post ?")){
        axios.delete("http://localhost:3000/article/" + data, {
            method: "DELETE",
            headers: {
            'Authorization': "Bearer " + sessionStorage.getItem("token"),
            }, 
        })
            .then(function(response) { 
                console.log(response);
                document.location.reload();
            }) 
            .catch(function(error) { 
                console.log(error); 
            });
        }},

         createComm(data) {
            const userName = sessionStorage.getItem("userName");
            const userFirstname = sessionStorage.getItem("userFirstname");
            const user_Id = sessionStorage.getItem("userId");
            axios.post('http://localhost:3000/comment/', {
                headers: {
                    'Authorization': 'Bearer ' + sessionStorage.getItem("token")
                }, 
                id_article : data,
                commentary: document.getElementById(data).value,
                user_name: userName,
                user_firstname: userFirstname,
                id_user: user_Id
            }) 
            .then(function(response) { 
                console.log(response);
                document.location.reload(); 
            }) 
            .catch(function(error) { 
                console.log(error); 
            });
            
        },

        getCom(data){
            this.commentaires = "";
            axios.get("http://localhost:3000/comment/" +  data  + "/comment", {
                headers: {
                    'Authorization': 'Bearer ' + sessionStorage.getItem("token")
                }})
            .then((response) => {
            this.commentaires = response.data;
            console.log(this.commentaires);
            })
            .catch((err) => console.log("Erreur : " + err));

        },

        deleteComm(data) {
            if(confirm("Voulez-vous vraiment supprimer ce commentaire ?")){
        axios.delete("http://localhost:3000/comment/" + data, {
            method: "DELETE",
            headers: {
            'Authorization': "Bearer " + sessionStorage.getItem("token"),
            }, 
        })
            .then(function(response) { 
                console.log(response);
                document.location.reload();
            }) 
            .catch(function(error) { 
                console.log(error); 
            });
        }},
}
}
</script>

<style lang="css" >
.poubelle{
font-size: 25px;
display: flex;
justify-items: center;
cursor: pointer;
}

.imgProfilPic{
    border-radius: 50%;
    object-fit: cover;
    object-position: 50% 50%;
    height: 70px;
    width: 70px;
   
}
 @media screen and (max-width: 750px) {
.imgProfilPic{
    height: 50px;
    width: 50px;
    }}
.imgCard{
    display: flex;
    margin-left: auto;
    margin-right: auto;
    object-fit: cover;
    object-position: 50% 50%;
    border-radius: 10px;
}
</style>
