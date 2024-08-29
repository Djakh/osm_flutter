import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with OSMMixinObserver, TickerProviderStateMixin {
  ValueNotifier<bool> visibilityOSMLayers = ValueNotifier(false);
  ValueNotifier<double> positionOSMLayers = ValueNotifier(-200);
  final MapController _mapController = MapController(initPosition: GeoPoint(latitude: 41.117578, longitude: 64.417244));

  /// --- Life cycle --

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> mapIsReady(bool isReady) {
    // TODO: implement mapIsReady
    throw UnimplementedError();
  }

  /// --- Methods ----

  /// --- Widgets ---
  Widget get mapIsLoading => const Material(
      color: Colors.yellow,
      child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            CupertinoActivityIndicator(),
            SizedBox(height: 8),
            Text("Карта загружается...", style: TextStyle(fontSize: 14))
          ])));

  Widget get osmMap => OSMFlutter(
      controller: _mapController,
      osmOption: OSMOption(
          enableRotationByGesture: false,
          zoomOption: const ZoomOption(initZoom: 6, minZoomLevel: 3, maxZoomLevel: 19, stepZoom: 1.0),
          userLocationMarker: UserLocationMaker(
              personMarker: const MarkerIcon(icon: Icon(Icons.location_history_rounded, color: Colors.red, size: 48)),
              directionArrowMarker: const MarkerIcon(icon: Icon(Icons.double_arrow, size: 48)))),
      mapIsLoading: mapIsLoading,
      onGeoPointClicked: (geoPoint) {});

  Widget get scaffold => Scaffold(body: osmMap, drawerEnableOpenDragGesture: kIsWeb);

  @override
  Widget build(BuildContext context) => SafeArea(child: scaffold);
}
