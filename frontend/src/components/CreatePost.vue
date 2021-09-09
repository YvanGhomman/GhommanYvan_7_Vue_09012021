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
            <a @click="submitPost()" :class="{'button--disabled' : !validatedFields}" class="offset-3 col-6 offset-3 center btn btn--groupomania__blue mt-1" id="validateArticle"><span> validate </span></a>
        </div>
</template>

<script>
import axios from 'axios'
import VueJwtDecode from "vue-jwt-decode";


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
            
            
            const reader = new FileReader();
            reader.onload = () => {
            this.imagePreview = reader.result ;
            };
            reader.readAsDataURL(file);
        },

        
         

        submitPost() {
            if(document.getElementById('textarea').value == ""){
                 alert("Vous n'avez rien écrit 😅")
             }else{


            const user_Id = VueJwtDecode.decode(sessionStorage.getItem("token")).userId;
            const titre = document.getElementById('inputTitre').value;
            const contenu=document.getElementById('textarea').value;
            const imageUrl = this.imageUrl
           
            console.log(this.imageUrl);
            const formData = new FormData();
            formData.append('image', imageUrl);
            formData.append('titre', titre);
            formData.append('contenu', contenu);
            formData.append('id_user', user_Id);

            axios.post('http://localhost:3000/article/', formData, {
                headers: {
                    'Authorization': 'Bearer ' + sessionStorage.getItem("token"),
                    'content-Type': 'multipart/form-data'
                },
                }) 
            .then(function(response) { 
                console.log(response);
                
                document.location.reload(); 
             
                
                
            }) 
            .catch(function(error) { 
                console.log(error); 
            });

             }

         },
         

          
                

    },
    computed: {
    validatedFields: function () {
        if (this.titre != "" && this.contenu != "") {
          return true;
        } else {
          return false;
        }
      }
    },
}
</script>

<style>
/* $color-primary : #091f43 ;
$color-secondary : #d1515a;
$color-tertiary :  #d4d4d4;
$color-4 :#FD2D01 */

.btn--groupomania__blue{
    background: #091f43;
    transition: .4s background-color;
    color: white;
    border-radius: 10px;
}
.btn--groupomania__blue:hover{
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
