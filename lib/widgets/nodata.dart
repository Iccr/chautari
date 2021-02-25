import 'package:flutter/material.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            child: Image.asset("images/No_data.png"),
          ),
          Text(
            "There is not much to show you",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
