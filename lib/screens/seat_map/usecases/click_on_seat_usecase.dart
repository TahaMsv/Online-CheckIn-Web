import 'package:dartz/dartz.dart';
import 'package:online_checkin_web_refactoring/screens/Passport/passport_repository.dart';
import '../../../core/classes/MyCountry.dart';
import '../../../core/error/failures.dart';

import '../../../core/interfaces/request.dart';
import '../../../core/interfaces/usecase.dart';
import '../seat_map_repository.dart';

class ClickOnSeatUseCase extends UseCase<bool, ClickOnSeatRequest> {
  final SeatMapRepository repository;

  ClickOnSeatUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call({required ClickOnSeatRequest request}) {
    return repository.clickOnSeat(request);
  }
}

class ClickOnSeatRequest extends Request {
  ClickOnSeatRequest({required this.travelerToken, required this.seatsData});

  final String travelerToken;
  final List<Map<String, dynamic>> seatsData;

  @override
  Map<String, dynamic> toJson() => {
        "Body": {
          "Execution": "OnlineCheckin.ClickOnSeat",
          "Token": travelerToken,
          "Request": {"SeatsData": seatsData},
        },
      };
}
