import 'package:moto_pay_test/data/models/recipes.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe_data.g.dart';

@JsonSerializable()
class RecipeData {
  final int? offset;
  final int? number;
  final List<Recipes>? results;
  final int? totalResults;

  RecipeData(
      { this.offset,
       this.number,
       this.results,
       this.totalResults,
      });

  factory RecipeData.fromJson(Map<String, dynamic> json) => _$RecipeDataFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeDataToJson(this);
}
