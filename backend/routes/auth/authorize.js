const { expressjwt: njwt } = require("express-jwt");


// this function authorize based on role
authorize=(roles)=>
    [ 
        
        // check the token if it is authenticated or not 
        njwt({secret:process.env.TOKEN_SECRET, algorithms: ['HS256']}),

        //check if the person is authorized based on role 
        (req, res, next) => {
            
            if (roles.length && !(roles===(req.auth.role))) {
                // user's role is not authorized
                return res.status(401).json({ message: 'Unauthorized' });
            }

            // authentication and authorization successful
            next();
        }
    ]
module.exports=authorize;