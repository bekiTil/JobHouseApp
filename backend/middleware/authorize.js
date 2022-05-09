const verifyToken = require("../middleware/verifyToken")
const jwt = require('jsonwebtoken');

// this function authorize based on role
authorize=(roles)=>
    [   
        // check the token if it is authenticated or not 
        function (req, res, next) {
            const token = req.header('x-auth-token');
            if (!token) return res.status(401).send('Acess denied. No token provided');
            
            try{
                const verified = jwt.verify(token, process.env["JWT_PRIVATE_KEY"]);
                req.auth = verified;
                next()
            }
            catch(ex) {
                res.status(400).send('Invalid token')
            }
        },

        //check if the person is authorized based on role 
        (req, res, next) => {
            const token = req.header('x-auth-token');
            if (roles.length && !(roles===(req.auth.role))) {
                // user's role is not authorized
                return res.status(401).json({ message: 'Unauthorized' });
            }

            // authentication and authorization successful
            next();
        }
    ]
module.exports=authorize;