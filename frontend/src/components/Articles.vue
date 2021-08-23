<template>
    <h1>COUCOU ! 🐱‍👓</h1>

    <div class="d-flex flex-column-reverse align-items-center col-10 offset-1">
        <div class="d-flex col-12 justify-content-center" v-if="donnees" v-for="item in donnees" :key="item.id">
            <div class="card col-10 offset-1 center">
                <div class="card-body">
                    <h5 class="card-title text-center">{{item.user_name}} {{item.user_firstname}}</h5>
                    <h5 class="card-title text-center">{{item.titre}}</h5>    
                    <p class="card-text text-center">{{item.contenu}}</p>
                    <a href="" class="col-5 offset-1 btn btn-dark"><span class="gradient">Voir détails</span></a>
                    <a v-if="yo(item.id_user)" @click="deletePost(item.id)"  class="col-5 Supp offset-1 btn btn-danger"><span class="gradient">Supprimer</span></a>
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
</template>


<script>
import axios from 'axios'

export default {

    name: 'Articles',
    data() {
        return {
            id_article: '',
            commentary: '',
            user_name: '',
            user_firstname: '',
            id_user: '',
            donnees: 
                axios.get('http://localhost:3000/article', {
                    method: 'GET',
                    headers: {
                        'Authorization': 'Bearer ' + sessionStorage.getItem("token")
                    }
                })
                    .then((response) => {
                    console.log(response.data)
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
            Authorization: "Bearer " + sessionStorage.getItem("token"),
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

        yo(data){
            return {
                plouf(data){ 
                    let BTNSupp = document.getElementsByClassName("Supp")
                    const userSession = (JSON.parse(sessionStorage.getItem("confirm")));
                    console.log(userSession);
                    const userIdSession = userSession.userId;
                    console.log(userIdSession);
                    console.log(data);
                    if(userIdSession == data){
                        BTNSupp.show()
                    } else {
                        BTNSupp.hide()
                    }
                }
            } 
        },

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
            
        }
   
}
}
</script>

<style >

</style>
