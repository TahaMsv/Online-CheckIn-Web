class MyCountry {
  MyCountry({
    required this.id,
    required this.code3,
    required this.name,
    required this.englishName,
    required this.worldAreaCode,
    required this.currencyId,
    required this.regionId,
    required this.hasOnHoldBooking,
    required this.isDisabled,
  });

  String? id;
  String? code3;
  String? name;
  String? englishName;
  String? worldAreaCode;
  String? currencyId;
  int? regionId;
  bool? hasOnHoldBooking;
  bool? isDisabled;

  factory MyCountry.fromJson(Map<String, dynamic> json) => MyCountry(
    id: json["ID"] == null ? null : json["ID"],
    code3: json["Code3"] == null ? null : json["Code3"],
    name: json["Name"] == null ? null : json["Name"],
    englishName: json["EnglishName"] == null ? null : json["EnglishName"],
    worldAreaCode: json["World_Area_Code"] == null ? null : json["World_Area_Code"],
    currencyId: json["CurrencyID"] == null ? null : json["CurrencyID"],
    regionId: json["RegionID"] == null ? null : json["RegionID"],
    hasOnHoldBooking: json["HasOnHoldBooking"] == null ? null : json["HasOnHoldBooking"],
    isDisabled: json["IsDisabled"] == null ? null : json["IsDisabled"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Code3": code3,
    "Name": name,
    "EnglishName": englishName,
    "World_Area_Code": worldAreaCode == null ? null : worldAreaCode,
    "CurrencyID": currencyId == null ? null : currencyId,
    "RegionID": regionId == null ? null : regionId,
    "HasOnHoldBooking": hasOnHoldBooking == null ? null : hasOnHoldBooking,
    "IsDisabled": isDisabled == null ? null : isDisabled,
  };
}