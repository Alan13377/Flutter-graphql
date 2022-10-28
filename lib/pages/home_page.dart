import 'package:datocms_flutter/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(ApiServicesProvider);
    final data = ref.watch(blogProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text("BlogPost"),
        ),
        body: data.when(
          data: (blogs) {
            return RefreshIndicator(
              onRefresh: () async {
                ref.refresh(blogProvider);
              },
              child: ListView.builder(
                itemCount: blogs!.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text(
                      blogs[index]["titulo"],
                    ),
                    subtitle: Text(
                      blogs[index]["contenido"],
                    ),
                    trailing: Image.network(
                      "${blogs[index]["imagen"]["url"]}",
                    ),
                  );
                }),
              ),
            );
          },
          error: (err, s) => Text(err.toString()),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
