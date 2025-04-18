console.log("Hello from the server");

const express = require('express');
const mongooose = require('mongoose');
const dash = require('./routes/dash');
const auth = require('./routes/auth');
const adminRouter = require('./routes/admin');
const bodyParser = require('body-parser');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');
const authRouter = require('./routes/auth');
const DB = "mongodb+srv://pratikuiet:Mongodb04@cluster.bl3ej7e.mongodb.net/?retryWrites=true&w=majority&appName=Cluster"
const app = express();
const PORT = 3000;



app.use(dash); 
app.use(express.json());
app.use(auth);
app.use(authRouter);
app.use(bodyParser.json());
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

mongooose.connect(DB).then(() => {
  console.log("MongoDB Connected");
}).catch((e) => { console.log(e)});

app.get("/nodemon" , function(req , res){
  console.log("Run NodeMon Website");
  res.send("NodeMon Website");
});


app.listen(PORT , function(){
  console.log("NodeJS Server Started...");
})
