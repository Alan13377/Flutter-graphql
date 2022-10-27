import 'package:datocms_flutter/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(ApiServicesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("BlogPost"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: FutureBuilder(
              future: model.getData(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: ((context, index) {
                       
                        final allBlogs = snapshot.data[index];
                        
                        return ListTile(
                          title: Text("${allBlogs["titulo"]}"),
                          subtitle: Text("${allBlogs["contenido"]}"),
                          trailing:
                              Image.network("${allBlogs["imagen"]["url"]}"),
                        );
                      }));
                }
                return Container();
              }))),
    );
  }
}
