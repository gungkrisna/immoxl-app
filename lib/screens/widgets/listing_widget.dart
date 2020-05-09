import 'package:IMMOXL/theme/styles.dart';
import 'package:flutter/material.dart';

class ListingWidget extends StatefulWidget {
  final String agentProfileName;
  final String agentProfileAvatar;
  final String propertyPicture;
  final String propertyLocation;
  final String propertyPrice;
  final String propertyId;
  final String propertyStatus;
  final bool isFavorite;

  const ListingWidget(
      {Key key,
      this.agentProfileName: "",
      this.propertyPicture: "",
      this.agentProfileAvatar: "",
      this.propertyLocation: "",
      this.propertyPrice: "",
      this.propertyId: "",
      this.propertyStatus,
      this.isFavorite})
      : super(key: key);
  @override
  _ListingWidgetState createState() => _ListingWidgetState();
}

class _ListingWidgetState extends State<ListingWidget> {
  bool isFavorite;

  @override
  void initState() {
    isFavorite = widget.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    ClipRRect(
                      child: AspectRatio(
                        aspectRatio: 16.0 / 9.0,
                        child: Container(
                          color: Colors.black,
                          child: Hero(
                            tag: widget.propertyId,
                            child: Image.network(
                              widget.propertyPicture,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    Positioned(
                      left: 10,
                      top: 15,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: IMMOXLTheme.lightblue,
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                          child: Text(
                            widget.propertyStatus,
                            style: TextStyle(
                              color: IMMOXLTheme.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'PTSans',
                            ),
                          )),
                    ),
                    Positioned(
                      right: 10,
                      top: 15,
                      child: GestureDetector(
                          onTap: () => isFavorite = isFavorite ? false : true,
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.black,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.propertyPrice,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'PTSans',
                      ),
                    ),
                    Text(
                      widget.propertyLocation,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        fontFamily: 'PTSans',
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: new NetworkImage(widget.agentProfileAvatar),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
