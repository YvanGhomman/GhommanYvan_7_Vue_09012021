<template>
    <form class="row" id="checked">
            <div class="space-form col-6">
                <input type="text" class="form-control" id="inputTitre" placeholder="Titre" aria-label="Titre" required>
            </div>
            <div class="space-form col-6">
                <textarea class="form-control" id="textarea" placeholder="Quoi de neuf ?" aria-label="Textarea" required></textarea>
            </div>
        </form>
        <div>
            <a @click="createPost()" class="offset-3 col-6 offset-3 center btn btn-dark mt-1" id="validateArticle"><span> validate </span></a>
        </div>
</template>

<script>
import axios from 'axios'

export default {
    name: "CreatePost" ,
    data() {
        return {
            titre: '',
            contenu: '',
            user_name: '',
            user_firstname: '',
            id_user: ''
        }
    },
    methods: {
        createPost() {
            const userName = sessionStorage.getItem("userName");
            const userFirstname = sessionStorage.getItem("userFirstname");
            const user_Id = sessionStorage.getItem("userId");
            axios.post('http://localhost:3000/article/', {
                headers: {
                    'Authorization': 'Bearer ' + sessionStorage.getItem("token")
                }, 
                titre: document.getElementById('inputTitre').value,
                contenu: document.getElementById('textarea').value,
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

<style>

</style>
