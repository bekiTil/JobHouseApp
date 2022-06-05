class CompanyProfile {
  final String location;
  final String bio;

  CompanyProfile(this.location, this.bio);

  factory CompanyProfile.fromJson(Map<String, dynamic> json) {
    return CompanyProfile(
      json['location'],
      json['bio'],
    );
  }
}
