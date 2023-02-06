class PassportInfo {
  late bool isPassInfoCompleted = false;
  late String? passportType;
  late String? documentNo;
  late String? gender;
  late String? countryOfIssue;
  late String? nationality;
  late DateTime? dateOfBirth;
  late DateTime? entryDate;
  late String? nationalityID;

  PassportInfo({
    this.passportType,
    this.documentNo,
    this.gender,
    this.countryOfIssue,
    this.nationality,
    this.dateOfBirth,
    this.entryDate,
  });

  bool updateIsCompleted() {
    isPassInfoCompleted = passportType != null && documentNo != null && gender != null && countryOfIssue != null && nationality != null && dateOfBirth != null && entryDate != null;
    return isPassInfoCompleted;
  }
}