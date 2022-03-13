import 'package:duqin/http/http.dart';

class RecommendService {
  static const String rootPath = '/v1/recommend';
  static const String listPath = '$rootPath/list';
  static const String infoPath = '$rootPath/info';

  // 列表数据
  static Future getRecommends({int page = 1, int limit = 10}) async {
    final response =
        await Http.get(listPath, params: {'page': page, 'limit': limit});
    List<dynamic> result = response['page'];
    return result;
  }
}
