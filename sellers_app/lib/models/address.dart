class Address {
  String name;
  String phone;
  String streetNumber;
  String flatHouseNumber;
  String city;
  String stateCountry;
  String completeAddress;
  Address({
    required this.name,
    required this.phone,
    required this.streetNumber,
    required this.flatHouseNumber,
    required this.city,
    required this.stateCountry,
    required this.completeAddress,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      name: json['name'],
      phone: json['phone'],
      streetNumber: json['streetNumber'],
      flatHouseNumber: json['flatHouseNumber'],
      city: json['city'],
      stateCountry: json['stateCountry'],
      completeAddress: json['completeAddress'],
    );
  }
}
