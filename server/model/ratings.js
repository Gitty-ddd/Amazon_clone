const mongoose = require('mongoose');
const ratingSchema = mongoose.Schema({
    userId: {
        type: String,
        required: true
    },
    rating: {
        type: Number,
        required: true,
        min: 1,
        max: 5
    },
});

module.exports = ratingSchema;