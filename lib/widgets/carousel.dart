import 'package:chautari/model/rooms_model.dart';
import 'package:chautari/utilities/api_service.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

typedef VoidCallback = void Function();

class CarouselWithIndicator extends StatefulWidget {
  final VoidCallback onImageTapped;
  final RoomsModel model;

  CarouselWithIndicator(this.model, {this.onImageTapped});

  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  List<Widget> getItems() {
    print(widget.model.images);
    return widget.model.images
        .map((url) => Container(child: ImageView(BaseUrl().imageBaseUrl + url)))
        .toList();
  }

  List<Widget> getPagerIndicator() {
    var items = getItems();

    List<Widget> list = [];
    items.asMap().forEach((index, val) {
      // For image dot indicator
      list.add(Container(
        width: 8.0,
        height: items.length > 1 ? 8.0 : 0,
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 4.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _current == index
              ? ChautariColors.primaryColor()
              : ChautariColors.black.withOpacity(0.4),
        ),
      ));
    });
    return list;
  }

//For Images
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        GestureDetector(
          onTap: () {
            widget.onImageTapped();
          },
          child: CarouselSlider(
            items: getItems(),
            options: CarouselOptions(
              viewportFraction: 1.0,
              autoPlay: false,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              aspectRatio: true ? 5 / 4 : 1.67,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            margin: EdgeInsets.only(left: 5),
            height: 20,

            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: ChautariColors.grey.shade200.withOpacity(0.4)),
            // child: Stack(
            // alignment: Alignment.center,
            // children: <Widget>[
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: getPagerIndicator(),
            ),
            // Positioned(
            //   right: 10,
            //   bottom: 5,
            //   child: Text(""),
            // ),
            // ],
          ),
        )
      ]),
    );
  }
}

class ImageView extends StatelessWidget {
  final String imageurl;
  final int index = 2;
  ImageView(this.imageurl);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageurl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Image(
        image: AssetImage("images/room_placeholder.png"),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
