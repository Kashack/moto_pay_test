import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:moto_pay_test/business/recipe_details/reciepe_details_bloc.dart';
import 'package:moto_pay_test/business/recipe_list/pagination_bloc.dart';
import 'package:moto_pay_test/data/models/recipes.dart';
import 'package:moto_pay_test/presentation/detail_page.dart';
import 'package:shimmer/shimmer.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final PagingController<int, Recipes> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      Future.delayed(const Duration(seconds: 3),(){
        context.read<PaginationBloc>().add(RecipeFetched(pageKey: pageKey));
      },);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaginationBloc, PaginationState>(
      listener: (context, state) {
        if (state.paginationStatus == PaginationStatus.success) {
          if (state.recipes!.length >= state.recipeData!.totalResults! || state.hasReachedMax) {
            _pagingController.appendLastPage(state.recipeData!.results!);
          } else {
            _pagingController.appendPage(state.recipeData!.results!, state.pageKey);
          }
        } else if (state.paginationStatus == PaginationStatus.failure) {
          print("Failure");
          _pagingController.error = "Fail to load";
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Food Recipes"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PagedListView<int, Recipes>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Recipes>(
                itemBuilder: (context, item, index) {
              return Material(
                elevation: 3,
                color: Colors.white,
                child: ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: item.image ?? "",
                    width: 80,
                    height: 80,
                    fit: BoxFit.fill,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: ShapeDecoration(
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  contentPadding: EdgeInsets.all(4),
                  title: Text(item.title!),
                  onTap: () {
                    context.read<RecipeDetailsBloc>().add(RecipeDetailsFetched(id: item.id!));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetailsPage(),
                        ));
                  },
                ),
              );
            },
              noMoreItemsIndicatorBuilder: (context) => Center(
                child: Text("No Item to Load"),
              ),
              firstPageErrorIndicatorBuilder: (context) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<PaginationBloc>().add(RecipeFetched(pageKey: 0));
                  },
                  child: const SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                        ),
                        Text(
                          "Error Occurred\n Swipe to refresh",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              noItemsFoundIndicatorBuilder: (context) {
                return Center(
                  child: Text("No Reciepe Found"),
                );
              },

            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
