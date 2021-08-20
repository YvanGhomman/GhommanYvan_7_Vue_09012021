const jwt = require('jsonwebtoken');
require('dotenv').config();

const Article = require('../models/Article.models.js');


 module.exports = (req, res, next) =>  { 
  try { 
    console.log(req.headers.authorization);
    const token = req.headers.authorization.split(' ')[1];
    const decodedToken = jwt.verify(token, process.env.DB_TOK);
    const userId = decodedToken.userId;
    console.log(req.body);
    console.log(req.body.articleId);
    console.log(req.body.titre);
    console.log(req.body.contenu);
    console.log(req.body.user_name);
    console.log(req.body.user_firstname);
    console.log(req.body.id_user);
    console.log("TEST");

    console.log(req.params);
    console.log(req.params.articleId);
    console.log(req.params.titre);
    console.log(req.params.contenu);
    console.log(req.params.user_name);
    console.log(req.params.user_firstname);
    console.log(req.params.id_user);
    console.log('test',userId);
    next();

/*    let article = Article.findById(req.params.articleId, (err, data) => {
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
      } else return data;
    });
console.log('tast');


article.then( data => {
  console.log('SATA', data); 
  console.log(data);
} ) */

    /* if ( req.body.userId && req.body.userId !== userId) {
      throw 'User ID non valable !';
    } else {
      console.log("test");

      next();
    } */
  } catch (error) {
    res.status(401).json({error: error | 'Requête non authentifiée !'});
  }
}; 