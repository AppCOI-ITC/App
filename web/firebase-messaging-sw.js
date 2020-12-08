// console.log("")
importScripts("https://www.gstatic.com/firebasejs/7.23.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.23.0/firebase-messaging.js");
firebase.initializeApp({
    apiKey: "AIzaSyAFFV0vm6gTXh0DhKtFJN4srugczI6rrX0",
    authDomain: "appcoi-itc.firebaseapp.com",
    databaseURL: "https://appcoi-itc.firebaseio.com",
    projectId: "appcoi-itc",
    storageBucket: "appcoi-itc.appspot.com",
    messagingSenderId: "355684088554",
    appId: "1:355684088554:web:49cf1164c33e2fca5af593",
    measurementId: "G-4V5JKNK8JG"
});
const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});