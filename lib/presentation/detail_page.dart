import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moto_pay_test/business/recipe_details/reciepe_details_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Recipe Details",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            color: Colors.white,
          ), onPressed: () {
            Navigator.pop(context);
        },
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      extendBodyBehindAppBar: true,
      body: BlocConsumer<RecipeDetailsBloc, RecipeDetailsState>(
        listener: (context, state) {
          if (state.recipeStatus == DetailsStatus.failed) {
            displaySnackBar(message: "Connection Failed", id: state.id!);
          }
        },
        builder: (context, state) {
          if (state.recipeStatus == DetailsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.recipeStatus == DetailsStatus.success) {
            return Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                          imageUrl: state.recipes!.image ?? "",
                          fit: BoxFit.fill,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.grey,
                            child: Container(
                              decoration: const ShapeDecoration(
                                color: Colors.grey,
                                shape: RoundedRectangleBorder(),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
                        ),
                      ),
                      Text(
                        state.recipes!.title!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: HtmlWidget(
                              state.recipes!.summary!,
                            ),
                          ),
                          Text("Instructions", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          HtmlWidget(
                            state.recipes!.instructions!,

                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<RecipeDetailsBloc>()
                  .add(RecipeDetailsFetched(id: state.id!));
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
      ),
    );
  }

  void displaySnackBar({required String message, required int id}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          "Internet connection failed",
          style: TextStyle(color: Colors.white),
        ),
        action: SnackBarAction(
          label: "Retry",
          onPressed: () {
            context.read<RecipeDetailsBloc>().add(RecipeDetailsFetched(id: id));
          },
        ),
      ),
    );
  }
}
