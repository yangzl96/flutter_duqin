import 'package:duqin/http/http.dart';

class UserService {
  static const String rootPath = '/v1/user';
  static const String listPath = '$rootPath/list';
  static const String infoPath = '$rootPath/info';

  // 列表数据
  static Future getUsers({int page = 1, int limit = 10, String? type}) async {
    final response = await Http.get(listPath,
        params: {'page': page, 'limit': limit, 'type': type});
    Map<String, dynamic> result = response['page'];
    return result;
  }
}
