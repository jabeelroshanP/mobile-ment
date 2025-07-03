class TechnicianRequest {
  final String technicianRequestId;
  final String userId;
  final String name;
  final String email;
  final String phone;
  final int experience;
  final String specialization;
  final String bio;
  final String place;
  final double longitude;
  final double latitude;
  final String requestDate;
  final String status;
  final String? documentData;
  final String? adminRemark;

  TechnicianRequest({
    required this.technicianRequestId,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.experience,
    required this.specialization,
    required this.bio,
    required this.place,
    required this.longitude,
    required this.latitude,
    required this.requestDate,
    required this.status,
    this.documentData,
    this.adminRemark,
  });

  factory TechnicianRequest.fromJson(Map<String, dynamic> json) {
    return TechnicianRequest(
      technicianRequestId: json['technicianRequestID']?.toString() ?? '',
      userId: json['userID']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      experience: (json['experience'] as num?)?.toInt() ?? 0,
      specialization: json['specialization']?.toString() ?? '',
      bio: json['bio']?.toString() ?? '',
      place: json['place']?.toString() ?? '',
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      requestDate: json['requestDate']?.toString() ?? '',
      status: json['status']?.toString() ?? 'Pending',
      documentData: json['documentData']?.toString(),
      adminRemark: json['adminRemark']?.toString(),
    );
  }
}