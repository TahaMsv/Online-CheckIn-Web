import 'package:online_checkin_web_refactoring/core/classes/boarding_pass_pdf.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/interfaces/request.dart';
import '../../../core/interfaces/usecase.dart';
import '../receipt_repository.dart';
import '../receipt_repository.dart';

class GetBoardingPassPdfUseCase extends UseCase<BoardingPassPDF, GetBoardingPassPdfRequest> {
  final ReceiptRepository repository;

  GetBoardingPassPdfUseCase({required this.repository});

  @override
  Future<Either<Failure, BoardingPassPDF>> call({required GetBoardingPassPdfRequest request}) {
    return repository.getBoardingPassPdf(request);
  }
}

class GetBoardingPassPdfRequest extends Request {
  GetBoardingPassPdfRequest({required this.passengerToken, required this.passengerId});

  final String passengerToken;
  final int passengerId;

  @override
  Map<String, dynamic> toJson() => {
        "Body": {
          "MrtName": "OnlineCheckinBoardingPass-AB",
          "Token": passengerToken,
          "Request": {
            "Format": 1, //1->pdf    32->Html
            "PassengersId": "<MyTable><MyRow><FlightPax_ID>$passengerId</FlightPax_ID></MyRow></MyTable>",
            "IsDarkMode": false,
          },
        },
      };
}
