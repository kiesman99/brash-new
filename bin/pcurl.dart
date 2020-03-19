import 'dart:convert';
import 'dart:io';


class PCurl {

  static Future<String> GET(final String url) async {

    var res = Process.start('curl', [url]);
    return await res.then((value) {
      return value.stdout.transform(Latin1Decoder()).join();
    });
  }

}