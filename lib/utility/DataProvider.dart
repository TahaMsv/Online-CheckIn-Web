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

  static Future<NetworkResponse> selectCountries({required String execution, required dynamic token, required Map<String, Object> request, required Function retry}) async {
    String api = Apis.getSelectCountries;
    RequestModelSelectCountries selectCountriesRM = RequestModelSelectCountries(
      execution: execution,
      token: token,
      request: request,
    );
    return NetworkRequest(api: api, data: selectCountriesRM.toJson(), retry: retry).post();
  }

  static Future<NetworkResponse> checkDocoNecessity({required String execution, required dynamic token, required Map<String, Object> request, required Function retry}) async {
    String api = Apis.getCheckDocoNecessity;
    RequestModelSelectCheckDocoNecessity checkDocoNecessityRM = RequestModelSelectCheckDocoNecessity(
      execution: execution,
      token: token,
      request: request,
    );
    return NetworkRequest(api: api, data: checkDocoNecessityRM.toJson(), retry: retry).post();
  }

  static Future<NetworkResponse> saveDocsDocoDoca({required String execution, required dynamic token, required Map<String, Object> request, required Function retry}) async {
    String api = Apis.saveDocsDocoDoca;
    RequestModelSaveDocsDocoDoca saveDocsDocoDocaRM = RequestModelSaveDocsDocoDoca(
      execution: execution,
      token: token,
      request: request,
    );
    return NetworkRequest(api: api, data: saveDocsDocoDocaRM.toJson(), retry: retry).post();
  }

  static Future<NetworkResponse> reserveSeat({required String execution, required dynamic token, required Map<String, Object> request, required Function retry}) async {
    String api = Apis.reserveSeat;
    RequestModelReserveSeat reserveSeatRM = RequestModelReserveSeat(
      execution: execution,
      token: token,
      request: request,
    );
    return NetworkRequest(api: api, data: reserveSeatRM.toJson(), retry: retry).post();
  }

  static Future<NetworkResponse> selectBoardingPass({required String execution, required dynamic token, required Map<String, Object> request, required Function retry}) async {
    String api = Apis.selectBoardingPass;
    RequestModelSelectBoardingPass selectBoardingPassRM = RequestModelSelectBoardingPass(
      execution: execution,
      token: token,
      request: request,
    );
    return NetworkRequest(api: api, data: selectBoardingPassRM.toJson(), retry: retry).post();
  }

  static Future<NetworkResponse> selectSeatExtras({required String execution, required dynamic token, required Map<String, Object> request, required Function retry}) async {
    String api = Apis.selectSeatExtras;
    RequestModelSelectSeatExtras selectSeatExtrasRM = RequestModelSelectSeatExtras(
      execution: execution,
      token: token,
      request: request,
    );
    return NetworkRequest(api: api, data: selectSeatExtrasRM.toJson(), retry: retry).post();
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

  static Future<Response> selectCountries({
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

  static Future<Response> checkDocoNecessity({
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

  static Future<Response> saveDocsDocoDoca({
    required String execution,
    required dynamic token,
    required Map<String, Object> request,
  }) async {
    Response response;
    String api = Apis.baseUrl + Apis.saveDocsDocoDoca;
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

  static Future<Response> reserveSeat({
    required String execution,
    required dynamic token,
    required Map<String, Object> request,
  }) async {
    Response response;
    String api = Apis.baseUrl + Apis.reserveSeat;
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

  static Future<Response> selectBoardingPass({
    required String execution,
    required dynamic token,
    required Map<String, Object> request,
  }) async {
    Response response;
    String api = Apis.baseUrl + Apis.selectBoardingPass;
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

  static Future<Response> selectSeatExtras({
    required String execution,
    required dynamic token,
    required Map<String, Object> request,
  }) async {
    Response response;
    String api = Apis.baseUrl + Apis.selectSeatExtras;
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
