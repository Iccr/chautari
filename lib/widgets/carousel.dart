import 'package:chautari/model/room_model.dart';
import 'package:chautari/utilities/api_service.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:chautari/utilities/theme/padding.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

typedef VoidCallback = void Function();

class CarouselWithIndicator extends StatefulWidget {
  final VoidCallback onImageTapped;
  final RoomModel model;
  final bool showWaterMark;

  CarouselWithIndicator(this.model,
      {this.onImageTapped, this.showWaterMark = true});

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
        width: 7.0,
        height: items.length > 1 ? 8.0 : 0,
        margin:
            EdgeInsets.symmetric(vertical: 0, horizontal: ChautariPadding.xs),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _current == index
              ? ChautariColors.white
              : ChautariColors.black.withOpacity(0.8),
        ),
      ));
    });
    return list;
  }

  BoxDecoration _glossyDecoration({double opacity = 1, Color color}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: color?.withOpacity(opacity) ??
          ChautariColors.primaryColor().shade600.withOpacity(opacity),
    );
  }

  List<Widget> _overlayWidgets() {
    var overlays = [
      if (this.widget.showWaterMark ?? false) ...[
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: _glossyDecoration(opacity: 0.5, color: Colors.white),
              child: Text(
                "Chautari Basti",
                style: TextStyle(
                    fontWeight: FontWeight.w400, color: ChautariColors.black),
              ),
            ),
          ),
        ),
      ],
      Positioned(
        bottom: 0,
        child: Container(
          height: getItems().length > 1 ? 15 : 0,
          padding: EdgeInsets.all(ChautariPadding.unit),
          decoration: _glossyDecoration(opacity: 0.8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: getPagerIndicator(),
          ),
        ),
      )
    ];
    return overlays;
  }

  List<Widget> _carousel() {
    return [
      GestureDetector(
        onTap: () {
          if (widget.onImageTapped != null) {
            widget.onImageTapped();
          }
        },
        child: CarouselSlider(
          items: getItems(),
          options: CarouselOptions(
            viewportFraction: 1.0,
            autoPlay: false,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            aspectRatio: 1.25,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
      ),
    ];
  }

  List<Widget> _carouselWithOverlay() {
    return [..._carousel(), ..._overlayWidgets()];
  }

//For Images
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ChautariColors.whiteAndBlackcolor().withOpacity(0.3),
      child: Stack(
        children: _carouselWithOverlay(),
      ),
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
      fadeInDuration: Duration(milliseconds: 100),
      fadeOutDuration: Duration(milliseconds: 100),
      fadeInCurve: Curves.easeOut,
      fadeOutCurve: Curves.easeIn,
      key: Key(imageurl),
      cacheKey: imageurl,
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
