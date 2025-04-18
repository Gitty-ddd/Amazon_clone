const mongoose = require('mongoose');
const { productSchema } = require('./product');
const userSchema = mongoose.Schema({
    name : {
        type : String,
        required : true,
        trim : true
    },
    email : {
        type : String,
        required : true,
        trim : true,
        validate :{
            validator : (value)=>{
                const re = /^[a-zA-Z0-9_.+]*[a-zA-Z][a-zA-Z0-9_.+]*@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
                return  value.match(re); 
            },
            message : "Email is not valid"
        }
    },
    password : {
        type : String,
        required : true,
        validate :{
            validator : (value)=>{
                return value.length >= 6;
            },
            message : "Password is not valid"

        }
    },
    address : {
        type : String,
        default : ''
    },
    type : {
        type : String,
        default : 'user'
    },
    cart : [{
        product : {
            type : productSchema,
            required : true,

        },
        quantity : {
            type : Number,
           required : true,
        }
    }],
    
});

const User = mongoose.model("User" , userSchema);
module.exports = User