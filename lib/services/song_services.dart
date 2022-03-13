import 'package:duqin/http/http.dart';

class SongService {
  static const String rootPath = '/v1/song';
  static const String listPath = '$rootPath/list';
  static const String infoPath = '$rootPath/info';

  // 列表数据
  static Future getSongs({int page = 1, int limit = 10}) async {
    final response =
        await Http.get(listPath, params: {'page': page, 'limit': limit});
    Map<String, dynamic> result = response['page'];
    return result;
  }
}
