class CountryCodes {
  final String name;
  final String phoneCode;

  CountryCodes({required this.name, required this.phoneCode});
}

List<CountryCodes> countriesList = [];

List<CountryCodes> parseCountryList(dynamic json) {
  return List<CountryCodes>.from(json['countries'].map((countryJson) {
    return CountryCodes(
      name: countryJson['name'],
      phoneCode: countryJson['phone_code'],
    );
  }));
}