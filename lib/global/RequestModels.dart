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


class RequestModelGetDocumentTypes{
  final String execution;
  final dynamic token;
  final Map<String,dynamic> request;

  RequestModelGetDocumentTypes({
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


class RequestModelGetSelectCountries{
  final String execution;
  final dynamic token;
  final Map<String,dynamic> request;

  RequestModelGetSelectCountries({
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

class RequestModelGetSelectCheckDocoNecessity{
  final String execution;
  final dynamic token;
  final Map<String,dynamic> request;

  RequestModelGetSelectCheckDocoNecessity({
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


