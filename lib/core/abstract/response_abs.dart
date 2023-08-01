class Response {
  final int status;
  final String message;
  final dynamic body;

  factory Response.fromJson(json) => Response(body: json["Body"], status: json["ResultCode"], message: json["ResultText"]);

  Response({required this.status, required this.message, required this.body});

  bool get isSuccess => status > 0;
}

class MyResponse {
  final bool isSuccessful;

  MyResponse({required this.isSuccessful});

  bool get isSuccess => isSuccessful;
}
