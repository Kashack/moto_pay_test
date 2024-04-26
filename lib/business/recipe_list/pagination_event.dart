part of 'pagination_bloc.dart';

@immutable
sealed class PaginationEvent {}

final class RecipeFetched extends PaginationEvent {
  final int pageKey;

  RecipeFetched({required this.pageKey});
}
