import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:moto_pay_test/data/models/recipe_data.dart';
import 'package:moto_pay_test/data/models/recipes.dart';
import 'package:moto_pay_test/data/rest_api.dart';

part 'pagination_event.dart';

part 'pagination_state.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  final _api = RestApi();
  List<Recipes> recipes = [];

  PaginationBloc() : super(const PaginationState()) {
    on<RecipeFetched>((event, emit) async {
      if (state.hasReachedMax) return;
      try {
        recipes = state.recipes ?? [];
        final res = await _api.getRecipes(offset: event.pageKey);
        if (res.statusCode == 200) {
          final recipesData = RecipeData.fromJson(res.data);
          recipes.addAll(recipesData.results!);
          if (recipesData.results!.isEmpty) {
            emit(state.copyWith(hasReachedMax: true));
          } else {
            emit(state.copyWith(
                paginationStatus: PaginationStatus.success,
                recipes: recipes,
                pageKey: event.pageKey + recipes.length,
                recipeData: recipesData));
          }
        } else {
          throw Exception("Error in fetching Recipe");
        }
      } on DioException catch (e) {
        if (kDebugMode) {
          print(e.response);
          print(e.message);
        }
        if (DioExceptionType.connectionError ==
            DioExceptionType.connectionError) {
          emit(state.copyWith(
            paginationStatus: PaginationStatus.failure,
            errorMessage: "Internet connection error",
          ));
        }
      } catch (e) {
        if (kDebugMode) {
          print("runtimeType error");
          print(e);
          print(e.runtimeType);
        }
        if (e.runtimeType == SocketException) {
          emit(state.copyWith(
            paginationStatus: PaginationStatus.failure,
            errorMessage: "Internet connection error",
          ));
        }
        emit(state.copyWith(
          paginationStatus: PaginationStatus.failure,
        ));
      }
    });
  }
}
