import 'package:dartz/dartz.dart';
import 'package:online_check_in/core/classes/seat_data.dart';
import 'package:online_check_in/screens/Passport/passport_repository.dart';
import '../../../core/abstract/request_abs.dart';
import '../../../core/abstract/response_abs.dart';
import '../../../core/classes/my_country.dart';
import '../../../core/error/failures.dart';

import '../../../core/interfaces/request.dart';
import '../../../core/interfaces/usecase.dart';
import '../seat_map_repository.dart';

class ClickOnSeatUseCase extends UseCase<ClickOnSeatResponse, ClickOnSeatRequest> {
  final SeatMapRepository repository;

  ClickOnSeatUseCase({required this.repository});

  @override
  Future<Either<Failure, ClickOnSeatResponse>> call({required ClickOnSeatRequest request}) {
    return repository.clickOnSeat(request);
  }
}

class ClickOnSeatRequest extends Request {
  ClickOnSeatRequest({required this.seatsData});

  final List<SeatData> seatsData;

  @override
  Map<String, dynamic> toJson() => {
        "Body": {
          "Execution": "OnlineCheckin.ClickOnSeat",
          "Token": token,
          "Request": {"SeatsData": seatsData.map((e) => e.toJson()).toList()},
        },
      };
}

class ClickOnSeatResponse {
  final bool successful;

  ClickOnSeatResponse({
    required this.successful,
  });

  factory ClickOnSeatResponse.fromResponse(MyResponse res) {
    return ClickOnSeatResponse(successful: res.isSuccessful);
  }
}
