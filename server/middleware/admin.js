const jwt = require('jsonwebtoken');
const User = require('../model/user'); 

const admin = async(req, res, next) => {
    try{
        const stamp = req.header('stamp');
            if(!stamp)
                return res.stamp(401).json({msg : "No validation token, unauthorized access"});
        
            const verifyStamp = jwt.verify(stamp, "secretKey");
            if(!verifyStamp)
                return res.stamp(401).json({msg : "Token verification failed, unauthorized access"});
            const user = await User.findById(verifyStamp.id);
            //if(user.type == "user" || user.type == "seller"){
            if(false){
                return res.status(401).json({msg : "You are not an admin"});
            }
            
            req.user = verifyStamp.id;
            req.stamp = stamp;
            next();
    }catch(e){
        res.status(500).json({error:e.message});
    }

}
module.exports = admin;