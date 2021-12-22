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


class RequestModelSelectCountries{
  final String execution;
  final dynamic token;
  final Map<String,dynamic> request;

  RequestModelSelectCountries({
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

class RequestModelSelectCheckDocoNecessity{
  final String execution;
  final dynamic token;
  final Map<String,dynamic> request;

  RequestModelSelectCheckDocoNecessity({
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


class RequestModelSaveDocsDocoDoca{
  final String execution;
  final dynamic token;
  final Map<String,dynamic> request;

  RequestModelSaveDocsDocoDoca({
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

class RequestModelReserveSeat{
  final String execution;
  final dynamic token;
  final Map<String,dynamic> request;

  RequestModelReserveSeat({
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


class RequestModelSelectBoardingPass{
  final String execution;
  final dynamic token;
  final Map<String,dynamic> request;

  RequestModelSelectBoardingPass({
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

class RequestModelBoardingPassPDF{
  final dynamic token;
  final Map<String,dynamic> request;

  RequestModelBoardingPassPDF({
    required this.token,
    required this.request,
  });

  Map<String, dynamic> toJson() => {
    "Token": token,
    "Request": request,
  };
}

class RequestModelBoardingPassSendEmail{
  final String execution;
  final dynamic token;
  final Map<String,dynamic> request;

  RequestModelBoardingPassSendEmail({
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

class RequestModelSelectSeatExtras{
  final String execution;
  final dynamic token;
  final Map<String,dynamic> request;

  RequestModelSelectSeatExtras({
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



