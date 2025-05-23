const express = require("express");
const { default: mongoose } = require("mongoose");
const User = require("../model/user");
const userRouter = express.Router();
const auth = require("../middleware/auth");
const {Product} = require('../model/product');
const { Order } = require('../model/order'); 


userRouter.post("/api/add-to-cart", auth, async (req, res) => {
    try{
        const {id} = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);
        if (user.cart.length == 0){
            user.cart.push({product , quantity : 1});
        }
        else{
            let isProductFound = false;
            for(let i=0 ; i<user.cart.length ; i++){
                if (user.cart[i].product._id.equals(product._id)){;
                    isProductFound = true;
                    
            }
        }
        if(isProductFound){
            let cartProduct = user.cart.find((cartProduct)=>cartProduct.product._id.equals(product._id));
            cartProduct.quantity++;
        }
        else{
            user.cart.push({product , quantity : 1});
        }
    }
        user = await user.save();
        res.json(user);
}catch (e) {
       res.status(500).json({ error: e.message });
    }

});

userRouter.delete("/api/remove-from-cart/:id", auth, async (req, res) => {
    try{
        const {id} = req.params;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);
        if (user.cart.length == 0){
            return res.status(400).json({ msg: "Cart is empty." });
        }
        
        else{
            for(let i=0 ; i<user.cart.length ; i++){
                if (user.cart[i].product._id.equals(product._id)){
                    if(user.cart[i].quantity == 1){
                        user.cart.splice(i,1);
                    }else{
                        user.cart[i].quantity -=1 ;
                    }
            }
        }
            
    }
        user = await user.save();
        res.json(user);
}catch (e) {
       res.status(500).json({ error: e.message });
    }

});


userRouter.post("/api/save-user-address" , auth , async(req , res)=>{
    try {
        const {address} = req.body;
        let user = await User.findById(req.user);
        user.address = address;
        user = await user.save();
        res.json(user);
    } catch (error) {
        res.status(500).json({error : error.message});
    }
});


 userRouter.post("/api/order" , auth , async (req , res) =>{
    try {
        const {cart , total , address} = req.body;
        let products = []; // let
        for(let i=0 ; i< cart.length ; i++){
            let product = await Product.findById(cart[i].product._id); //let
            if(product.quantity >= cart[i].quantity){
                product.quantity -= cart[i].quantity;
                products.push({product , quantity : cart[i].quantity});
                await product.save();
            } 
            else{
                return res.status(400).json({msg : `${product.name} is out of stock`});
            }
        }
        let order = new Order({  //let
            products,
            total , 
            address,
            userId : req.user,
            orderedAt : new Date().getTime(),
        });
        order = await order.save();
        let user = await User.findById(req.user);
        user.cart = [];
        user = await user.save();
        res.json(order);
    } catch (error) {
        res.status(500).json({error : error.message});
    }
 });


 userRouter.get("/api/myorders" , auth , async (req , res) => {
    try {
        const orders = await Order.find({userId : req.user});
        res.json(orders)
    } catch (error) {
        res.status(500).json({error : error.message});
    }
 });

module.exports = userRouter;