const jwt = require('jsonwebtoken');
const sql = require("../models/db.js");
const dotenv = require("dotenv");
dotenv.config();

module.exports = (req, res, next) => {
    try{
        console.log("Coucou on est dans authUser");
    const token = req.headers.authorization.split(' ')[1];
    const decodedToken = jwt.verify(token, process.env.DB_TOK);
    const userId = decodedToken.userId;
    console.log("userToken",userId);
    const isAdmin = decodedToken.isAdmin;
    console.log("Admin",isAdmin);
    console.log("idUser de req.params", req.params.userId);
    
    sql.query(`SELECT * FROM user WHERE id = ${req.params.userId}`, (err, data) => {
        console.log(data);
        console.log(data[0].id);
        if ( isAdmin === 1 || (data[0].id === userId)) {
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