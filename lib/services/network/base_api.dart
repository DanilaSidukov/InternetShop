import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

abstract class BaseApi {
  static final String _baseUrl = 'http://onlinestore.whitetigersoft.ru/api/';

  Map<String, String> get _defaultParams => {
    'accessToken': dotenv.env['TOKEN']!,
    'appKey': dotenv.env['APPKEY']!
  };

  Future<http.Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    final stringParams = params?.map<String, String>(
          (key, value) => MapEntry(key, value.toString()),
    ) ?? {};

    final mergedParams = {
      ..._defaultParams,
      ...stringParams
    };
    final uri = Uri.parse('$_baseUrl$endpoint').replace(queryParameters: mergedParams);
    return await http.get(uri);
  }
}
