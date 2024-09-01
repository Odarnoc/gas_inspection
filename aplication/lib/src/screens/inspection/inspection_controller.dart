import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mptk;

class DemoController extends ChangeNotifier {
  Completer<GoogleMapController> _completer = Completer();
  late CameraPosition initialCameraPosition;

  int _polylineIdCounter = 0;
  int _markerIdCounter = 1;

  final Map<PolylineId, Polyline> _polylines = {};
  Set<Polyline> get polylines => _polylines.values.toSet();

  final Map<MarkerId, Marker> _markers = {};
  Set<Marker> get markers => _markers.values.toSet();

  Future<GoogleMapController> getController() async => await _completer.future;

  double _distance = 0;

  double get distance => _distance;

  set distance(double distance) {
    _distance = distance;
    notifyListeners();
  }

  DemoController() {
    initialCameraPosition = const CameraPosition(
        target: LatLng(-16.504407470814837, -68.13277657413026), zoom: 16);
  }

  onMapCreated(GoogleMapController controller, BuildContext context) async {
    _completer = Completer();
    _completer.complete(controller);
    add();
    LatLng location = const LatLng(-16.504407470814837, -68.13277657413026);
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 16)));
  }

  void add() {
    final int polylineCount = polylines.length;

    if (polylineCount == 12) {
      return;
    }

    const PolylineId polylineId = PolylineId('polyline_id_');
    const PolylineId polylineId2 = PolylineId('polyline_id_2');
    const PolylineId polylineId3 = PolylineId('polyline_id_3');
    const PolylineId polylineId4 = PolylineId('polyline_id_4');
    const PolylineId polylineId5 = PolylineId('polyline_id_5');
    const PolylineId polylineId6 = PolylineId('polyline_id_6');

    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      color: Colors.lightGreenAccent[400]!,
      width: 5,
      points: const [
        LatLng(-16.504082, -68.133658),
        LatLng(-16.505296, -68.131790),
        LatLng(-16.505576, -68.131448),
      ],
    );

    final Polyline polyline2 = Polyline(
      polylineId: polylineId2,
      consumeTapEvents: true,
      color: Colors.lightGreenAccent[400]!,
      width: 5,
      points: const [
        LatLng(-16.504675, -68.132742),
        LatLng(-16.506435, -68.133946),
        LatLng(-16.506975, -68.133092),
        LatLng(-16.506557, -68.132650),
      ],
    );

    final Polyline polyline3 = Polyline(
      polylineId: polylineId3,
      consumeTapEvents: true,
      color: Colors.lightGreenAccent[400]!,
      width: 5,
      points: const [
        LatLng(-16.505523, -68.131951),
        LatLng(-16.504872, -68.131590),
        LatLng(-16.504445685783324, -68.13146433950027),
      ],
    );

    final Polyline polyline4 = Polyline(
      polylineId: polylineId4,
      consumeTapEvents: true,
      color: Colors.lightGreenAccent[400]!,
      width: 5,
      points: const [
        LatLng(-16.505136, -68.134335),
        LatLng(-16.505607, -68.133423),
      ],
    );

    final Polyline polyline5 = Polyline(
      polylineId: polylineId5,
      consumeTapEvents: true,
      color: Colors.red[600]!,
      width: 5,
      points: const [
        LatLng(-16.505607, -68.133423),
        LatLng(-16.506166, -68.132390),
      ],
    );

    final Polyline polyline6 = Polyline(
      polylineId: polylineId6,
      consumeTapEvents: true,
      color: Colors.red[600]!,
      width: 5,
      points: const [
        LatLng(-16.506557, -68.132650),
        LatLng(-16.505523, -68.131951),
      ],
    );

    _polylines[polylineId] = polyline;
    _polylines[polylineId2] = polyline2;
    _polylines[polylineId3] = polyline3;
    _polylines[polylineId4] = polyline4;
    _polylines[polylineId5] = polyline5;
    _polylines[polylineId6] = polyline6;
    notifyListeners();
  }

  void addPolyline() {
    final int polylineCount = polylines.length;

    if (polylineCount == 12) {
      return;
    }

    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    _polylineIdCounter++;
    final PolylineId polylineId = PolylineId(polylineIdVal);

    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      color: Colors.red,
      width: 5,
      points: markers.map((marker) => marker.position).toList(),
    );

    _polylines[polylineId] = polyline;
    notifyListeners();
  }

  addMarker(LatLng position) {
    final int markerCount = markers.length;

    final String polylineIdVal = 'Punto $_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(polylineIdVal);
    final market = Marker(markerId: markerId, position: position);
    _markers[markerId] = market;
    notifyListeners();
    if ((markerCount + 1) > 1) {
      calculateDistance();
    }
  }

  calculateDistance() {
    double distanceTemp = 0;
    List<Marker> listOfMArkers = markers.toList();
    print(listOfMArkers.length);
    for (var i = 1; i < listOfMArkers.length; i++) {
      print('marcador');
      mptk.LatLng from = mptk.LatLng(listOfMArkers[i - 1].position.latitude,
          listOfMArkers[i - 1].position.longitude);
      mptk.LatLng to = mptk.LatLng(listOfMArkers[i].position.latitude,
          listOfMArkers[i].position.longitude);
      distanceTemp += mptk.SphericalUtil.computeDistanceBetween(from, to);
    }
    print(distanceTemp);
    distance = distanceTemp;
  }
}
