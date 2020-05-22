import 'package:IMMOXL/theme/styles.dart';
import 'package:IMMOXL/all_translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AskListingWidget extends StatefulWidget {
  @override
  _AskListingWidgetState createState() => _AskListingWidgetState();
}

class _AskListingWidgetState extends State<AskListingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: EdgeInsets.fromLTRB(
          20, 0, 20, MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    allTranslations.text('property', 'Request info'),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily: 'PTSans',
                    ),
                    textAlign: TextAlign.start,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.close,
                      color: IMMOXLTheme.lightblue,
                    ),
                  )
                ]),
            SizedBox(
              height: 25,
            ),
            Text(
              allTranslations.text('main', 'Name'),
              style: TextStyle(
                color: IMMOXLTheme.purple,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: 'PTSans',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: IMMOXLTheme.lightgrey,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(children: <Widget>[
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SvgPicture.asset(
                        'assets/icons/account_circle.svg',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 13,
                        color: IMMOXLTheme.darkgrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PTSans',
                      ),
                    )
                  ]),
                ),
              ),
            ),
            Text(
              allTranslations.text('main', 'Phone'),
              style: TextStyle(
                color: IMMOXLTheme.purple,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: 'PTSans',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: IMMOXLTheme.lightgrey,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(children: <Widget>[
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SvgPicture.asset(
                        'assets/icons/call.svg',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      '+31612345678',
                      style: TextStyle(
                        fontSize: 13,
                        color: IMMOXLTheme.darkgrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PTSans',
                      ),
                    )
                  ]),
                ),
              ),
            ),
            Text(
              allTranslations.text('property', 'Description'),
              style: TextStyle(
                color: IMMOXLTheme.purple,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: 'PTSans',
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Stack(children: [
                  TextFormField(
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                    initialValue: allTranslations.text('property',
                        'I am interested in this property. Can you contact me?'),
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'PTSans',
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 50.0, right: 10.0, top: 20.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          )),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10.0),
                      child: Icon(Icons.message, color: Colors.black),
                    ),
                  ),
                ])),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.maxFinite,
              child: FlatButton(
                onPressed: () {},
                color: IMMOXLTheme.lightblue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    allTranslations.text('property', 'SEND'),
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
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
