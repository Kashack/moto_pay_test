part of 'pagination_bloc.dart';

enum PaginationStatus { initial, loading, success, failure }

final class PaginationState extends Equatable {
  final PaginationStatus paginationStatus;
  final bool hasReachedMax;
  final RecipeData? recipeData;
  final List<Recipes>? recipes;
  final int pageKey;

  const PaginationState({
    this.paginationStatus = PaginationStatus.initial,
    this.hasReachedMax = false,
    this.recipeData,
    this.recipes,
    this.pageKey = 0,
  });

  PaginationState copyWith({
    PaginationStatus? paginationStatus,
    bool? hasReachedMax,
    RecipeData? recipeData,
    List<Recipes>? recipes,
    int? pageKey,
  }) =>
      PaginationState(
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        paginationStatus: paginationStatus ?? this.paginationStatus,
        recipeData: recipeData ?? this.recipeData,
        recipes: recipes ?? this.recipes,
        pageKey: pageKey ?? this.pageKey
      );

  @override
  List<Object?> get props => [paginationStatus, hasReachedMax, recipeData,recipes,pageKey];

}

