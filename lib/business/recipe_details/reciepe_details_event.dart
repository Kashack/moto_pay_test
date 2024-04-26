part of 'reciepe_details_bloc.dart';

@immutable
sealed class RecipeDetailsEvent {}

final class RecipeDetailsFetched extends RecipeDetailsEvent {
  final int id;

  RecipeDetailsFetched({required this.id});
}
