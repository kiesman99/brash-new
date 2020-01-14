import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:http_server/http_server.dart';

class StreetScraper {
  final String query;

  StreetScraper(this.query);

  Future<String> getStreetJson() async {
    var url =
        'http://213.168.213.236/bremereb/bify/strasse.jsp?strasse=' + query;

    var dio = Dio(BaseOptions(
      baseUrl: 'http://213.168.213.236/bremereb/bify/strasse.jsp?strasse=',
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        HttpHeaders.userAgentHeader: 'dio',
        //HttpHeaders.contentTypeHeader: 'text/html;charset=ISO-8859-1'
      },
    ));

    var response = await dio.get(query);

    //Use html parser
    var document = parse(response.data, encoding: 'iso-8859-1');
    var links = document.querySelectorAll('td[id] > a');
    var linkMap = [];

    for (var link in links) {
      linkMap.add({
        'title': link.text,
        'href': link.attributes['href'],
      });
    }

    return json.encode(linkMap);
  }
}
