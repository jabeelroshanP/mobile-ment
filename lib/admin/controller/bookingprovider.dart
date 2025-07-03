import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_servies/admin/Model/bookingmodel.dart';
import 'package:mobile_servies/admin/service/bookingservice.dart';

class BookingProvider with ChangeNotifier {
  final BookingService service;
  List<Booking> bookings = [];
  List<Booking> searchBookingsList = [];
  List<Booking> searchedList = [];
  bool isLoading = false;
  String error = '';
  String selectedFilter = 'All';

  List<String> filterOptions = [
    'All',
    'Assigned',
    'InProgress',
    'Accepted',
    'Rejected',
    'Completed',
  ];

  BookingProvider({BookingService? service}) : service = service ?? BookingService();

  Future<void> fetchBookings() async {
    isLoading = true;
    error = '';
    notifyListeners();

    try {
      bookings = await service.getBookings(
        status: selectedFilter == 'All' ? null : selectedFilter,
      );
      searchBookingsList = List.from(bookings);
      searchedList = List.from(bookings);
      if (bookings.isEmpty) {
        error = 'No bookings available';
      }
    } catch (e) {
      error = e.toString();
      bookings = [];
      searchBookingsList = [];
      searchedList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshBookings() async {
    await fetchBookings();
  }

  void setFilter(String filter) {
    selectedFilter = filter;
    fetchBookings();
  }

  void resetFilter() {
    selectedFilter = 'All';
    fetchBookings();
  }

  void refresh() {
    error = '';
    fetchBookings();
  }

  Future<void> searchFn(String search) async {
    if (search.isEmpty) {
      searchedList = List.from(searchBookingsList);
    } else {
      searchedList = searchBookingsList.where((booking) {
        final formattedDate = booking.createdAt != null
            ? DateFormat('MMM d, yyyy').format(booking.createdAt!)
            : '';
        return (booking.customerName?.toLowerCase().startsWith(search.toLowerCase()) ?? false) ||
            (booking.serviceName?.toLowerCase().startsWith(search.toLowerCase()) ?? false) ||
            (booking.deviceName?.toLowerCase().startsWith(search.toLowerCase()) ?? false) ||
            formattedDate.toLowerCase().startsWith(search.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}