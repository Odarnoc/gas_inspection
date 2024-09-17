import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mikinder/constants/status_constant.dart';
import 'package:mikinder/services/coverage_map_service.dart';
import 'package:mikinder/services/request_document_service.dart';
import 'package:mikinder/services/request_petition_service.dart';
import 'package:mikinder/src/common/extensions/HexColor.dart';
import 'package:mikinder/src/models/coverage_lines_model.dart';
import 'package:mikinder/src/models/request_petition_model.dart';

class InstalationController extends ChangeNotifier {
  final RequestPetitionService requestPetitionService =
      RequestPetitionService();
  final RequestDocumentService requestDocumentService =
      RequestDocumentService();
  final CoveageMapService coveageMapService = CoveageMapService();

  Completer<GoogleMapController> _completer = Completer();
  late CameraPosition initialCameraPosition;
  late RequestPetitionModel _requestPetition;

  int _markerIdCounter = 1;

  final Map<PolylineId, Polyline> _polylines = {};
  Set<Polyline> get polylines => _polylines.values.toSet();

  final Map<MarkerId, Marker> _markers = {};
  Set<Marker> get markers => _markers.values.toSet();

  Future<GoogleMapController> getController() async => await _completer.future;

  RequestPetitionModel get requestPetition => _requestPetition;

  bool _inAsyncCall = false;

  bool get inAsyncCall => _inAsyncCall;

  set inAsyncCall(bool asyncCall) {
    _inAsyncCall = asyncCall;
    notifyListeners();
  }

  InstalationController(RequestPetitionModel requestPetition) {
    _requestPetition = requestPetition;
    initialCameraPosition = CameraPosition(
        target: LatLng(requestPetition.location.x, requestPetition.location.y),
        zoom: 16);
    addMarker(LatLng(requestPetition.location.x, requestPetition.location.y));
    loadLines();
  }

  onMapCreated(GoogleMapController controller, BuildContext context) async {
    _completer = Completer();
    _completer.complete(controller);
  }

  Future<void> loadLines() async {
    inAsyncCall = true;
    final lines = await coveageMapService.getLines();
    for (var element in lines) {
      addPolylines(element);
    }
    inAsyncCall = false;
    notifyListeners();
  }

  void addPolylines(CoverageLinesModel line) {
    PolylineId polylineId = PolylineId('polyline_id_${line.id}');

    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: false,
      color: HexColor.fromHex(line.color),
      width: 5,
      points: line.line.map((e) => LatLng(e.lat, e.lng)).toList(),
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

  Future<bool> finishInstalationProyect(BuildContext context, int id) async {
    bool isSuccess = false;
    inAsyncCall = true;
    RequestPetitionModel? newRequestPetitionModel =
        await requestPetitionService.updateRequestPetition({
      'status': StatusProyect.interrnalInspection,
      'id': id,
      'log': 'Se envió proyecto a inspección interna'
    });
    if (newRequestPetitionModel != null) {
      isSuccess = true;
      notifyListeners();
    }
    inAsyncCall = false;
    return isSuccess;
  }
}
