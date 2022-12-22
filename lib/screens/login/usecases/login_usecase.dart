import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';

import '../../../core/interfaces/request.dart';
import '../../../core/interfaces/usecase.dart';
import '../login_repository.dart';

class LoginUseCase extends UseCase<String, LoginRequest> {
  final LoginRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call({required LoginRequest request}) {
    return repository.login(request);
  }
}

class LoginRequest extends Request {
  LoginRequest(
    this.execution,
    this.token,
    this.request,
  );

  final String execution;
  final dynamic token;
  final Map<String, dynamic> request;

  @override
  Map<String, dynamic> toJson() => {
        "Body": {
          "Execution": execution,
          "Token": null,
          "Request": request,
        },
      };
}
