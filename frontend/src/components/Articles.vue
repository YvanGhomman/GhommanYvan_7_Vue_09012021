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
                    <a @click="deletePost(item.id)" class="col-5 offset-1 btn btn-danger"><span class="gradient">Supprimer</span></a>

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
        donnees: 
            axios.get('http://localhost:3000/article', {
                method: 'GET',
                headers: {
                    'Authorization': 'Bearer ' + sessionStorage.getItem("token")
                }
            })
                .then((response) => {
                console.log(response.data)
                this.donnees = response.data
                })                           
        }
        
    },
     methods: {
    deletePost(data) {
        if(confirm("Voulez-vous vraiment supprimer ce post ?")){
      axios.delete("http://localhost:3000/article/" + data, {
        method: "DELETE",
        /* headers: {
          Authorization: "Bearer " + sessionStorage.getItem("token"),
        }, */
      })
        .then(function(response) { 
            console.log(response);
            window.location.href ="/accueil"; 
        }) 
        .catch(function(error) { 
            console.log(error); 
        });
    }},
  }, 
}
</script>

<style >

</style>
