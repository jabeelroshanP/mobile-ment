import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_servies/admin/Model/completedOrder_admin_model.dart';
import 'package:mobile_servies/admin/service/completed_order_admin_service.dart';

class CompletedorderProvider with ChangeNotifier {
  final CompletedOrderService service;
  List<CompletedOrder> completedOrders = [];
  List<CompletedOrder> searchCompletedOrdersList = [];
  List<CompletedOrder> searchedList = [];
  bool isLoading = false;
  String? error;

  CompletedorderProvider(this.service);

  Future<void> fetchCompletedOrders({
    String? technicianId,
  }) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      completedOrders = await service.getCompletedOrders(
        technicianId: technicianId,
      );
      searchCompletedOrdersList = List.from(completedOrders);
      searchedList = List.from(completedOrders);
    } catch (e) {
      error = e.toString().contains('Unauthorized')
          ? 'Authentication failed. Please log in again.'
          : e.toString();
      completedOrders = [];
      searchCompletedOrdersList = [];
      searchedList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshCompleted() async {
    await fetchCompletedOrders();
  }

  Future<void> searchFn(String search) async {
    if (search.isEmpty) {
      searchedList = List.from(searchCompletedOrdersList);
    } else {
      searchedList = searchCompletedOrdersList.where((order) {
        final formattedDate = order.date != null
            ? DateFormat('dd/MM/yyyy').format(order.date!)
            : '';
        return (order.customerName?.toLowerCase().startsWith(search.toLowerCase()) ?? false) ||
            (order.device?.toLowerCase().startsWith(search.toLowerCase()) ?? false) ||
            (order.issue?.toLowerCase().startsWith(search.toLowerCase()) ?? false) ||
            (order.service?.toLowerCase().startsWith(search.toLowerCase()) ?? false) ||
            (order.location?.toLowerCase().startsWith(search.toLowerCase()) ?? false) ||
            formattedDate.toLowerCase().startsWith(search.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}