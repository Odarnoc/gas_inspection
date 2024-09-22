import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mikinder/constants/glob_keys.dart';
import 'package:mikinder/constants/status_constant.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/services/coverage_map_service.dart';
import 'package:mikinder/services/request_document_service.dart';
import 'package:mikinder/services/request_petition_service.dart';
import 'package:mikinder/src/common/dialog_helpers.dart';
import 'package:mikinder/src/common/extensions/HexColor.dart';
import 'package:mikinder/src/models/coverage_lines_model.dart';
import 'package:mikinder/src/models/request_document_model.dart';
import 'package:mikinder/src/models/request_petition_model.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mptk;

class InspectionController extends ChangeNotifier {
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

  late Marker _markerClient;
  Marker get markerClient => _markerClient;

  Future<GoogleMapController> getController() async => await _completer.future;

  double _distance = 0;

  List<RequestDocumentModel> _documents = [];

  List<RequestDocumentModel> get documents => _documents;

  RequestPetitionModel get requestPetition => _requestPetition;

  bool _inAsyncCall = false;

  bool get inAsyncCall => _inAsyncCall;

  set inAsyncCall(bool asyncCall) {
    _inAsyncCall = asyncCall;
    notifyListeners();
  }

  String _observations = '';

  String get observations => _observations;

  set observations(String observations) {
    _observations = observations;
    notifyListeners();
  }

  bool _checkbox1 = false;

  bool get checkbox1 => _checkbox1;

  set checkbox1(bool checkbox1) {
    _checkbox1 = checkbox1;
    notifyListeners();
  }

  bool _checkbox2 = false;

  bool get checkbox2 => _checkbox2;

  set checkbox2(bool checkbox2) {
    _checkbox2 = checkbox2;
    notifyListeners();
  }

  bool _checkbox3 = false;

  bool get checkbox3 => _checkbox3;

  set checkbox3(bool checkbox3) {
    _checkbox3 = checkbox3;
    notifyListeners();
  }

  bool _checkbox4 = false;

  bool get checkbox4 => _checkbox4;

  set checkbox4(bool checkbox4) {
    _checkbox4 = checkbox4;
    notifyListeners();
  }

  bool _checkbox5 = false;

  bool get checkbox5 => _checkbox5;

  set checkbox5(bool checkbox5) {
    _checkbox5 = checkbox5;
    notifyListeners();
  }

  bool _checkbox6 = false;

  bool get checkbox6 => _checkbox6;

  set checkbox6(bool checkbox6) {
    _checkbox6 = checkbox6;
    notifyListeners();
  }

  bool _checkbox7 = false;

  bool get checkbox7 => _checkbox7;

  set checkbox7(bool checkbox7) {
    _checkbox7 = checkbox7;
    notifyListeners();
  }

  bool _checkbox8 = false;

  bool get checkbox8 => _checkbox8;

  set checkbox8(bool checkbox8) {
    _checkbox8 = checkbox8;
    notifyListeners();
  }

  bool _checkbox9 = false;

  bool get checkbox9 => _checkbox9;

  set checkbox9(bool checkbox9) {
    _checkbox9 = checkbox9;
    notifyListeners();
  }

  double get distance => _distance;

  set distance(double distance) {
    _distance = distance;
    notifyListeners();
  }

  InspectionController(RequestPetitionModel requestPetition) {
    _requestPetition = requestPetition;
    loadDocuments();
    checkbox1 = _requestPetition.minimumVolume;
    checkbox2 = _requestPetition.airSupply;
    checkbox3 = _requestPetition.airOutlet;
    checkbox4 = _requestPetition.rapidAeration;
    checkbox5 = _requestPetition.pressureCheck;
    checkbox6 = _requestPetition.valvuleCheck;
    checkbox7 = _requestPetition.leakCheck;
    checkbox8 = _requestPetition.ventilation;
    checkbox9 = _requestPetition.areaCleaning;
    initialCameraPosition = CameraPosition(
        target: LatLng(requestPetition.location.x, requestPetition.location.y),
        zoom: 16);
    // addMarkerClient(
    //    LatLng(requestPetition.location.x, requestPetition.location.y));
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

  cleanMeditions() {
    _markers.clear();
    _markerIdCounter = 1;
    distance = 0;
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

  addMarker(LatLng position) async {
    final int markerCount = markers.length;
    final icon = await createCustonMarkerIcon();

    String polylineIdVal = 'Punto $_markerIdCounter';
    _markerIdCounter++;
    MarkerId markerId = MarkerId(polylineIdVal);
    Marker market = Marker(
      markerId: markerId,
      position: position,
      icon: icon,
      draggable: true,
      onDragEnd: (value) {
        updateMarkers(markerId, value);
      },
    );
    _markers[markerId] = market;
    notifyListeners();
    if ((markerCount + 1) > 1) {
      calculateDistance();
    }
  }

  updateMarkers(MarkerId markerId, LatLng position) async {
    final icon = await createCustonMarkerIcon();
    final int markerCount = markers.length;
    Marker market = Marker(
      markerId: markerId,
      position: position,
      icon: icon,
      draggable: true,
      onDragEnd: (value) {
        updateMarkers(markerId, value);
      },
    );
    _markers[markerId] = market;
    notifyListeners();
    if ((markerCount + 1) > 1) {
      calculateDistance();
    }
  }

  Future<BitmapDescriptor> createCustonMarkerIcon() async {
    const iconData = Icons.location_on;
    final pictureRecorder = PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final iconStr = String.fromCharCode(iconData.codePoint);
    textPainter.text = TextSpan(
        text: iconStr,
        style: TextStyle(
          letterSpacing: 0.0,
          fontSize: 48.0,
          fontFamily: iconData.fontFamily,
          color: Colors.red,
        ));
    textPainter.layout();
    textPainter.paint(canvas, const Offset(0.0, 0.0));
    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(48, 48);
    final bytes = await image.toByteData(format: ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
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

  addMarkerClient(LatLng position) {
    const String polylineIdVal = 'Punto cliente';
    _markerIdCounter++;
    const MarkerId markerId = MarkerId(polylineIdVal);
    final market = Marker(markerId: markerId, position: position);
    _markers[markerId] = market;
    notifyListeners();
  }

  updateUrlIsometric(String imageUploadUrl, int id) async {
    inAsyncCall = true;
    RequestPetitionModel? newRequestPetitionModel = await requestPetitionService
        .updateRequestPetition({
      'isometric': imageUploadUrl,
      'id': id,
      'log': 'Se cargo isométrico'
    });
    if (newRequestPetitionModel != null) {
      showSuccessCenterSnackBar(
          S.of(navigatorKey.currentContext!).lLoadSuccess);
      _requestPetition.isometric = imageUploadUrl;
      notifyListeners();
    }
    inAsyncCall = false;
  }

  updateUrlMaterials(String imageUploadUrl, int id) async {
    inAsyncCall = true;
    RequestPetitionModel? newRequestPetitionModel = await requestPetitionService
        .updateRequestPetition({
      'materials': imageUploadUrl,
      'id': id,
      'log': 'Se cargo foto de materiales'
    });
    if (newRequestPetitionModel != null) {
      showSuccessCenterSnackBar(
          S.of(navigatorKey.currentContext!).lLoadSuccess);
      _requestPetition.materials = imageUploadUrl;
      notifyListeners();
    }
    inAsyncCall = false;
  }

  updateUrlFloorPlan(String imageUploadUrl, int id) async {
    inAsyncCall = true;
    RequestPetitionModel? newRequestPetitionModel = await requestPetitionService
        .updateRequestPetition({
      'floorPlan': imageUploadUrl,
      'id': id,
      'log': 'Se cargo plano de planta'
    });
    if (newRequestPetitionModel != null) {
      showSuccessCenterSnackBar(
          S.of(navigatorKey.currentContext!).lLoadSuccess);
      _requestPetition.floorPlan = imageUploadUrl;
      notifyListeners();
    }
    inAsyncCall = false;
  }

  Future<bool> approveProyect(BuildContext context, int id) async {
    bool isSuccess = false;
    inAsyncCall = true;
    RequestPetitionModel? newRequestPetitionModel =
        await requestPetitionService.updateRequestPetition({
      'pressureCheck': checkbox5,
      'valvuleCheck': checkbox6,
      'leakCheck': checkbox7,
      'ventilation': checkbox8,
      'areaCleaning': checkbox9,
      'status': StatusProyect.inspectionAproved,
      'id': id,
      'log': 'Se aprobó inspección'
    });
    if (newRequestPetitionModel != null) {
      isSuccess = true;
      _requestPetition.pressureCheck = checkbox5;
      _requestPetition.valvuleCheck = checkbox6;
      _requestPetition.leakCheck = checkbox7;
      _requestPetition.ventilation = checkbox8;
      _requestPetition.areaCleaning = checkbox9;
      notifyListeners();
    }
    inAsyncCall = false;
    return isSuccess;
  }

  Future<bool> internalApproveProyect(BuildContext context, int id) async {
    bool isSuccess = false;
    inAsyncCall = true;
    RequestPetitionModel? newRequestPetitionModel =
        await requestPetitionService.updateRequestPetition({
      'pressureCheck': checkbox5,
      'valvuleCheck': checkbox6,
      'leakCheck': checkbox7,
      'ventilation': checkbox8,
      'areaCleaning': checkbox9,
      'status': StatusProyect.done,
      'id': id,
      'log': 'Se finalizo el proyecto'
    });
    if (newRequestPetitionModel != null) {
      isSuccess = true;
      _requestPetition.minimumVolume = checkbox1;
      _requestPetition.airSupply = checkbox2;
      _requestPetition.airOutlet = checkbox3;
      _requestPetition.rapidAeration = checkbox4;
      notifyListeners();
    }
    inAsyncCall = false;
    return isSuccess;
  }

  Future<bool> updateProyect() async {
    bool isSuccess = false;
    inAsyncCall = true;
    RequestPetitionModel? newRequestPetitionModel =
        await requestPetitionService.updateRequestPetition({
      'pressureCheck': checkbox5,
      'valvuleCheck': checkbox6,
      'leakCheck': checkbox7,
      'ventilation': checkbox8,
      'areaCleaning': checkbox9,
      'id': requestPetition.id,
    });
    if (newRequestPetitionModel != null) {
      isSuccess = true;
      _requestPetition.pressureCheck = checkbox5;
      _requestPetition.valvuleCheck = checkbox6;
      _requestPetition.leakCheck = checkbox7;
      _requestPetition.ventilation = checkbox8;
      _requestPetition.areaCleaning = checkbox9;
      notifyListeners();
    }
    inAsyncCall = false;
    return isSuccess;
  }

  Future<bool> rejectProyect() async {
    bool isSuccess = false;
    inAsyncCall = true;
    RequestPetitionModel? newRequestPetitionModel =
        await requestPetitionService.updateRequestPetition({
      'id': requestPetition.id,
      'observations': observations,
      'status': StatusProyect.observed,
      'log': 'Se agregaron observaciones de inspección'
    });
    if (newRequestPetitionModel != null) {
      isSuccess = true;
      _requestPetition.minimumVolume = checkbox1;
      _requestPetition.airSupply = checkbox2;
      _requestPetition.airOutlet = checkbox3;
      _requestPetition.rapidAeration = checkbox4;
      notifyListeners();
    }
    inAsyncCall = false;
    return isSuccess;
  }

  Future<bool> internalRejectProyect() async {
    bool isSuccess = false;
    inAsyncCall = true;
    RequestPetitionModel? newRequestPetitionModel =
        await requestPetitionService.updateRequestPetition({
      'id': requestPetition.id,
      'status': StatusProyect.instalationReassigned,
      'log': 'La inspección interna se ha reasignado a instalador'
    });
    if (newRequestPetitionModel != null) {
      isSuccess = true;
      _requestPetition.minimumVolume = checkbox1;
      _requestPetition.airSupply = checkbox2;
      _requestPetition.airOutlet = checkbox3;
      _requestPetition.rapidAeration = checkbox4;
      notifyListeners();
    }
    inAsyncCall = false;
    return isSuccess;
  }

  addDocument(BuildContext context, String url) async {
    inAsyncCall = true;
    RequestDocumentModel? document =
        await requestDocumentService.create(requestPetition.id, url);

    if (document != null) {
      await loadDocuments();
    }
    inAsyncCall = false;
  }

  deleteDocument(BuildContext context, int id) async {
    inAsyncCall = true;
    bool delete = await requestDocumentService.delete(id);

    if (delete) {
      await loadDocuments();
    }
    inAsyncCall = false;
  }

  loadDocuments() async {
    inAsyncCall = true;
    _documents = await requestDocumentService.getDocuments(requestPetition.id);
    inAsyncCall = false;
    notifyListeners();
  }
}
