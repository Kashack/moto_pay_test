import 'package:dio/dio.dart';

class RestApi {
  final dio = Dio();
  final String token = "9edf588451204799a1c04d2494acdd48";

  ///Get Recipes from server
  Future<Response> getRecipes({required int offset}) async {
    final res = await dio.get("https://api.spoonacular.com/recipes/complexSearch",
      queryParameters: {
        "apiKey" : token,
        "cuisine" : "American",
        "number" : 15,
        "offset" : offset,
      },
      options: Options(headers: {
        "Authorization" : "Bearer $token",
      })
    );
    return res;
  }

  ///Get recipe detail from server
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
