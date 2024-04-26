// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipes _$RecipesFromJson(Map<String, dynamic> json) => Recipes(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      image: json['image'] as String?,
      imageType: json['imageType'] as String?,
      servings: (json['servings'] as num?)?.toInt(),
      readyInMinutes: (json['readyInMinutes'] as num?)?.toInt(),
      summary: json['summary'] as String?,
      dishTypes: (json['dishTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      analyzedInstructions: json['analyzedInstructions'] as List<dynamic>?,
      instructions: json['instructions'] as String?,
    );

Map<String, dynamic> _$RecipesToJson(Recipes instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'imageType': instance.imageType,
      'servings': instance.servings,
      'readyInMinutes': instance.readyInMinutes,
      'summary': instance.summary,
      'dishTypes': instance.dishTypes,
      'analyzedInstructions': instance.analyzedInstructions,
      'instructions': instance.instructions,
    };
