const express = require('express');
const router = express.Router();

const auth = require('../middleware/auth');
const authArticle = require('../middleware/authArticle');

const articleCtrl = require('../controllers/article.controllers.js');


router.post('/', articleCtrl.create);
router.get('/', auth, articleCtrl.findAll);
router.get('/:articleId', auth, authArticle, articleCtrl.findOne);
router.put('/:articleId',  auth, authArticle, articleCtrl.update);
router.delete('/:articleId',  auth, authArticle, articleCtrl.delete);
/* router.delete('/', auth, articleCtrl.deleteAll); */


module.exports = router;