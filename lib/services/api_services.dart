import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final ApiServicesProvider = ChangeNotifierProvider((ref) => ApiServices());
final blogProvider = FutureProvider((ref) async {
  return ref.read(ApiServicesProvider).getData();
});

class ApiServices extends ChangeNotifier {
  Future getData() async {
    try {
      //*Persistencia con HiveStore
      final HttpLink httpLink = HttpLink(dotenv.env["API_URI"] ?? "API_URI");
      final AuthLink authLink = AuthLink(
          getToken: () async =>
              "Bearer ${dotenv.env["AUTH_LINK"] ?? "AUTH_LINK"}");
      final Link link = authLink.concat(httpLink);

      GraphQLClient client = GraphQLClient(
        link: link,
        // The default store is the InMemoryStore, which does NOT persist to disk
        cache: GraphQLCache(),
      );

      QueryResult queryResult = await client.query(
        QueryOptions(document: gql("""
                        query AllBlock {
              allBlogs {
                titulo
                contenido
                imagen {
                  url
                }
              }
            }
   """)),
      );

      print(queryResult.data!["allBlogs"]);
      return queryResult.data!["allBlogs"];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    notifyListeners();
  }
}
