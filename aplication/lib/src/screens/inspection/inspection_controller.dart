import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mptk;
import 'package:mikinder/src/models/request_petition_model.dart';

class InspectionController extends ChangeNotifier {
  Completer<GoogleMapController> _completer = Completer();
  late CameraPosition initialCameraPosition;
  late RequestPetitionModel _requestPetition;

  int _markerIdCounter = 1;

  final Map<PolylineId, Polyline> _polylines = {};
  Set<Polyline> get polylines => _polylines.values.toSet();

  final Map<MarkerId, Marker> _markers = {};
  Set<Marker> get markers => _markers.values.toSet();

  Future<GoogleMapController> getController() async => await _completer.future;

  double _distance = 0;

  RequestPetitionModel get requestPetition => _requestPetition;

  bool _checkbox1 = false;

  bool get checkbox1 => _checkbox1;

  set checkbox1(bool checkbox1) {
    _checkbox1 = checkbox1;
    notifyListeners();
  }

  double get distance => _distance;

  set distance(double distance) {
    _distance = distance;
    notifyListeners();
  }

  InspectionController(RequestPetitionModel requestPetition) {
    _requestPetition = requestPetition;
    initialCameraPosition = CameraPosition(
        target: LatLng(requestPetition.location.x, requestPetition.location.y),
        zoom: 16);
    addMarker(LatLng(requestPetition.location.x, requestPetition.location.y));
  }

  onMapCreated(GoogleMapController controller, BuildContext context) async {
    _completer = Completer();
    _completer.complete(controller);
  }

  void addPolylines() {
    const PolylineId polylineId = PolylineId('polyline_id_1');

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

    _polylines[polylineId] = polyline;
    notifyListeners();
  }

  addMarker(LatLng position) {
    final String polylineIdVal = 'Punto $_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(polylineIdVal);
    final market = Marker(markerId: markerId, position: position);
    _markers[markerId] = market;
    notifyListeners();
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
