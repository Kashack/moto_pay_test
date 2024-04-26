part of 'pagination_bloc.dart';

enum PaginationStatus { initial, loading, success, failure }

final class PaginationState extends Equatable {
  final PaginationStatus paginationStatus;
  final bool hasReachedMax;
  final RecipeData? recipeData;
  final List<Recipes>? recipes;
  final int pageKey;
  final String? errorMessage;

  const PaginationState(
      {this.paginationStatus = PaginationStatus.initial,
      this.hasReachedMax = false,
      this.recipeData,
      this.recipes,
      this.pageKey = 0,
      this.errorMessage});

  PaginationState copyWith({
    PaginationStatus? paginationStatus,
    bool? hasReachedMax,
    RecipeData? recipeData,
    List<Recipes>? recipes,
    int? pageKey,
    String? errorMessage,
  }) =>
      PaginationState(
          hasReachedMax: hasReachedMax ?? this.hasReachedMax,
          paginationStatus: paginationStatus ?? this.paginationStatus,
          recipeData: recipeData ?? this.recipeData,
          recipes: recipes ?? this.recipes,
          pageKey: pageKey ?? this.pageKey,
          errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object?> get props => [
        paginationStatus,
        hasReachedMax,
        recipeData,
        recipes,
        pageKey,
        errorMessage
      ];
}
