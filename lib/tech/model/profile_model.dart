class Technician {
  final String technicianId;
  final String name;
  final String location;
  final bool isOnline;
  final String role;
  final int jobsDone;
  final double rating;
  final int experience;
  final List<String> specializedSkills;
  final double? latitude;
  final double? longitude;

  Technician({
    required this.technicianId,
    required this.name,
    required this.location,
    required this.isOnline,
    required this.role,
    required this.jobsDone,
    required this.rating,
    required this.experience,
    required this.specializedSkills,
    this.latitude,
    this.longitude,
  });

  factory Technician.fromJson(Map<String, dynamic> json) {
    return Technician(
      technicianId: json['technicianId'] ?? '',
      name: json['name'] ?? '',
      location: json['place'] ?? '',
      isOnline: json['technicianAvailableLitvStatus'] == 'Available',
      role: 'Technician',
      jobsDone: json['jobsCompleted'] ?? 0,
      rating: (json['ratingNo'] ?? 0).toDouble(),
      experience: json['experience'] ?? 0,
      specializedSkills: json['specialization'] != null 
          ? (json['specialization'] as String).split(',') 
          : [],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }
}