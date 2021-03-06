class EmployeeProfile {
  final String fieldOfStudy;
  final String educationLevel;
  final int yearsOfExperience;
  final String location;
  final String bio;

  EmployeeProfile(this.fieldOfStudy, this.educationLevel,
      this.yearsOfExperience, this.location, this.bio);

  factory EmployeeProfile.fromJson(Map<String, dynamic> json) {
    return EmployeeProfile(
      json['fieldOfStudy'],
      json['educationLevel'],
      json['yearsOfExperience'],
      json['location'],
      json['bio'],
    );
  }
}
