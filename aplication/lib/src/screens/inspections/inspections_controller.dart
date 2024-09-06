import 'package:flutter/material.dart';
import 'package:mikinder/services/request_petition_service.dart';
import 'package:mikinder/src/models/request_petition_model.dart';

class InspectionsController with ChangeNotifier {
  final RequestPetitionService requestPetitionService =
      RequestPetitionService();

  InspectionsController() {
    loadRequestPetitions();
  }

  loadRequestPetitions() async {
    inAsyncCall = true;
    _inspections = await requestPetitionService.getPreinspections();
    _internalInspections =
        await requestPetitionService.getInternalInspections();
    inAsyncCall = false;
    notifyListeners();
  }

  List<RequestPetitionModel> _inspections = [];

  List<RequestPetitionModel> get inspections => _inspections;

  List<RequestPetitionModel> _internalInspections = [];

  List<RequestPetitionModel> get internalInspections => _internalInspections;

  bool _inAsyncCall = false;

  bool get inAsyncCall => _inAsyncCall;

  set inAsyncCall(bool asyncCall) {
    _inAsyncCall = asyncCall;
    notifyListeners();
  }
}
