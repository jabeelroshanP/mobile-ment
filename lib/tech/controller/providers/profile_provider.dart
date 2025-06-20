import 'package:flutter/foundation.dart';
import 'package:mobile_servies/tech/model/profile_model.dart';
import 'package:mobile_servies/tech/service/profile_service.dart';

class TechnicianProfileProvider with ChangeNotifier {
  final TechnicianApiService _apiService;
  Technician? _currentTechnician;
  bool _isLoading = false;
  String? _error;

  TechnicianProfileProvider(this._apiService);

  Technician? get currentTechnician => _currentTechnician;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchTechnicianDetails(String technicianId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentTechnician = await _apiService.getTechnicianDetails(technicianId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateOnlineStatus(bool isOnline) async {
    if (_currentTechnician == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      _currentTechnician = await _apiService.updateTechnicianStatus(
        technicianId: _currentTechnician!.technicianId,
        status: isOnline,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}