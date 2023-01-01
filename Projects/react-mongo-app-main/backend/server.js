const express = require("express");
const port = process.env.PORT || 5000;
const http = require("http");

const app = express();
app.use(express.json());

app.get("/", (req, res) => {
    res.json({Warning: "There is nothing of value here"});
})

app.post("/api/users/register", register);

app.post("/api/users/login", (req, res) => {
    res.json({LoggedIn: "You"});
})

app.listen(port, console.log(`Server listing on port ${port}`));

function register(req, res) {
    const { name, email, password } = req.body;
    console.log(req.body);
    if( !name || !email || !password ) {
        res.status(400);
        res.send("Please add all fields");
        return;
    }

    res.status(201).json({
        id: 0,
        name: name,
        email: email,
        message: "Well done on registering!"
    })
}

function login(req, res) {

}