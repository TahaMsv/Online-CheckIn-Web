import '../global/RequestModels.dart';
import 'package:network_manager/network_manager.dart';

import 'Constants.dart';
import 'package:dio/dio.dart';

class DataProvider {
  static Future<NetworkResponse> getToken({required String execution, required dynamic token, required Map<String, Object> request, required Function retry}) async {
    String api = Apis.getTokenUrl;
    RequestModelGetToken getTokenRM = RequestModelGetToken(
      execution: execution,
      token: token,
      request: request,
    );
    return NetworkRequest(api: api, data: getTokenRM.toJson(), retry: retry).post();
  }

  static Future<NetworkResponse> getInformation({required String execution, required dynamic token, required Map<String, Object> request, required Function retry}) async {
    String api = Apis.getInformation;
    RequestModelGetInformation getInformationRM = RequestModelGetInformation(
      execution: execution,
      token: token,
      request: request,
    );
    return NetworkRequest(api: api, data: getInformationRM.toJson(), retry: retry).post();
  }
}

class DioClient {
  static Dio _dio = Dio();

  static Future<Response> getToken({
    required String execution,
    required dynamic token,
    required Map<String, Object> request,
  }) async {
    Response response;
    String api = Apis.baseUrl + Apis.getTokenUrl;
    _dio.options.headers['Content-Type'] = 'application/json';
    response = await _dio.post(api, data: {
      "Body": {
        "Execution": execution,
        "Token": null,
        "Request": request,
      },
    });
    return response;
  }

  static Future<Response> getInformation({
    required String execution,
    required dynamic token,
    required Map<String, Object> request,
  }) async {
    Response response;
    String api = Apis.baseUrl + Apis.getInformation;
    _dio.options.headers['Content-Type'] = 'application/json';
    response = await _dio.post(
      api,
      data: {
        "Body": {
          "Execution": execution,
          "Token": token,
          "Request": request,
        },
      },
    );
    return response;
  }
}
