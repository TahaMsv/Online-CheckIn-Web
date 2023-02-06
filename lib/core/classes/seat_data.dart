
class SeatData {
  SeatData({
    required this.passengerId,
    required this.letter,
    required this.line,
  });

  int passengerId;
  String letter;
  int line;

  Map<String, dynamic> toJson() => {
    "PassengerID": passengerId,
    "Letter": letter,
    "Line": line,
  };
}
