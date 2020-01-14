import 'package:shelf/shelf_io.dart' as io;

import 'routes/brash_router.dart';

// For Google Cloud Run, set _hostname to '0.0.0.0'.
const _hostname = 'localhost';

void main() async {
  final service = BrashRouter();
  final server = await io.serve(service.handler, _hostname, 8080);
  print('Server running on localhost:${server.port}');
}
