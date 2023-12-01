import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/entities/favorite_item.dart';
import 'package:shop_app/presentation/bloc/saved_bloc.dart';
import 'package:shop_app/presentation/widgets/sizer.dart';
import 'package:intl/intl.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  var money = NumberFormat.currency(
      customPattern: "#,##0.00", locale: "th_TH", symbol: "");
  @override
  Widget build(BuildContext context) {
    context.read<SavedBloc>().add(const OnLoadSaved());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Saved",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: Sizer(context).h,
        width: Sizer(context).w,
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  context.read<SavedBloc>().add(const OnRemoveAllSaved());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                      Text(
                        "Remove all",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              BlocBuilder<SavedBloc, SavedState>(
                builder: (context, state) {
                  if (state is SavedInitial) {
                    context.read<SavedBloc>().add(const OnLoadSaved());
                  } else if (state is SavedLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SavedLoaded) {
                    return itemListInSaved(state.result);
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemListInSaved(List<FavoriteItemEntity> result) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: result.length,
      itemBuilder: (context, index) {
        FavoriteItemEntity only = result[index];
        return GestureDetector(
          onTap: () {
            // var route =
            //     MaterialPageRoute(builder: (context) => ProductPage(only));
            // Navigator.push(context, route).then((value) {
            //   con.init();
            // });
          },
          child: ClipRect(
            child: Slidable(
              key: ValueKey(index),
              endActionPane: ActionPane(
                extentRatio: 0.2,
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      context.read<SavedBloc>().add(OnRemoveSaved(only));
                    },
                    backgroundColor: Colors.red,
                    icon: Icons.delete_outline,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  only.product.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(
                                        Icons.image_not_supported_outlined,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                only.product.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                "\$${money.format(only.product.price)} ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Container(
                        //   height: 40,
                        //   width: 40,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //     border: Border.all(
                        //       color: Colors.grey,
                        //     ),
                        //     shape: BoxShape.circle,
                        //   ),
                        //   child: Text(
                        //     "${con.getQuatity(only.product.id!)}",
                        //     style: const TextStyle(fontSize: 15),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
