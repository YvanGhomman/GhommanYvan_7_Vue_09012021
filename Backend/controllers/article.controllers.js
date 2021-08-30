const sql = require("../models/db.js");
const Article = require('../models/Article.models.js');
require('dotenv').config();
const jwt = require('jsonwebtoken');



// Create and Save a new user
exports.create = (req, res) => {
    // Validate request
    if (!req.body) {
      res.status(400).send({
        message: "Le champ ne peut pas être vide !"
      });
    }
    let imageUrl = null
 if (req.file != undefined) {
        imageUrl = `${req.protocol}://${req.get('host')}/images/${req.file.filename}`;
    }
    
    const article = new Article({
        titre: req.body.titre,
        contenu: req.body.contenu,
        user_name: req.body.user_name,
        user_firstname: req.body.user_firstname,
        id_user: req.body.id_user,
        imageUrl: imageUrl,
      });
     

    Article.create(article, (err, data) => {
        if (err)
          res.status(500).send({
            message:
              err.message || "Une erreur est servenue lors de la création de l'article."
          });
        else res.send(data);
      });
    };

// Retrieve all Articles from the database
exports.findAll = (req, res) => {
  Article.getAll((err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Une erreur est servenue lors de la récupération des Articles."
        });
      else res.send(data);
    });
};

// Find a single Article with a ArticleId
exports.findOne = (req, res) => {
    Article.findById(req.params.articleId, (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `L'article avec l'id ${req.params.articleId} n'a pas été trouvé.`
          });
        } else {
          res.status(500).send({
            message: "Erreur de récupération de l'article avec l'id " + req.params.articleId
          });
        }
      } else res.send(data);
    });
};

// Update a user identified by the userId in the request
exports.update = (req, res) => {
  // Validate Request
  if (!req.body) {
      res.status(400).send({
        message: "Le champ ne peut pas être vide !"
      });
    }
  
    Article.updateById(req.params.articleId, new Article(req.body), (err, data) => {
        if (err) {
          if (err.kind === "not_found") {
            res.status(404).send({
              message: `L'article avec l'id ${req.params.articleId} n'a pas été trouvé.`
            });
          } else {
            res.status(500).send({
              message: "Erreur de mise à jour de l'article avec l'id " + req.params.articleId
            });
          }
        } else      
        res.send(data);
      }
    );
};




// Delete a user with the specified ArticleId in the request
exports.delete = (req, res) => {
 /*  const token = req.headers.authorization.split(' ')[1];
  const decodedToken = jwt.verify(token, process.env.DB_TOK);
  const userId = decodedToken.userId;
  console.log('TUTUTUTU', userId);


  function verifUserandDel(data){
    console.log('test fonction',data);
    console.log('test id_user',data.id_user);
        if ( data.id_user == userId ) {  */
          Article.remove(req.params.articleId, (err, data) => {
            if (err) {
              if (err.kind === "not_found") {
                res.status(404).send({
                  message: `L'article avec l'id ${req.params.articleId} n'a pas été trouvé.`
                });
              } else {
                res.status(500).send({
                  message: "Erreur de suppression de l'article avec l'id " + req.params.articleId
                });
              }
            } else res.send({ message: `L'article a été supprimé !` });
          });
        /* } else {
          res.status(404).send({
            message: `Vous n'avez pas le droit !`
          });
          console.log(`Hey ! Tu arrêtes ça, tu n'as pas le droit ! Vilain !`);
          
        } */
    };


 /*  Article.findById(req.params.articleId, (err, data) => {
    if (err) {
      if (err.kind === "not_found") {
        res.status(404).send({
          message: `L'article avec l'id ${req.params.articleId} n'a pas été trouvé.`
        });
      } else {
        res.status(500).send({
          message: "Erreur de récupération de l'article avec l'id " + req.params.articleId
        });
      }
    } else {
      verifUserandDel(data);
      }
    }) 
};*/


// Delete all users from the database.
exports.deleteAll = (req, res) => {
    Article.removeAll((err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Une erreur est survenue lors de la suppression de tous les Articles."
        });
      else res.send({ message: `Les Articles ont été supprimés !` });
    });
};

