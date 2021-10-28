class RequestModelGetToken {
  final String execution;
  final dynamic token;
  final Map<String,dynamic> request;

  RequestModelGetToken({
    required  this.execution,
    required  this.token,
    required this.request,
  });

  Map<String, dynamic> toJson() => {
    "Execution": execution,
    "Token": token,
    "Request": request,
   };
}


class RequestModelGetInformation{
  final String execution;
  final dynamic token;
  final Map<String,dynamic> request;

  RequestModelGetInformation({
    required this.execution,
    required this.token,
    required this.request,
  });

  Map<String, dynamic> toJson() => {
    "Execution": execution,
    "Token": token,
    "Request": request,
  };
}
