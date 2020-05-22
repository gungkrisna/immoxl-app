import 'dart:async';

import 'package:IMMOXL/all_translations.dart';
import 'package:IMMOXL/services/services.dart';
import 'package:IMMOXL/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:IMMOXL/components/maps/src/services/nominatim.dart';

class SetUserLocation extends StatefulWidget {
  SetUserLocation({
    this.searchHint,
    this.customMarkerIcon,
  });

  final String searchHint;
  final Widget customMarkerIcon;

  @override
  _SetUserLocationState createState() => _SetUserLocationState();
}

class _SetUserLocationState extends State<SetUserLocation>
    with TickerProviderStateMixin {
  Map mapData;
  List _addresses = List();
  Color _color = Colors.black;
  TextEditingController _ctrlSearch = TextEditingController();
  TextEditingController locationController = TextEditingController();
  Position _currentPosition;
  String _desc;
  bool _isSearching = false;
  double _lat;
  double _lng;
  Timer _debounce;
  MapController _mapController = MapController();
  List<Marker> _markers;
  LatLng _point;

  @override
  void initState() {
    super.initState();
    _ctrlSearch.addListener(_onSearchChanged);
    _getCurrentLocation();
    _markers = [
      Marker(
        width: 50.0,
        height: 50.0,
        point: new LatLng(0.0, 0.0),
        builder: (ctx) => new Container(child: widget.customMarkerIcon),
      )
    ];
    locationController.text = _desc == null ? null : _desc;
  }

  @override
  void dispose() {
    _ctrlSearch.removeListener(_onSearchChanged);
    _ctrlSearch.dispose();
    super.dispose();
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final _latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  _fetchSearches() async {
    dynamic _addresses =
        NominatimService().getAddressOnlyNetherlands(_ctrlSearch.text);
    locationController.text = _desc == null ? null : _desc;
    return _addresses;
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        _fetchSearches();
      });
    });
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getCurrentLocationMarker();
        _getCurrentLocationDesc();
      });
      _animatedMapMove(LatLng(_lat, _lng), 15);
    }).catchError((e) {
      print(e);
    });
  }

  _getCurrentLocationMarker() {
    setState(() {
      _lat = _currentPosition.latitude;
      _lng = _currentPosition.longitude;
      _point = LatLng(_lat, _lng);
      _markers[0] = Marker(
        width: 50.0,
        height: 50.0,
        point: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        builder: (ctx) => new Container(child: widget.customMarkerIcon),
      );
    });
  }

  _getCurrentLocationDesc() async {
    dynamic res = await NominatimService().getAddressLatLng(
        "${_currentPosition.latitude} ${_currentPosition.longitude}");
    setState(
      () {
        _addresses = res;
        _desc = _addresses[0]['description'];
        _lat = _currentPosition.latitude;
        _lng = _currentPosition.longitude;
        _point = LatLng(_lat, _lng);
        mapData = {
          'latitude': _addresses[0]['lat'],
          'longitude': _addresses[0]['lng'],
          'state': _addresses[0]['state'],
          'desc':
              "${_addresses[0]['state']}, ${_addresses[0]['city']}, ${_addresses[0]['suburb']}, ${_addresses[0]['neighbourhood']}, ${_addresses[0]['road']}",
          'display_name': _addresses[0]['description'],
        };
      },
    );
    locationController.text = _desc == null ? null : _desc;
  }

  onWillpop() {
    setState(() {
      _isSearching = false;
    });
  }

  _buildAppbar(bool _isResult) {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              left: 20,
              right: 20,
              bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _isSearching
                      ? setState(() {
                          _isSearching = false;
                        })
                      : Navigator.of(context).pop();
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    _isSearching = false;
                  });
                },
                child: Icon(_isResult ? Icons.close : Icons.arrow_back,
                    color: _color),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                height: 40,
                child: TextField(
                  controller: _ctrlSearch,
                  onTap: () {
                    if (_isSearching == false) {
                      setState(() {
                        _isSearching = true;
                      });
                    }
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    fontFamily: 'PTSans',
                  ),
                  decoration: InputDecoration(
                    hintText: widget.searchHint,
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      fontFamily: 'PTSans',
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        )),
                    fillColor: Colors.grey[200],
                    filled: true,
                    contentPadding: EdgeInsets.all(15),
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () async {
                  locationController.text = '';
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    _isSearching = false;
                  });
                  _getCurrentLocation();
                },
                child: Icon(Icons.gps_fixed, color: _color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mapContext(BuildContext context) {
    while (_currentPosition == null) {
      return new Center(
        child: Center(
          child: Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 60 + 40,
                  bottom: MediaQuery.of(context).size.height * 0.23 + 60 + 30),
              child: SpinKitPulse(
                color: IMMOXLTheme.purple,
              )),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 60,
          bottom: MediaQuery.of(context).size.height * 0.23 + 60),
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
            onTap: (LatLng location) {
              locationController.text = '';
              setState(() {
                _lat = location.latitude;
                _lng = location.longitude;
              });
              _animatedMapMove(
                  LatLng(location.latitude, location.longitude), 15);
              _markers[0] = Marker(
                width: 50.0,
                height: 50.0,
                point: new LatLng(location.latitude, location.longitude),
                builder: (ctx) => new Container(
                  child: Icon(
                    Icons.place,
                    color: IMMOXLTheme.purple,
                    size: 30,
                  ),
                ),
              );
              if (_debounce?.isActive ?? false) _debounce.cancel();
              _debounce = Timer(const Duration(milliseconds: 1500), () {
                _updateLocationDesc();
              });
            },
            center: LatLng(_lat, _lng),
            zoom: 15,
            maxZoom: 17),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              retinaMode: true),
          MarkerLayerOptions(
            markers: _markers,
          ),
        ],
      ),
    );
  }

  _updateLocationDesc() async {
    dynamic res = await NominatimService().getAddressLatLng("$_lat $_lng");
    setState(() {
      _addresses = res;
      _desc = _addresses[0]['description'];
      _lat = _currentPosition.latitude;
      _lng = _currentPosition.longitude;
      _point = LatLng(_lat, _lng);
      mapData = {
        'latlng': _point,
        'latitude': _addresses[0]['lat'],
        'longitude': _addresses[0]['lng'],
        'state': _addresses[0]['state'],
        'desc':
            "${_addresses[0]['state']}, ${_addresses[0]['city']}, ${_addresses[0]['suburb']}, ${_addresses[0]['neighbourhood']}, ${_addresses[0]['road']}",
        'display_name': _addresses[0]['description'],
      };

      locationController.text = _desc == null ? null : _desc;
    });
  }

  Widget _buildBody(BuildContext context) {
    return new Stack(
      children: <Widget>[
        mapContext(context),
        _isSearching ? Container() : _buildDescriptionContainer(),
        _isSearching ? Container() : setLocationButton(),
        _isSearching ? searchOptions() : Text(''),
      ],
    );
  }

  Widget _buildDescriptionContainer() {
    return new Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  allTranslations.text('profile', 'Location'),
                  style: TextStyle(
                    color: IMMOXLTheme.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'PTSans',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  child: TextFormField(
                    controller:
                        locationController == null ? null : locationController,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PTSans',
                    ),
                    decoration: InputDecoration(
                      hintText: 'Fetching maps data...',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: IMMOXLTheme.darkgrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PTSans',
                      ),
                      fillColor: IMMOXLTheme.lightgrey,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          )),
                    ),
                  ),
                ),
              ]),
        ),
        setLocationButton()
      ]),
    );
  }

  Widget setLocationButton() {
    return SizedBox(
      width: double.maxFinite,
      child: FlatButton(
        disabledColor: IMMOXLTheme.lightblue,
        disabledTextColor: IMMOXLTheme.white,
        onPressed: _desc == null
            ? null
            : () {
                setState(() {
                  _point = LatLng(
                      _currentPosition.latitude, _currentPosition.longitude);
                });
                _updateUserLocation(
                  address: mapData['display_name'],
                  state: mapData['state'],
                  latitude: mapData['latitude'],
                  longitude: mapData['longitude'],
                );
                Navigator.pop(context);
              },
        color: IMMOXLTheme.lightblue,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            allTranslations.text('profile', 'Set Location').toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'PTSans',
            ),
          ),
        ),
      ),
    );
  }

  Widget searchOptions() {
    return WillPopScope(
      onWillPop: () async => onWillpop(),
      child: Scaffold(
          backgroundColor: IMMOXLTheme.lightgrey,
          body: FutureBuilder(
              future: _fetchSearches(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(
                    child: Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(top: 40, bottom: 30),
                        child: SpinKitPulse(
                          color: IMMOXLTheme.purple,
                        )),
                  );
                }
                if (snapshot.hasData) {
                  return Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 60),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return Column(children: <Widget>[
                          ListTile(
                            onTap: () {
                              locationController.text = '';
                              _animatedMapMove(
                                  LatLng(
                                      double.parse(snapshot.data[index]['lat']),
                                      double.parse(
                                          snapshot.data[index]['lng'])),
                                  15);

                              setState(() {
                                _desc = snapshot.data[index][
                                    'description'];
                                _isSearching = false;
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                _lat =
                                    double.parse(snapshot.data[index]['lat']);
                                _lng =
                                    double.parse(snapshot.data[index]['lng']);
                                mapData = {
                                  'latlng': LatLng(_lat, _lng),
                                  'latitude': snapshot.data[index]['lat'],
                                  'longitude': snapshot.data[index]['lng'],
                                  'state': snapshot.data[index]['state'],
                                  'desc':
                                      "${snapshot.data[index]['state']}, ${snapshot.data[index]['city']}, ${snapshot.data[index]['suburb']}, ${snapshot.data[index]['neighbourhood']}, ${snapshot.data[index]['road']}",
                                  'display_name': snapshot.data[index]
                                      ['description'],
                                };
                                _markers[0] = Marker(
                                  width: 50.0,
                                  height: 50.0,
                                  point: LatLng(
                                      double.parse(snapshot.data[index]['lat']),
                                      double.parse(
                                          snapshot.data[index]['lng'])),
                                  builder: (ctx) => new Container(
                                      child: widget.customMarkerIcon == null
                                          ? Icon(
                                              Icons.location_on,
                                              size: 50.0,
                                            )
                                          : widget.customMarkerIcon),
                                );
                              });
                            },
                            title: Text(
                              snapshot.data[index]['description'],
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                fontFamily: 'PTSans',
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                          ),
                        ]);
                      },
                    ),
                  );
                }
                return Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 40, bottom: 30),
                      child: Text('Search limit reached.')),
                );
              })),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        _buildBody(context),
        _buildAppbar(_isSearching),
      ]),
    );
  }

  void _updateUserLocation(
      {String address,
      String latitude,
      String longitude,
      String state,
      BuildContext context}) async {
    try {
      await Auth.updateUserLocation(address, latitude, longitude, state);
    } catch (e) {}
  }
}
