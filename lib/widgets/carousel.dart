// import 'package:chautari/model/rooms_model.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// typedef VoidCallback = void Function();

// class CarouselWithIndicator extends StatefulWidget {
//   final VoidCallback onImageTapped;
//   final RoomsModel model;
//   bool isDetailPage = false;

//   CarouselWithIndicator(this.model, {this.isDetailPage, this.onImageTapped});

//   @override
//   _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
// }

// class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
//   int _current = 0;

//   List<Widget> getItems() {
//     return widget.model.images
//         .split(',')
//         .map((url) => Container(child: ImageView(imageBaseUrl + url)))
//         .toList();
//   }

//   List<String> getUrls() {
//     return widget.model.images.split(',');
//   }

//   List<Widget> getChildren() {
//     List<Widget> list = [];
//     getUrls().asMap().forEach((index, val) {
//       // For image dot indicator
//       list.add(Container(
//         width: 8.0,
//         height: getUrls().length > 1 ? 8.0 : 0,
//         margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4.0),
//         decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: _current == index
//                 ? Color.fromRGBO(0, 0, 0, 0.9)
//                 : Color.fromRGBO(0, 0, 0, 0.4)),
//       ));
//     });
//     return list;
//   }

// //For Images
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(children: [
//         GestureDetector(
//           onTap: () {
//             widget.onImageTapped();
//           },
//           child: CarouselSlider(
//             viewportFraction: 1.0,
//             items: getItems(),
//             autoPlay: false,
//             enlargeCenterPage: true,
//             enableInfiniteScroll: false,
//             aspectRatio: widget.isDetailPage ? 1.24 : 1.67,
//             onPageChanged: (index) {
//               setState(() {
//                 _current = index;
//               });
//             },
//           ),
//         ),
//         Container(
//           height: 36,
//           child: Stack(
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: getChildren(),
//               ),
//               Positioned(
//                 right: 10,
//                 bottom: 5,
//                 child: Text(
//                   '',
//                   // 'Report Post',
//                   style: TextStyle(
//                       fontFamily: getThemeFont(),
//                       fontWeight: FontWeight.w700,
//                       color: HexColor('0000B8'),
//                       fontSize: 11),
//                 ),
//                 // IconButton(
//                 //   icon: Icon(Icons.event),
//                 //   onPressed: () {
//                 //     print("report");
//                 //   },
//                 // ),
//               ),
//             ],
//           ),
//         )
//       ]),
//     );
//   }
// }

// class ImageView extends StatelessWidget {
//   final String imageurl;
//   final int index = 2;
//   ImageView(this.imageurl);

//   @override
//   Widget build(BuildContext context) {
//     // return Container(
//     //     // margin: EdgeInsets.all(5.0),
//     //     child: CachedNetworkImage(
//     //       width: 1000.0,
//     //       placeholder: (context, url) => Container(
//     //         height: 20,
//     //         width: 20,
//     //         child: CircularProgressIndicator(
//     //           backgroundColor: HexColor(themeBlueColorHex),
//     //           // valueColor: Color.blue,
//     //         ),
//     //       ),
//     //       errorWidget: (context, url, error) => Icon(Icons.error),
//     //       imageUrl: imageurl,
//     //       fit: BoxFit.cover,
//     //     )
//     //     );
//     return CachedNetworkImage(
//       imageUrl: imageurl,
//       imageBuilder: (context, imageProvider) => Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: imageProvider,
//             fit: BoxFit.cover,
//             // colorFilter:
//             // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
//           ),
//         ),
//       ),
//       placeholder: (context, url) => Image(
//         image: getImageFromAsset('ic_placeholder_image.png'),
//       ),
//       errorWidget: (context, url, error) => Icon(Icons.error),
//     );
//   }
// }
