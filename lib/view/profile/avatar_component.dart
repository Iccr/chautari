import 'package:cached_network_image/cached_network_image.dart';
import 'package:chautari/utilities/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class AvatarView extends StatelessWidget {
  final bool shouldShowCameraIcon;
  final String imageUrl;
  final double radius;
  final Function cameraAction;
  AvatarView(
      {this.imageUrl,
      this.shouldShowCameraIcon = false,
      this.radius = 106,
      this.cameraAction});
  double getHeight() {
    return shouldShowCameraIcon == true ? cameraIconWidth : 0.0;

    //
  }

  get cameraIconWidth => radius / 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius + cameraIconWidth,
      child: Stack(
        children: [
          Positioned(
            child: CircleAvatar(
              backgroundImage: (imageUrl ?? "").isEmpty
                  ? AssetImage("images/profile.png")
                  : CachedNetworkImageProvider(imageUrl ?? ""),
              // : NetworkImage(imageUrl ?? ""),
              backgroundColor: Colors.transparent,
              radius: radius / 2,
            ),
          ),
          Positioned(
            top: radius / 2 + cameraIconWidth / 2,
            right: cameraIconWidth,
            child: GestureDetector(
              onTap: () {
                cameraAction();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(cameraIconWidth)),
                padding: EdgeInsets.all(6),
                width: cameraIconWidth,
                height: this.getHeight(),
                child: Center(
                    child: Icon(
                  LineIcons.camera,
                  size: getHeight() / 2,
                  color: ChautariColors.white,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
