import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobile_servies/admin/Model/tech_reqst_admin_model.dart';
import 'package:mobile_servies/admin/service/tech_rqst_service_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TechnicianRequestProvider with ChangeNotifier {
  List<TechnicianRequest> requests = [];
  List<TechnicianRequest> searchRequestsList = [];
  List<TechnicianRequest> searchedList = [];
  String? errorMessage;
  String statusFilter = 'All';
  bool isLoading = false;
  bool isApproving = false;
  bool isRejecting = false;
  String? currentProcessingId;

  final TechnicianRequestService _service = TechnicianRequestService();

  Future<bool> _checkTokenValidity() async {
    final prefs = await SharedPreferences.getInstance();
    final token = await prefs.getString('auth_token');
    if (token == null || token.isEmpty) {
      log('No auth token found');
      return false;
    }

    try {
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      if (!decodedToken.containsKey('exp')) {
        log('Token missing exp claim');
        return false;
      }
      final int exp = decodedToken['exp'];
      final DateTime expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return expiryDate.isAfter(DateTime.now());
    } catch (e) {
      log('Error decoding token: $e');
      return false;
    }
  }

  Future<void> fetchRequests() async {
    if (!(await _checkTokenValidity())) {
      errorMessage = 'Session expired. Please log in again.';
      requests = [];
      searchRequestsList = [];
      searchedList = [];
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      requests = await _service.fetchTechnicianRequests(
        status: statusFilter == 'All' ? null : statusFilter,
      );
      searchRequestsList = List.from(requests);
      searchedList = List.from(requests);
      log('Fetched ${requests.length} requests with filter: $statusFilter');
      if (requests.isEmpty) {
        errorMessage = 'No technician requests found for the selected criteria.';
      }
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      requests = [];
      searchRequestsList = [];
      searchedList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

   Future<void> refreshRqsts() async {
    await fetchRequests();
  }

  Future<bool> updateRequestStatus({
    required String technicianRequestId,
    required bool status,
    String? adminRemarks,
  }) async {
    if (!(await _checkTokenValidity())) {
      errorMessage = 'Session expired. Please log in again.';
      notifyListeners();
      return false;
    }

    if (status) {
      isApproving = true;
    } else {
      isRejecting = true;
    }
    currentProcessingId = technicianRequestId;
    notifyListeners();

    try {
      final success = await _service.updateRequestStatus(
        technicianRequestId: technicianRequestId,
        status: status,
        adminRemarks: adminRemarks,
      );
      
      if (success) {
        await fetchRequests();
        errorMessage = status
            ? 'Technician request approved! User is now a Technician.'
            : 'Technician request rejected.';
      } else {
        errorMessage = 'Failed to update request status.';
      }
      return success;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      isApproving = false;
      isRejecting = false;
      currentProcessingId = null;
      notifyListeners();
    }
  }

  Future<void> searchFn(String search) async {
    if (search.isEmpty) {
      searchedList = List.from(searchRequestsList);
    } else {
      searchedList = searchRequestsList.where((request) {
        return request.name.toLowerCase().contains(search.toLowerCase()) ||
            request.experience.toString().toLowerCase().contains(search.toLowerCase()) ||
            request.requestDate.toLowerCase().contains(search.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void setStatusFilter(String newFilter) {
    if (['All', 'Pending', 'Approved', 'Rejected'].contains(newFilter)) {
      statusFilter = newFilter;
      log('Status filter set to: $statusFilter');
      fetchRequests();
    } else {
      log('Invalid status filter: $newFilter');
      errorMessage = 'Invalid status filter selected.';
      notifyListeners();
    }
  }

  void clearErrorMessage() {
    errorMessage = null;
    notifyListeners();
  }
}