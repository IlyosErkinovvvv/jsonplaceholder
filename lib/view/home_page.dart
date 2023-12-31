import 'package:flutter/material.dart';
import 'package:jsonplaceholder/core/widgets/home_loading_widget.dart';
import 'package:jsonplaceholder/data/model/comments_model.dart';
import 'package:jsonplaceholder/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Home Page")),
          body: Builder(
            builder: (context) {
              if (context.watch<HomeProvider>().isLoading) {
                return const ShimmerLoading();
              } else if (context.watch<HomeProvider>().error.isNotEmpty) {
                return Center(
                  child: Text(context.watch<HomeProvider>().error),
                );
              } else {
                List<CommentsModel> data = context.watch<HomeProvider>().data!;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(data[index].email.toString()),
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
