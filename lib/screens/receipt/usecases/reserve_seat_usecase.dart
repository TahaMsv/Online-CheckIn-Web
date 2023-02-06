import 'package:online_check_in/core/classes/boarding_pass_pdf.dart';
import 'package:dartz/dartz.dart';
import '../../../core/classes/seat_data.dart';
import '../../../core/error/failures.dart';
import '../../../core/interfaces/request.dart';
import '../../../core/interfaces/usecase.dart';
import '../receipt_repository.dart';

class ReserveSeatUseCase extends UseCase<bool, ReserveSeatRequest> {
  final ReceiptRepository repository;

  ReserveSeatUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call({required ReserveSeatRequest request}) {
    return repository.reserveSeat(request);
  }
}

class ReserveSeatRequest extends Request {
  ReserveSeatRequest({required this.seatsData});

  final List<SeatData> seatsData;

  @override
  Map<String, dynamic> toJson() => {
        "Body": {
          "Execution": "[OnlineCheckin].[ReserveSeat]",
          "Token": token,
          "Request": {
            "SeatsData": seatsData.map((e) => e.toJson()).toList(),
            "TicketData": null,
          },
        },
      };
}
