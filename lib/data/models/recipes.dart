import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'recipes.g.dart';

Recipes recipesFromJson(String str) => Recipes.fromJson(json.decode(str));

String recipesToJson(Recipes data) => json.encode(data.toJson());

@JsonSerializable()
class Recipes {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "imageType")
  String? imageType;
  @JsonKey(name: "servings")
  int? servings;
  @JsonKey(name: "readyInMinutes")
  int? readyInMinutes;
  @JsonKey(name: "summary")
  String? summary;
  @JsonKey(name: "dishTypes")
  List<String>? dishTypes;
  @JsonKey(name: "analyzedInstructions")
  List<dynamic>? analyzedInstructions;
  @JsonKey(name: "instructions")
  String? instructions;

  Recipes({
    required this.id,
    required this.title,
    required this.image,
    required this.imageType,
    required this.servings,
    required this.readyInMinutes,
    required this.summary,
    required this.dishTypes,
    required this.analyzedInstructions,
    required this.instructions,
  });

  factory Recipes.fromJson(Map<String, dynamic> json) => _$RecipesFromJson(json);

  Map<String, dynamic> toJson() => _$RecipesToJson(this);
}
