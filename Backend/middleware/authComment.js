const jwt = require('jsonwebtoken');
const sql = require("../models/db.js");
const dotenv = require("dotenv");
dotenv.config();

module.exports = (req, res, next) => {
    try{
        console.log("Coucou on est dans authComment");
    const token = req.headers.authorization.split(' ')[1];
    const decodedToken = jwt.verify(token, process.env.DB_TOK);
    const userId = decodedToken.userId;
    console.log("userToken",userId);
    const isAdmin = decodedToken.isAdmin;
    console.log("Admin",isAdmin);

    console.log("idComment de req.params", req.params.commentId);
    
    sql.query(`SELECT * FROM commentaire WHERE id = ${req.params.commentId}`, (err, data) => {
        console.log(data);
        console.log(data[0].id_user);
        if ((data[0].id_user === userId) || isAdmin === 1) {
            console.log("action autorisée");
            next();
        } else {
            res.status(403).json({ message: "Action non autorisée" });

            console.log(`Hey ! Tu arrêtes ça, tu n'as pas le droit ! Vilain !`);
        }
    });
    }
    catch{
        res.status(401).json({error: error | 'Requête non authentifiée !'});
    }

};