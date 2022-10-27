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
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  title: Text(
                    data[index]["titulo"],
                  ),
                  subtitle: Text(
                    data[index]["contenido"],
                  ),
                  trailing: Image.network(
                    "${data[index]["imagen"]["url"]}",
                  ),
                );
              }),
            );
          },
          error: (err, s) => Text(err.toString()),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
