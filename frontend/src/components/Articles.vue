<template>
    <div class="d-flex flex-column-reverse align-items-center col-10 offset-1">
        <div class="d-flex col-12 justify-content-center" v-if="donnees" v-for="item in donnees" :key="item.id">
            <div class="card col-10 offset-1 center">
                <div class="card-body">
                    <h5 class="card-title text-center">{{item.user_name}} {{item.user_firstname}}</h5>
                    <h5 class="card-title text-center">{{item.titre}}</h5>    
                    <p class="card-text text-center">{{item.contenu}}</p>
                    <img v-if="item.imageUrl" :src="item.imageUrl" alt="">
                    <p>{{item.imageUrl}}</p>
                    <a href="" class="col-5 offset-1 btn btn-dark"><span class="gradient">Voir détails</span></a>
                    <a v-if="item.id_user == userIdSession || isAdmin == 1" @click="deletePost(item.id)"  class="col-5 Supp offset-1 btn btn-danger"><span class="gradient">Supprimer</span></a>
                    <p>
                        <button @click="getCom(item.id)" class="btn btn-primary" type="button" data-toggle="collapse" :data-target="'#collapseExample'+item.id" aria-expanded="false" aria-controls="collapseExample">
                            Button with data-target
                        </button>
                    </p>
                    <div class="collapse" :id="'collapseExample'+item.id">
                        <div class="card card-body" v-if="commentaires" v-for="comm in commentaires" :key="comm.id">
                            <h5>{{comm.user_name}} {{comm.user_firstname}}</h5>
                            <p>{{comm.commentary}}</p>
                            <a v-if="comm.id_user == userIdSession || isAdmin == 1" @click="deleteComm(comm.id)"  class=" offset-8 col-4 Supp offset-1 btn btn-danger"><span class="gradient">Supprimer</span></a>
                        </div>
                        <div>
                            <form class="row center mt-1 mb-1" id="checked">
                                <div class="space-form col-6">
                                    <textarea class="form-control" v-bind:id="item.id" placeholder="What are you thinking about ?" aria-label="Textarea" required></textarea>
                                </div>
                            </form>
                            <a @click="createComm(item.id)" class="offset-3 col-6 offset-3 center btn btn-dark mt-1" id="validateComment"><span>Commenter</span></a>
                        </div>
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

<style >

</style>
