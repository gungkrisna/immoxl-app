import 'package:IMMOXL/theme/styles.dart';
import 'package:IMMOXL/all_translations.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:IMMOXL/components/readmore_component.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'imagespreview_screen.dart';
import 'asklisting_widget.dart';

class PropertyScreen extends StatefulWidget {
  const PropertyScreen({Key key, @required this.propertyId}) : super(key: key);
  final String propertyId;
  @override
  _PropertyScreenState createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen>
    with TickerProviderStateMixin {
  AnimationController colorAppBarAnimationController;
  Animation _colorTween, colorAppBarWidgetTween;
  int _selectedIndex = 0;

  List images = [
    NetworkImage(
        'https://www.whitehouse.gov/wp-content/uploads/2017/12/P20170614JB-0303-2-1024x683.jpg'),
    NetworkImage(
        'https://www.whitehouse.gov/wp-content/uploads/2017/12/35492069145_7d58e21088_k-1-1024x683.jpg'),
  ];

  @override
  void initState() {
    colorAppBarAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: IMMOXLTheme.white)
        .animate(colorAppBarAnimationController);
    colorAppBarWidgetTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(colorAppBarAnimationController);
    super.initState();
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      colorAppBarAnimationController.animateTo(scrollInfo.metrics.pixels / 350);
      return true;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: IMMOXLTheme.lightgrey,
      body: NotificationListener<ScrollNotification>(
        onNotification: _scrollListener,
        child: Container(
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              getPropertyUI(),
              Container(
                height: 80,
                child: AnimatedBuilder(
                  animation: colorAppBarAnimationController,
                  builder: (context, child) => AppBar(
                    backgroundColor: _colorTween.value,
                    elevation: 0,
                    titleSpacing: 0.0,
                    iconTheme: IconThemeData(
                      color: colorAppBarWidgetTween.value,
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                        ),
                        onPressed: () {
//                          Navigator.of(context).push(TutorialOverlay());
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getPropertyUI() {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          headerImage(context),
          agentDetails(),
          descriptionWidget(),
          SizedBox(height: 20),
          mapsWidget(),
          SizedBox(height: 20),
          detailWidget(),
        ]));
  }

  Widget headerImage(context) {
    return StatefulBuilder(builder: (context, setState) {
      return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ImagesPreview(
                  images: images,
                  selectedIndex: _selectedIndex,
                  propertyId: widget.propertyId);
            }));
          },
          child: Hero(
            tag: '873278',
            child: Stack(children: <Widget>[
              ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width,
                      rect.height + MediaQuery.of(context).size.height * 0.1));
                },
                blendMode: BlendMode.darken,
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    child: Carousel(
                      onImageChange: (prev, next) {
                        setState(() {
                          _selectedIndex = next;
                        });
                      },
                      images: images,
                      showIndicator: false,
                      autoplay: false,
                      borderRadius: true,
                    )),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.4 -
                      (MediaQuery.of(context).size.height * 0.4 / 3),
                  left: 20,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: IMMOXLTheme.lightblue,
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 6),
                            child: Text(
                              allTranslations.text('property', 'FOR RENT'),
                              style: TextStyle(
                                color: IMMOXLTheme.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'PTSans',
                              ),
                            ),
                          ),
                          Text(
                            "€250.000",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              fontFamily: 'PTSans',
                            ),
                          ),
                          Text(
                            "Amsterdam, Netherlands",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              fontFamily: 'PTSans',
                            ),
                          ),
                        ]),
                  )),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.4 -
                    (MediaQuery.of(context).size.height * 0.4 / 8),
                right: 20,
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.black.withOpacity(0.6),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.image,
                          color: Colors.white.withOpacity(0.8),
                          size: 13,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          (_selectedIndex + 1).toString() +
                              "/" +
                              images.length.toString(),
                          style: TextStyle(
                            color: IMMOXLTheme.white.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: 'PTSans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ));
    });
  }

  Widget agentDetails() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/commons/5/56/Donald_Trump_official_portrait.jpg'),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Donald Trump',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'PTSans',
                              ),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              allTranslations.text('property', 'Property Owner'),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                fontFamily: 'PTSans',
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ]),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ClipOval(
                          child: Material(
                            color: IMMOXLTheme.lightblue, // button color
                            child: InkWell(
                              splashColor: IMMOXLTheme.lightblue
                                  .withOpacity(0.4), // inkwell color
                              child: SizedBox(
                                  width: 45,
                                  height: 45,
                                  child: Icon(
                                    Icons.call,
                                    color: IMMOXLTheme.white,
                                  )),
                              onTap: () => _callAgent(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ClipOval(
                          child: Material(
                            color: IMMOXLTheme.lightblue, // button color
                            child: InkWell(
                              splashColor: IMMOXLTheme.lightblue
                                  .withOpacity(0.4), // inkwell color
                              child: SizedBox(
                                  width: 45,
                                  height: 45,
                                  child: Icon(
                                    Icons.message,
                                    color: IMMOXLTheme.white,
                                  )),
                              onTap: () => askListing(context),
                            ),
                          ),
                        ),
                      ])
                ]),
          ]),
    );
  }

  void askListing(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (builder) {
          return AskListingWidget();
        });
  }

  Widget descriptionWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Description',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'PTSans',
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ReadMoreText(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"),
      ]),
    );
  }

  Widget mapsWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: EdgeInsets.only(top: 20),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              allTranslations.text('property', 'Maps'),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'PTSans',
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 250,
          child: myLocation(),
        ),
        SizedBox(
          width: double.maxFinite,
          child: FlatButton(
            onPressed: () => _mapsDirection(),
            color: IMMOXLTheme.white,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                allTranslations.text('property', 'DIRECTION'),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PTSans',
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget detailWidget() {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Detail',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'PTSans',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  allTranslations.text('property', 'Views'),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    fontFamily: 'PTSans',
                  ),
                ),
                Text(
                  "1598",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    fontFamily: 'PTSans',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  allTranslations.text('property', 'Favorites'),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    fontFamily: 'PTSans',
                  ),
                ),
                Text(
                  "134",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    fontFamily: 'PTSans',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  allTranslations.text('property', 'Listed since'),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    fontFamily: 'PTSans',
                  ),
                ),
                Text(
                  "14/4/2020",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    fontFamily: 'PTSans',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Category",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    fontFamily: 'PTSans',
                  ),
                ),
                Text(
                  "Office",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    fontFamily: 'PTSans',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "IMMOXL ID",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    fontFamily: 'PTSans',
                  ),
                ),
                Text(
                  widget.propertyId,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    fontFamily: 'PTSans',
                  ),
                ),
              ],
            )
          ],
        ));
  }

  _callAgent() async {
    const url = 'tel:+6285238071534';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _mapsDirection() async {
    const url = 'https://www.google.com/maps/dir//-8.6359642, 115.2719045';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  FlutterMap myLocation() {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(-8.6359642, 115.2719045),
        zoom: 17.0,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(-8.6359642, 115.2719045),
              builder: (ctx) => Container(
                  child: Icon(
                Icons.place,
                color: IMMOXLTheme.purple,
                size: 30,
              )),
            ),
          ],
        ),
      ],
    );
  }
}
