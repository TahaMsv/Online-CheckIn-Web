class BoardingPassPDF {
  BoardingPassPDF({
    required this.buffer,
    // required this.origin,
    // required this.position,
    // required this.length,
    // required this.capacity,
    // required this.expandable,
    // required this.writable,
    // required this.exposable,
    // required this.isOpen,
    // required this.identity,
  });

  String buffer;


  factory BoardingPassPDF.fromJson(Map<String, dynamic> json) => BoardingPassPDF(
    buffer: json["_buffer"],
    // origin: json["_origin"],
    // position: json["_position"],
    // length: json["_length"],
    // capacity: json["_capacity"],
    // expandable: json["_expandable"],
    // writable: json["_writable"],
    // exposable: json["_exposable"],
    // isOpen: json["_isOpen"],
    // identity: json["__identity"],
  );

  Map<String, dynamic> toJson() => {
    "_buffer": buffer,
    // "_origin": origin,
    // "_position": position,
    // "_length": length,
    // "_capacity": capacity,
    // "_expandable": expandable,
    // "_writable": writable,
    // "_exposable": exposable,
    // "_isOpen": isOpen,
    // "__identity": identity,
  };
}
