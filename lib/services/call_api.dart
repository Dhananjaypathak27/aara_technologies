import 'package:aara_technologies/util/constant.dart';
import 'package:http/http.dart' as http;

class CallApi{

  Future<http.Response> getCategory() async{
    http.Response response = await http.get(
        Uri.https(Constant.baseUrl, '/web/common/category'),);

    print(response.statusCode);
    print(response.body);

    return response;
  }


  Future<http.Response> getRecipes(String id) async{
    String endUrl = '/web/common/subcategory/$id';
    print('end url '+ endUrl);
    http.Response response = await http.get(
      Uri.https(Constant.baseUrl, endUrl),);

    print(response.statusCode);
    print(response.body);

    return response;
  }


}