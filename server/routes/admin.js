const express = require("express");
const admin = require("../middleware/admin");
const adminRouter = express.Router();
const { Product } = require("../model/product");
const { default: mongoose } = require("mongoose");





adminRouter.post("/admin/add-product", admin, async (req, res) => {
    try{

        const {name , description , images , quantity , price , category} = req.body;
        console.log(name);
        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category
        });
        product = await product.save();
        res.json(product);
    }catch (e) {
        res.status(500).json({ error: e.message });
    }

});


adminRouter.get("/admin/get-products", admin, async (req, res) => {
    try {
        const products = await Product.find({});
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});


adminRouter.post("/admin/delete-product", admin, async (req, res) => {
    try {
        const { id } = req.body;
        const product = await Product.findByIdAndDelete(id);
        if (!product) {
            return res.status(404).json({ message: "Product not found" });
        }
        res.json({ message: "Product deleted successfully" });
        
    } catch (error) {
        res.status(500).json({ error: error.message });
        
    }

});

module.exports = adminRouter;