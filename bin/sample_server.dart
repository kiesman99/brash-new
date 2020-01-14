// For Google Cloud Run, set _hostname to '0.0.0.0'.
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as io;

const _hostname = 'localhost';

class SampleRouter {
  Handler get handler {
    final router = Router();

    router.get('/one', (Request req) async {
      final url =
          'http://213.168.213.236/bremereb/bify/strasse.jsp?strasse=Ema';
      var res = await http.Client().get(url);
      return Response.ok(res.body,
          headers: {HttpHeaders.contentTypeHeader: 'text/plain'});
    });

    router.get('/two', (Request req) async {
      final url = 'http://213.168.213.236/bremereb/bify/strasse.jsp?strasse=Em';
      var res = await http.Client().get(url);
      return Response.ok(res.body,
          headers: {HttpHeaders.contentTypeHeader: 'text/plain'});
    });

    return router.handler;
  }
}

void main() async {
  final service = SampleRouter();
  final server = await io.serve(service.handler, _hostname, 8080);
  print('Server running on localhost:${server.port}');
}
