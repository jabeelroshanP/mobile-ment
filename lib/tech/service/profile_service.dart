import 'package:dio/dio.dart';
import 'package:mobile_servies/tech/model/profile_model.dart';
import 'package:mobile_servies/user/constants/constant_api/const_url.dart';

class TechnicianApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: '${ApiConstants.baseURL}',
    // connectTimeout: const Duration(seconds: 30),
    // receiveTimeout: const Duration(seconds: 30),
  ));

  Future<List<Technician>> getBestTechnicians({
    required String customerAddressId,
    required String deviceId,
  }) async {
    try {
      print('GET /api/Technician/get-best-technicians');
      print('Query: customerAddressId=$customerAddressId, deviceId=$deviceId');

      final response = await _dio.get(
        '/api/Technician/get-best-technicians',
        queryParameters: {
          'customerAddressId': customerAddressId,
          'deviceId': deviceId,
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((tech) => Technician.fromJson(tech))
            .toList();
      }
      throw Exception('Failed to load technicians');
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      throw Exception('Dio error: ${e.message}');
    }
  }

  Future<Technician> getTechnicianDetails(String technicianId) async {
    try {
      print('GET /api/Technician/get-technicians');
      print('Query: technicianId=$technicianId');

      final response = await _dio.get(
        '/api/Technician/get-technicians',
        queryParameters: {'technicianId': technicianId},
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        return Technician.fromJson(response.data);
      }
      throw Exception('Failed to load technician details');
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      throw Exception('Dio error: ${e.message}');
    }
  }

  Future<Technician> updateTechnicianStatus({
    required String technicianId,
    required bool status,
  }) async {
    try {
      print('PATCH /api/Technician/update-availability');
      print('Technician ID: $technicianId');
      print('Status: ${status ? 'Available' : 'Unavailable'}');

      final response = await _dio.patch(
        '/api/Technician/update-availability',
        data: {
          'technicianAvailableLitvStatus': status ? 'Available' : 'Unavailable',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        return Technician.fromJson(response.data);
      }
      throw Exception('Failed to update status');
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      throw Exception('Dio error: ${e.message}');
    }
  }
}
