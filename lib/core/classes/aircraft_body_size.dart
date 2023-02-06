class AirCraftBodySize {
  AirCraftBodySize({
    required this.eachLineWidth,
    required this.seatWidth,
    required this.seatHeight,
    required this.linesMargin,
    required this.firstClassCabinsRatio,
    required this.businessCabinsRatio,
  });

  double eachLineWidth;
  double seatWidth;
  double seatHeight;
  double linesMargin;
  double firstClassCabinsRatio;
  double businessCabinsRatio;

  void setEachLineWidth(double val) => eachLineWidth = val;

  void setSeatWidth(double val) => seatWidth = val;

  void setSeatHeight(double val) => seatHeight = val;

  void setLinesMargin(double val) => linesMargin = val;

  void setFirstClassCabinsRatio(double val) => firstClassCabinsRatio = val;

  void setBusinessCabinsRatio(double val) => businessCabinsRatio = val;

  factory AirCraftBodySize.example() => AirCraftBodySize(
        eachLineWidth: 35,
        seatWidth: 35,
        seatHeight: 35,
        linesMargin: 7,
        firstClassCabinsRatio: 1.5,
        businessCabinsRatio: 1.5,
      );
}
