const functions = require("firebase-functions");
const express = require("express");
const app = express();
const profilesRouter = require("./api/controllers/profiles_controller");
const vehiclesRouter = require("./api/controllers/vehicles_controller");
const tripsRouter = require("./api/controllers/trips_controller");
const postsRouter = require("./api/controllers/posts_controller");
const chatsRouter = require("./api/controllers/chats_controller");
const ratingsRouter = require("./api/controllers/ratings_controller");
const stripe = require('stripe')(functions.config().stripe.testkey);

app.use(express.json());
app.use("/profiles", profilesRouter);
app.use("/vehicles", vehiclesRouter);
app.use("/trips", tripsRouter);
app.use("/posts", postsRouter);
app.use("/chats", chatsRouter);
app.use("/ratings", ratingsRouter);

exports.api = functions.https.onRequest(app);
exports.stripePayment = functions.https.onRequest(async (req, res) => {
    const paymentIntent = await stripe.paymentIntents.create({
            amount: (req.query.total_price != null) ? req.query.total_price : 1999,
            currency: 'myr'
        },
        function(err, paymentIntent) {
            if (err != null) {
                console.log(err);
            } else {
                res.json({
                    paymentIntent: paymentIntent.client_secret
                })
            }
        }
    )
});

// To handle "Function Timeout" exception
exports.functionsTimeOut = functions.runWith({
    timeoutSeconds: 300,
});