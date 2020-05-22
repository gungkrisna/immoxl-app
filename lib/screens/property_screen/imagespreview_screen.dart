import 'package:IMMOXL/theme/styles.dart';
import 'package:IMMOXL/all_translations.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'asklisting_widget.dart';

class ImagesPreview extends StatefulWidget {
  final List images;
  final String propertyId;
  final int selectedIndex;
  ImagesPreview(
      {Key key,
      @required this.images,
      @required this.selectedIndex,
      @required this.propertyId})
      : super(key: key);
  @override
  _ImagesPreviewState createState() => _ImagesPreviewState();
}

class _ImagesPreviewState extends State<ImagesPreview> {
  List images;
  int selectedIndex;
  String propertyId;
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    propertyId = widget.propertyId;
    images = widget.images;
    selectedIndex = widget.selectedIndex;

    pageController = PageController(initialPage: selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(
              (selectedIndex + 1).toString() +
                  " of " +
                  images.length.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'PTSans',
              ),
            )),
        backgroundColor: Colors.black,
        body: Stack(children: <Widget>[
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: images[index],
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained,
              );
            },
            itemCount: images.length,
            loadingBuilder: (context, event) => Center(
              child: Container(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                ),
              ),
            ),
            pageController: pageController,
            onPageChanged: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          Positioned(
              bottom: 0,
              child: Container(
                  color: IMMOXLTheme.lightblue,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          onPressed: () {},
                          color: IMMOXLTheme.lightblue,
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              allTranslations.text('property', 'CALL'),
                              style: TextStyle(
                                fontSize: 16,
                                color: IMMOXLTheme.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'PTSans',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          onPressed: () => askListing(context),
                          color: IMMOXLTheme.lightblue,
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              allTranslations.text('property', 'MESSAGE'),
                              style: TextStyle(
                                fontSize: 16,
                                color: IMMOXLTheme.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'PTSans',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )))
        ]));
  }

  void askListing(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (builder) {
          return AskListingWidget();
        });
  }
}
