part of '../flu_utils.dart';

extension FlukitAPIService on FlukitInterface {
  FluApiSettings get apiSettings => Flukit.appController.apiSettings;

  // ignore: library_private_types_in_public_api
  _FluConnect get http => _FluConnect(settings: apiSettings);
}

class FluApiSettings {
  /// Request base url, it can contain sub path, like: "https://www.google.com/api/".
  final String baseUrl;

  /// [responseType] indicates the type of data that the server will respond with
  /// options which defined in [ResponseType] are `json`, `stream`, `plain`.
  ///
  /// The default value is `json`, dio will parse response string to json object automatically
  /// when the content-type of response is 'application/json'.
  ///
  /// If you want to receive response data with binary bytes, for example,
  /// downloading a image, use `stream`.
  ///
  /// If you want to receive the response data with String, use `plain`.
  ///
  /// If you want to receive the response data with  original bytes,
  /// that's to say the type of [Response.data] will be List<int>, use `bytes`
  final dio.ResponseType responseType;

  /// Http request headers. The keys of initial headers will be converted to lowercase,
  /// for example 'Content-Type' will be converted to 'content-type'.
  ///
  /// The key of Header Map is case-insensitive, eg: content-type and Content-Type are
  /// regard as the same key.
  final Map<String, dynamic> headers;

  /// Timeout in milliseconds for sending data.
  /// [Dio] will throw the [DioError] with [DioErrorType.sendTimeout] type
  ///  when time out.
  final int? connectTimeout;

  ///  Timeout in milliseconds for receiving data.
  ///
  ///  Note: [receiveTimeout]  represents a timeout during data transfer! That is to say the
  ///  client has connected to the server, and the server starts to send data to the client.
  ///
  /// [0] meanings no timeout limit.
  final int? receiveTimeout;

  ///  Timeout in milliseconds for sending.
  final int? sendTimeout;

  /// Auto append slash at the end of all urls
  final bool appendSlashToUrl;

  final dio.InterceptorsWrapper? requestsInterceptor;

  FluApiSettings(
      {required this.baseUrl,
      this.connectTimeout,
      this.receiveTimeout,
      this.sendTimeout,
      this.appendSlashToUrl = false,
      this.responseType = dio.ResponseType.json,
      this.headers = const {
        'Content-Type': 'application/json',
      },
      this.requestsInterceptor});

  dio.BaseOptions get options => dio.BaseOptions(
      baseUrl: baseUrl,
      responseType: responseType,
      connectTimeout: connectTimeout ?? FluSettings.httpConnectTimeout,
      receiveTimeout: receiveTimeout ?? FluSettings.httpReceiveTimeout,
      sendTimeout: sendTimeout ?? FluSettings.httpSendTimeout,
      headers: headers);
}

class _FluConnect {
  late dio.Dio dioInstance;
  final FluApiSettings settings;

  _FluConnect({required this.settings}) {
    dioInstance = _createDio();
  }

  dio.Dio _createDio() {
    dio.Dio inst = dio.Dio(settings.options);

    if (settings.requestsInterceptor != null) {
      inst.interceptors.add(settings.requestsInterceptor!);
    }

    return inst;
  }

  String _buildUrl(String endpoint) =>
      endpoint + (settings.appendSlashToUrl ? '/' : '');

  /// Handy method to make http GET request
  Future<dio.Response> get(String endpoint,
      {Map<String, dynamic>? parameters,
      dio.Options? options,
      dio.CancelToken? cancelToken,
      void Function(int, int)? onReceiveProgress}) async {
    try {
      dio.Response response = await dioInstance.get(_buildUrl(endpoint),
          queryParameters: parameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response;
    } on dio.DioError catch (e) {
      return Future.error(e);
    }
  }

  /// Handy method to make http POST request
  Future<dio.Response> post(String endpoint, dynamic data,
      {Map<String, dynamic>? parameters,
      dio.Options? options,
      dio.CancelToken? cancelToken,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress}) async {
    try {
      dio.Response response = await dioInstance.post(_buildUrl(endpoint),
          data: data,
          queryParameters: parameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response;
    } on dio.DioError catch (e) {
      return Future.error(e);
    }
  }

  /// Handy method to make http PUT request
  Future<dio.Response> put(String endpoint, dynamic data,
      {Map<String, dynamic>? parameters,
      dio.Options? options,
      dio.CancelToken? cancelToken,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress}) async {
    try {
      dio.Response response = await dioInstance.put(_buildUrl(endpoint),
          data: data,
          queryParameters: parameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response;
    } on dio.DioError catch (e) {
      return Future.error(e);
    }
  }

  /// Handy method to make http DELETE request
  Future<dio.Response> delete(String endpoint,
      {Map<String, dynamic>? parameters,
      dio.Options? options,
      dio.CancelToken? cancelToken}) async {
    try {
      dio.Response response = await dioInstance.delete(_buildUrl(endpoint),
          queryParameters: parameters, options: options, cancelToken: cancelToken);
      return response;
    } on dio.DioError catch (e) {
      return Future.error(e);
    }
  }
}
