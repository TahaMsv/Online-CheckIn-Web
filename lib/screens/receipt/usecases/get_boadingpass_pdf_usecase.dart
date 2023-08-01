import 'package:online_check_in/core/classes/boarding_pass_pdf.dart';
import 'package:dartz/dartz.dart';
import '../../../core/abstract/request_abs.dart';
import '../../../core/abstract/response_abs.dart';
import '../../../core/error/failures.dart';
import '../../../core/interfaces/usecase.dart';
import '../receipt_repository.dart';
import '../receipt_repository.dart';

class GetBoardingPassPdfUseCase extends UseCase<GetBoardingPassPdfResponse, GetBoardingPassPdfRequest> {
  final ReceiptRepository repository;

  GetBoardingPassPdfUseCase({required this.repository});

  @override
  Future<Either<Failure, GetBoardingPassPdfResponse>> call({required GetBoardingPassPdfRequest request}) {
    return repository.getBoardingPassPdf(request);
  }
}

class GetBoardingPassPdfRequest extends Request {
  GetBoardingPassPdfRequest({required this.passengerToken, required this.passengersID});

  final String passengerToken;
  final int passengersID;

  @override
  Map<String, dynamic> toJson() => {
        "Body": {
          "MrtName": "OnlineCheckinBoardingPass-AB",
          "Token": token,
          "Request": {
            "Format": 1, //1->pdf    32->Html
            "PassengersId": "<MyTable><MyRow><FlightPax_ID>$passengersID</FlightPax_ID></MyRow></MyTable>",
            "IsDarkMode": false,
          },
        },
      };
}

class GetBoardingPassPdfResponse {
  final BoardingPassPDF boardingPassPDF;

  GetBoardingPassPdfResponse({
    required this.boardingPassPDF,
  });

  factory GetBoardingPassPdfResponse.fromResponse(Response res) {
    return GetBoardingPassPdfResponse(boardingPassPDF: BoardingPassPDF.fromJson(res.body));
  }
}
