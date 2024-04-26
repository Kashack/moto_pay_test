part of 'reciepe_details_bloc.dart';

enum DetailsStatus { initial, loading, success, failed }

final class RecipeDetailsState extends Equatable {
  final DetailsStatus recipeStatus;
  final Recipes? recipes;
  final int? id;

  const RecipeDetailsState({
    this.recipeStatus = DetailsStatus.initial,
    this.recipes,
    this.id
  });

  RecipeDetailsState copyWith({
    DetailsStatus? recipeStatus,
    Recipes? recipes,
    int? id,
  }) =>
      RecipeDetailsState(
        recipes: recipes ?? this.recipes,
        recipeStatus: recipeStatus ?? this.recipeStatus,
        id: id ?? this.id,
      );

  @override
  List<Object?> get props => [recipes, recipeStatus,id];
}
