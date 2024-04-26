// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeData _$RecipeDataFromJson(Map<String, dynamic> json) => RecipeData(
      offset: (json['offset'] as num?)?.toInt(),
      number: (json['number'] as num?)?.toInt(),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Recipes.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: (json['totalResults'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RecipeDataToJson(RecipeData instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'number': instance.number,
      'results': instance.results,
      'totalResults': instance.totalResults,
    };
