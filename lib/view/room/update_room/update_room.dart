import 'package:flutter/material.dart';

class UpdateRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update room"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AddRoomForm2(
                formkey: addController.form2Key,
                contactKey: addController.contactKey,
                pricekey: addController.priceKey,
                numberkey: addController.numberOfRoomsKey,
                scrollController: _scrollController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AddRoomForm3(
                formkey: addController.form3Key,
                typesKey: addController.typesKey,
                waterKey: addController.waterKey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AddRoomForm4(
                parkingKey: addController.parkingKey,
                amenityKey: addController.amenityKey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
