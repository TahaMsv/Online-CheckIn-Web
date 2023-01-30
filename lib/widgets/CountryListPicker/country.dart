class Country {
  final String name;
  final String isoCode;
  final String iso3Code;
  final String phoneCode;
  final String languageCode;

  Country({
    required this.isoCode,
    required this.iso3Code,
    required this.phoneCode,
    required this.name,
    required this.languageCode,
  });

  factory Country.fromMap(Map<String, String> map) => Country(
        name: map['name']!,
        isoCode: map['isoCode']!,
        iso3Code: map['iso3Code']!,
        phoneCode: map['phoneCode']!,
        languageCode: map['languageCode']!,
      );

  @override
  bool operator ==(other) {
    return (other is Country) && other.name == name && other.iso3Code == iso3Code;
  }

  @override
  int get hashCode => super.hashCode;

}
