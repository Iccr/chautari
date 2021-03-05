const functions = require('firebase-functions')
const admin = require('firebase-admin')
admin.initializeApp()

exports.sendPushNotification = functions.firestore
.document('chats/{chatId}/conversations/{conversationId}/messages/{messageId}')
  .onCreate((snap, context) => {
    console.log('----------------start function--------------------')

    const doc = snap.data()
    const idFrom = doc.idFrom
    const idTo = doc.idTo

    console.log('idTo is:' + idTo);
    // Get push token user to (receive)
    admin
      .firestore()
      .collection('users')
      .where('id', '==', idTo)
      .get()
      .then(querySnapshot => {
        console.log(querySnapshot)
        querySnapshot.forEach(userTo => {

          console.log(`Found user to: ${userTo.data().name}`)
          if (userTo.data().fcm && userTo.data().chattingWith !== idFrom) {
            // Get info user from (sent)
            admin
              .firestore()
              .collection('users')
              .where('id', '==', idFrom)
              .get()
              .then(querySnapshot2 => {
                querySnapshot2.forEach(userFrom => {
                  console.log(`Found user from: ${userFrom.data().nickname}`)
                  const payload = {
                    notification: {
                      title: `You have a message from "${userFrom.data().nickname}"`,
                      body: contentMessage,
                      badge: '1',
                      sound: 'default'
                    }
                  }
                  // Let push to the target device
                  admin
                    .messaging()
                    .sendToDevice(userTo.data().fcm, payload)
                    .then(response => {
                      console.log('Successfully sent message:', response)
                    })
                    .catch(error => {
                      console.log('Error sending message:', error)
                    })
                })
              })
          } else {
            console.log('Can not find pushToken target user')
          }
        })
      })

      console.log('----------------End function--------------------')
    return null
  })