import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  PageController pageViewController;
  String str;
  GlobalKey<ScaffoldState> scfldKey = new GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> fruits = [
    {
      'name': 'Orenge',
      'image': 'assets/images/oranges.png',
      'color': Colors.orange,
      'price': '1\$',
      'disc':
          'Oranges are low in calories and full of nutrients, they promote clear, healthy, skin and can help to lower our risk for many diseases as part of an overall healthy and varied diet.',
    },
    {
      'name': 'Pear',
      'image': 'assets/images/pear.png',
      'color': Colors.green,
      'price': '1\$',
      'disc':
          'Pears are a mild, sweet fruit with a fibrous center. They are rich in important antioxidants, flavonoids, and dietary fiber and pack all of these nutrients in a fat-free, cholesterol-free, 100-calorie package.',
    },
    {
      'name': 'Tomato',
      'image': 'assets/images/tomato.png',
      'color': Colors.red,
      'price': '1\$',
      'disc':
          'A tomato is a nutrient-dense superfood that offers benefit to a range of bodily systems. Its nutritional content supports healthful skin, weight loss, and heart health.',
    },
  ];
  Color clr = Colors.orange;
  var pos = 20.0;
  int currentPage = 0;
  double pageOffset = 0.0;
  double currentOffset = 0.0;
  var dir = ScrollDirection.reverse;
  @override
  void initState() {
    super.initState();
    pageViewController = new PageController(initialPage: 0);
    setState(() {
      clr = fruits[0]['color'];
    });
    pageViewController.addListener(() {
      dir = pageViewController.position.userScrollDirection;
      currentPage = pageViewController.page.truncate();
      currentOffset = pageViewController.offset;
      pageOffset = pageViewController.position.extentInside * currentPage;
      setState(() {
        pos = getMappedValue(0.0, pageViewController.position.extentInside,
            20.0, 100.0, pageViewController.offset - pageOffset);
      });
    });
  }

  double getMappedValue(double range1low, double range1high, double range2low,
      double range2high, double number) {
    return ((number - range1low) *
            ((range2high - range2low) / (range1high - range1low))) +
        range2low;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scfldKey,
      body: AnimatedContainer(
        padding: EdgeInsets.only(top: 50.0),
        duration: Duration(milliseconds: 1000),
        curve: Curves.ease,
        color: clr,
        child: PageView.builder(
          itemCount: fruits.length,
          onPageChanged: (int page) {
            this.setState(() {
              clr = fruits[page]['color'];
              print(page);
              print(clr);
            });
          },
          controller: pageViewController,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    height: MediaQuery.of(scfldKey.currentContext).size.height -
                        100.0,
                    width: MediaQuery.of(scfldKey.currentContext).size.width -
                        60.0,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          width: MediaQuery.of(scfldKey.currentContext)
                                  .size
                                  .width -
                              100.0,
                          left: index != currentPage
                              ? getMappedValue(20.0, 100.0, 160.0, 20.0, pos)
                              : getMappedValue(20.0, 100.0, 20.0, -120.0, pos),
                          top: 20.0,
                          child: Opacity(
                            opacity: index != currentPage
                                ? getMappedValue(20.0, 100.0, 0.0, 01.0, pos)
                                : getMappedValue(20.0, 100.0, 01.0, 00.0, pos),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '${fruits[index]['name']}',
                                      maxLines: 1,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      '${fruits[index]['price']}',
                                      softWrap: true,
                                      style: TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Text(
                                    '${fruits[index]['disc']}',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: index != currentPage
                              ? getMappedValue(20.0, 100.0, 160.0, 20.0, pos)
                              : getMappedValue(20.0, 100.0, 20.0, -120.0, pos),
                          bottom: 20.0,
                          child: Opacity(
                            opacity: index != currentPage
                                ? getMappedValue(20.0, 100.0, 0.0, 0.4, pos)
                                : getMappedValue(20.0, 100.0, 0.4, 00.0, pos),
                            child: Text(
                              '${fruits[index]['name']}',
                              maxLines: 1,
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 130.0, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: index != currentPage
                        ? getMappedValue(20.0, 100.0, -120.0, -10.0, pos)
                        : getMappedValue(20.0, 100.0, -10.0, 120.0, pos),
                    bottom: 100.0,
                    child: Opacity(
                      opacity: index != currentPage
                          ? getMappedValue(20.0, 100.0, 0.0, 1.0, pos)
                          : getMappedValue(20.0, 100.0, 1.0, 00.0, pos),
                      child: Image.asset(
                        '${fruits[index]['image']}',
                        height: 240.0,
                        width: 240.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
