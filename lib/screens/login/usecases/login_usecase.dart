import 'package:dartz/dartz.dart';
import '../../../core/abstract/request_abs.dart';
import '../../../core/abstract/response_abs.dart';
import '../../../core/error/failures.dart';

import '../../../core/interfaces/request.dart';
import '../../../core/interfaces/usecase.dart';
import '../login_repository.dart';

class LoginUseCase extends UseCase<LoginResponse, LoginRequest> {
  final LoginRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, LoginResponse>> call({required LoginRequest request}) {
    return repository.login(request);
  }
}

class LoginRequest extends Request {
  LoginRequest({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  Map<String, dynamic> toJson() => {
        "Body": {
          "Execution": "[OnlineCheckin].[Authenticate]",
          "Token": null,
          "Request": {
            "Code": password,
            "Code2": username,
            "UrlType": 1,
          },
        },
      };
}

class LoginResponse extends Response {
  final String token;

  LoginResponse({
    required this.token,
    required int status,
    required String message,
  }) : super(message: message, status: status, body: {});

  factory LoginResponse.fromResponse(Response res) {
    return LoginResponse(
      status: res.status,
      message: res.message,
      token: res.body["Token"],
    );
  }
}
