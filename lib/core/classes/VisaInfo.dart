class VisaInfo {
  late bool isVisaInfoCompleted = false;
  late String? type;
  late String? documentNo;
  late String? placeOfIssue;
  late String? destination;
  late DateTime? issueDate;
  late String? placeOfIssueID;

  VisaInfo({
    this.type,
    this.documentNo,
    this.placeOfIssue,
    this.destination,
    this.issueDate,
  });

  bool updateIsCompleted() {
    isVisaInfoCompleted = type != null && documentNo != null && placeOfIssue != null && destination != null && issueDate != null;
    print(type == null);
    print(documentNo == null);
    print(destination == null);
    print(destination == null);
    print(issueDate == null);
    print(isVisaInfoCompleted);
    return isVisaInfoCompleted;
  }
}