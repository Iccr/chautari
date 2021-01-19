import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Chautari'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  ListView _getListView() {
    return ListView.separated(
      padding: EdgeInsets.only(left: 8, right: 8),
      itemCount: _models.length,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 24,
        );
      },
      itemBuilder: (context, index) {
        var model = _models.elementAt(index);

        return GestureDetector(
          onTap: () {
            openDetailView(model);
          },
          child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(6.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CarouselWithIndicator(model,
                        isDetailPage: false,
                        onImageTapped: () => (openDetailView(model))),
                    IconGroup(model),
                    InfoGroup(model)
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(6.0),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 13.0,
                    color: Colors.black26,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              )),
        );
      },
    );
  }
}
