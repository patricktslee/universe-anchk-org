class OrganizationInfo {
  final String name;
  final String telephone;
  final String url;
  final String email;
  final String facebook;

  OrganizationInfo(
      this.name, this.telephone, this.url, this.email, this.facebook);

  factory OrganizationInfo.fromMap(Map<String, dynamic> map) {
    return OrganizationInfo(
      map['name'],
      map['telephone'],
      map['url'],
      map['email'],
      map['facebook'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'telephone': telephone,
      'url': url,
      'email': email,
      'facebook': facebook,
    };
  }
}
