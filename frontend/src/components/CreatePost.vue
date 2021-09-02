<template>
    <form enctype="multipart/form-data" class="row" id="checked">
            <div class="space-form col-6 form-group">
                <input type="text" class="form-control" id="inputTitre" formControlName="titre" v-model="titre" placeholder="Titre" aria-label="Titre" required>
            </div>
            <div class="space-form col-6 form-group">
                <textarea class="form-control" id="textarea" formControlName="contenu" v-model="contenu" placeholder="Quoi de neuf ?" aria-label="Textarea" required></textarea>
            </div>
            <div class="form-group">
                <input type="file" accept="image/*" id="imageInput" name="image" @change="onFileAdded(event)">
                <img :src="imagePreview" v-if="imagePreview" style="max-height: 100px;display:block;margin-top:10px">
            </div>
    </form>
        <div>
            <a @click="submitPost()" class="offset-3 col-6 offset-3 center btn btn-dark mt-1" id="validateArticle"><span> validate </span></a>
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
            id_user: '',
            imageUrl: '',
            imagePreview:'',
        }
    },
    methods: {

        onFileAdded(event){
            const imageInput = document.querySelector('input[type="file"]')
            const file = imageInput.files[0];
            console.log(file);
            this.imageUrl = file;
            console.log(this.imageUrl);
            
            /* imageInput.setValue(file); */
           /*  this.sauceForm.updateValueAndValidity(); */
            const reader = new FileReader();
            reader.onload = () => {
            this.imagePreview = reader.result ;
            };
            reader.readAsDataURL(file);
        },

        /* createPost(info, image){
            return new Promise((resolve, reject) => {
            const formData = new FormData();
            formData.append('file', JSON.stringify(info));
            
            formData.append('image', image);
            axios.post('http://localhost:3000/article/', {
                headers: {
                    'Authorization': 'Bearer ' + sessionStorage.getItem("token")
                }}, formData) 
            .then(function(response) { 
                console.log(response);
                resolve(response)
                
            }) 
            .catch(function(error) { 
                console.log(error);
                reject(error) 
            });

         })
    }, */
         

        submitPost() {
            const userName = sessionStorage.getItem("userName");
            const userFirstname = sessionStorage.getItem("userFirstname");
            const user_Id = sessionStorage.getItem("userId");
            const titre = document.getElementById('inputTitre').value;
            const contenu=document.getElementById('textarea').value;
           
            console.log(this.imageUrl);
            const formData = new FormData();
            formData.append('image', this.imageUrl);
            formData.append('titre', titre);
            formData.append('contenu', contenu);
            formData.append('user_name', userName);
            formData.append('user_firstname', userFirstname);
            formData.append('id_user', user_Id);
            

            axios.post('http://localhost:3000/article/', formData, {
                headers: {
                    'Authorization': 'Bearer ' + sessionStorage.getItem("token"),
                    'content-Type': 'multipart/form-data'
                },
                }) 
            .then(function(response) { 
                console.log(response);
                /* this.titre= response.data.titre;
                this.contenu= response.data.contenu;
                this.imageUrl= response.imageUrl; */
                document.location.reload(); 
               /*  uploadImage(response.imageUrl) */
                
                
            }) 
            .catch(function(error) { 
                console.log(error); 
            });

            /* formData.append('titre', titre);
            formData.append('contenu', contenu);
            formData.append('user_name', userName);
            formData.append('user_firstname', userFirstname);
            formData.append('id_user', user_Id);
            
            axios.post('http://localhost:3000/article/', {
                headers: {
                    'Authorization': 'Bearer ' + sessionStorage.getItem("token")
                }}, formData) 
            .then(function(response) { 
                console.log(response);
                resolve(response)
                
            }) 
            .catch(function(error) { 
                console.log(error);
                reject(error) 
            }); */

         },
         /* uploadImage(data){
             this.imageUrl = data;
             console.log(this.imageUrl);
         } */

          
                

    },
}
</script>

<style>

</style>
