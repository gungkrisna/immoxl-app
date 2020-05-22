import 'package:flutter/material.dart';
import 'package:IMMOXL/components/maps/nominatim_location_picker.dart';
import 'package:IMMOXL/theme/styles.dart';

class SetLocation extends StatefulWidget {
  @override
  _SetLocationState createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  Map _pickedLocation;

  Future getLocationWithNominatim() async {
    Map result = await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return SetUserLocation(
            searchHint: 'Search',
            customMarkerIcon: Icon(
              Icons.place,
              color: IMMOXLTheme.purple,
              size: 30,
            ),
          );
        });
    if (result != null) {
      setState(() => _pickedLocation = result);
    } else {
      return;
    }
  }

  RaisedButton nominatimButton(Color color, String name) {
    return RaisedButton(
      color: color,
      onPressed: () async {
        await getLocationWithNominatim();
      },
      textColor: Colors.white,
      child: Center(
        child: Text(name),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }

  Widget appBar() {
    return AppBar(
      centerTitle: true,
      title: Text('How to use'),
    );
  }

  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: _pickedLocation != null
              ? _pickedLocation
              : nominatimButton(Colors.blue, 'Nominatim Location Picker'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey, appBar: appBar(), body: body(context));
  }
}
