import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'api_router.dart';

class BrashRouter {

  Handler get handler {
    final router = Router();

    router.get('/', (Request req) {
      return Response.ok('Das ist brashapp');
    });

    router.mount('/api/', Api().router);

    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Page not found');
    });

    return router.handler;
  }

}