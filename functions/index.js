const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const axios = require('axios');
var db = admin.firestore();


let username = "rzp_live_JdvrXlzC6qti0x";
let password = "zaAsc1qwUONy3XKQoakOjEOo";

let base64Credentials = btoa(`${username}:${password}`);
let text1 = 'Basic'
const basicAuth = text1 + ' ' + base64Credentials;;
exports.myRazorPayFunction = functions.https.onCall(async (data, context) => {
    const apiUrl = 'https://api.razorpay.com/v1/orders';
    const requestBody = {
        amount: data.amount,
        currency: 'INR',
        receipt: 'Badidukkan'
    };
    const headers = {
        'Content-Type': 'application/json',
        'Authorization': basicAuth
    };

    try {
        const response = await axios.post(apiUrl, requestBody, { headers: headers });
        const responseData = response.data;
        console.log(responseData);

        return responseData;
    } catch (error) {

        console.error(error);
        return {

            error: 'An error occurred'
        };
    }
});

exports.notifystatusToCustomer = functions.firestore
    .document("orders/{orderId}")
    .onUpdate(async (change) => {

        const order = change.after.data();
        const qurerySnapshot = db
            .collection("users")
            .doc(order.userId)
            .collection("tokens")
            .get();
        const token = (await qurerySnapshot).docs.map((snap) => snap.id);
        const payload = {
            notification: {
                title: `Order Update`,
                body: `Your Order ${order.orderStatus}`,
                sound: "default",
                clickAction: "FLUTTER_NOTIFICATION_CLICK",
            },
        };
        return admin.messaging().sendToDevice(token, payload);
    });
