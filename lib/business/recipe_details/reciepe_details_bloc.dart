import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:moto_pay_test/data/models/recipes.dart';

import '../../data/rest_api.dart';

part 'reciepe_details_event.dart';
part 'reciepe_details_state.dart';

class RecipeDetailsBloc extends Bloc<RecipeDetailsEvent, RecipeDetailsState> {
  final _api = RestApi();

  RecipeDetailsBloc() : super(const RecipeDetailsState()) {
    on<RecipeDetailsFetched>((event, emit) async {
      emit(state.copyWith(
          recipeStatus: DetailsStatus.loading,
      ));
      try{
        final res = await _api.getRecipesDetails(id: event.id);
        if (res.statusCode == 200) {
          final recipesData = Recipes.fromJson(res.data);
          if (kDebugMode) {
            print(recipesData.toJson());
          }
          emit(state.copyWith(
            recipeStatus: DetailsStatus.success,
            recipes: recipesData,
            id: event.id
          ));
        } else {
          throw Exception("Error in fetching Recipe");
        }
      } on DioException catch (e) {
        if (kDebugMode) {
          print("runtimeType");
          print(e.message);
          print(e.error);
          print(e.type);
          print(e.response);
        }
        state.copyWith(recipeStatus: DetailsStatus.failed,id: event.id);
      } catch (e) {
        if (kDebugMode) {
          print("runtimeType error");
          print(e);
          print(e.runtimeType);
        }
        state.copyWith(recipeStatus: DetailsStatus.failed,id: event.id);
      }
    });
  }
}
