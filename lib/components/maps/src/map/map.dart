import 'package:IMMOXL/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatefulWidget {
  MapPage({
    Key key,
    @required this.lat,
    @required this.lng,
    @required this.mapController,
    @required this.markers,
    this.isNominatim = true,
    this.apiKey,
    this.customMapLayer,
  }) : super(key: key);
  final List<Marker> markers;
  final double lat;
  final double lng;
  final MapController mapController;
  final bool isNominatim;
  final String apiKey;
  final TileLayerOptions customMapLayer;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final _latTween = Tween<double>(
        begin: widget.mapController.center.latitude,
        end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: widget.mapController.center.longitude,
        end: destLocation.longitude);
    final _zoomTween =
        Tween<double>(begin: widget.mapController.zoom, end: destZoom);

    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      widget.mapController.move(
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

  Widget body(BuildContext context) {
    return new FlutterMap(
      mapController: widget.mapController,
      options: MapOptions(
          onTap: (LatLng location) {
            _animatedMapMove(LatLng(location.latitude, location.longitude), 15);
            widget.markers[0] = Marker(
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
          },
          center: LatLng(widget.lat, widget.lng),
          zoom: 15,
          maxZoom: 17),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            retinaMode: true),
        MarkerLayerOptions(
          markers: widget.markers,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: body(context),
    );
  }
}
