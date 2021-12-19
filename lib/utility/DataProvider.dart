import 'dart:developer';

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

  static Future<NetworkResponse> getDocumentTypes({required String execution, required dynamic token, required Map<String, Object> request, required Function retry}) async {
    String api = Apis.getDocumentType;
    RequestModelGetDocumentTypes grtPassportTypesRM = RequestModelGetDocumentTypes(
      execution: execution,
      token: token,
      request: request,
    );
    return NetworkRequest(api: api, data: grtPassportTypesRM.toJson(), retry: retry).post();
  }

  static Future<NetworkResponse> getSelectCountries({required String execution, required dynamic token, required Map<String, Object> request, required Function retry}) async {
    String api = Apis.getSelectCountries;
    RequestModelGetSelectCountries selectCountriesRM = RequestModelGetSelectCountries(
      execution: execution,
      token: token,
      request: request,
    );
    return NetworkRequest(api: api, data: selectCountriesRM.toJson(), retry: retry).post();
  }

  static Future<NetworkResponse> getCheckDocoNecessity({required String execution, required dynamic token, required Map<String, Object> request, required Function retry}) async {
    String api = Apis.getCheckDocoNecessity;
    RequestModelGetSelectCheckDocoNecessity checkDocoNecessityRM = RequestModelGetSelectCheckDocoNecessity(
      execution: execution,
      token: token,
      request: request,
    );
    return NetworkRequest(api: api, data: checkDocoNecessityRM.toJson(), retry: retry).post();
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

  static Future<Response> getDocumentTypes({
    required String execution,
    required dynamic token,
    required Map<String, Object> request,
  }) async {
    Response response;
    String api = Apis.baseUrl + Apis.getDocumentType;
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

  static Future<Response> getSelectCountries({
    required String execution,
    required dynamic token,
    required Map<String, Object> request,
  }) async {
    Response response;
    String api = Apis.baseUrl + Apis.getSelectCountries;
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

  static Future<Response> getCheckDocoNecessity({
    required String execution,
    required dynamic token,
    required Map<String, Object> request,
  }) async {
    Response response;
    String api = Apis.baseUrl + Apis.getCheckDocoNecessity;
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
