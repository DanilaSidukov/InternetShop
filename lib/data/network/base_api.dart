import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:internet_shop/data/network/utils/response.dart';

abstract base class BaseApi {
  static final String _baseUrl = 'http://onlinestore.whitetigersoft.ru/api/';

  Map<String, String> get _defaultParams => {
    'accessToken': dotenv.env['TOKEN']!,
    'appKey': dotenv.env['APPKEY']!
  };

  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    final stringParams = params?.map<String, String>(
          (key, value) => MapEntry(key, value.toString()),
    ) ?? {};

    final mergedParams = {
      ..._defaultParams,
      ...stringParams
    };
    final uri = Uri.parse('$_baseUrl$endpoint').replace(queryParameters: mergedParams);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return Success(response.body);
    } else {
      return Error('Server error: ${response.statusCode}');
    }
  }
}
