const functions = require('firebase-functions')
const admin = require('firebase-admin')
admin.initializeApp()

exports.sendPushNotification =  functions.firestore
.document('chats/{chatId}/conversations/{conversationId}/messages/{messageId}')
  .onCreate((snap, context) => {
    console.log('----------------start function--------------------')
    const doc = snap.data()
    const idFrom = doc.idFrom
    const idTo = doc.idTo
    const contentMessage = doc.content
    console.log('idTo is:' + idTo);
    
        admin
        .firestore()
        .collection('users')
        .doc(`${idTo}`)
        .get()
      .then(userTo => {
        if (userTo.exists) {
          console.log(`Found user to: ${userTo.data().name}`)
          if (userTo.data().fcm && userTo.data().chattingWith !== idFrom) {
            // Get info user from (sent)
            admin
            .firestore()
            .collection('users')
            .doc(`${idFrom}`)
            .get()
            .then(userFrom => {
              if (userTo.exists) {
              console.log(`Found user from: ${userFrom.data().name}`)

              const payload = {
                notification: {
                  title: `You have a message from "${userFrom.data().name}"`,
                  body: contentMessage,
                  badge: '1',
                  sound: 'default'
                }
              }


              admin
                    .messaging()
                    .sendToDevice(userTo.data().fcm, payload)
                    .then(response => {
                      console.log('Successfully sent message:', response)
                    })
                    .catch(error => {
                      console.log('Error sending message:', error)
                    })



              }else {
                console.log(`userFrom not found with id ${idFrom}!`);
              }
            })
          }
      } else {
          // doc.data() will be undefined in this case
          console.log(`userTo not found with id ${idTo}!`);

          console.log('----------------End function--------------------')
          return
      }
      })


  })