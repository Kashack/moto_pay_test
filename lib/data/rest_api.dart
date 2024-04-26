import 'package:dio/dio.dart';

class RestApi {
  final dio = Dio();
  final String token = "9edf588451204799a1c04d2494acdd48";

  Future<Response> getRecipes({required int offset}) async {
    final res = await dio.get("https://api.spoonacular.com/recipes/complexSearch",
      queryParameters: {
        "apiKey" : token,
        "cuisine" : "American",
        "number" : 20,
        "offset" : offset,
      },
      options: Options(headers: {
        "Authorization" : "Bearer $token",
      })
    );
    return res;
  }

  Future<Response> getRecipesDetails({required int id}) async {
    final res = await dio.get(
        "https://api.spoonacular.com/recipes/$id/information",
        queryParameters: {
          "apiKey" : token,
        },
        options: Options(headers: {
          "Authorization" : "Bearer $token",
        })
    );
    return res;
  }
}
