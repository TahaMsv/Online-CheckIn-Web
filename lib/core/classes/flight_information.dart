

import 'dart:convert';

import 'flight.dart';
import 'passenger.dart';
import 'seat.dart';
import 'seat_map.dart';

FlightInformation flightInformationFromJson(String str) => FlightInformation.fromJson(json.decode(str));


class FlightInformation {
  FlightInformation({
    required this.flight,
    required this.passengers,
    required this.seats,
    required this.seatmap,
  });

  List<Flight> flight;
  List<Passenger> passengers;
  List<Seat> seats;
  SeatMap seatmap;



  factory FlightInformation.fromJson(Map<String, dynamic> json) => FlightInformation(
    flight: List<Flight>.from(json["Flight"].map((x) => Flight.fromJson(x))),
    passengers: List<Passenger>.from(json["Passengers"].map((x) => Passenger.fromJson(x))),
    seats: List<Seat>.from(json["Seats"].map((x) => Seat.fromJson(x))),
    seatmap: SeatMap.fromJson(json["Seatmap"]),
  );

  Map<String, dynamic> toJson() => {
    "Flight": List<dynamic>.from(flight.map((x) => x.toJson())),
    "Passengers": List<dynamic>.from(passengers.map((x) => x.toJson())),
    "Seats": List<dynamic>.from(seats.map((x) => x.toJson())),
    "Seatmap": seatmap.toJson(),
  };
}