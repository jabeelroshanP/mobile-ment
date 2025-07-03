class ApiConstants {
  static const String baseURL="https://mobilemend-backend.onrender.com";
  static const registerUrl="https://mobilemend-backend.onrender.com/api/Auth/register";
  static const loginUrl="https://mobilemend-backend.onrender.com/api/Auth/login";
  static const logoutUrl="$baseURL/api/Auth/logout";
  static const technicianRequestUrl="$baseURL/api/Technician/technician-request";
  static const getRequestsUrl="$baseURL/api/Technician/get-requests";
  static const updateRequestStatusUrl="$baseURL/api/Technician/update-request-status";
  static const getAllTechs="$baseURL/api/Technician/get-technicians";
  static const getAllBookingsAdmin="$baseURL/api/Booking/get-booking";
 static const String getAllDevice = '/api/Device/get-device';
  static const String addDevice = '/api/Device/add-device';
  static const String updateDevice = '/api/Device/update-device';
  static const String deleteDevice = '/api/Device/delete-device';
  static const authme="${baseURL}/api/Auth/me";
  static const serviceBooking="${baseURL}/api/Service/get-service";
  static const devicebooking="${baseURL}/api/Device/get-device";
  static const addAddress="${baseURL}/api/Address/add-address";
  static const getBestTechnicians="${baseURL}/api/Technician/get-best-technicians";
  static const getAddress="${baseURL}/api/Address/get-address";
  static const updateAddress = "$baseURL/api/Address/update-address";
  static const deleteAddress="${baseURL}/api/Address/remove-address";
  static const bookingsEstimate="${baseURL}/api/Booking/get-booking-estimate";
  static const confirmBooking="${baseURL}/api/Booking/confirm-booking";
  static const getTechnician="${baseURL}/api/Technician/get-technicians";
  static const getBooking="${baseURL}/api/Booking/get-booking";

}