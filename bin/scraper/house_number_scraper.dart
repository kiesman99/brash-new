import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:http_server/http_server.dart';

class HouseNumberScraper {
  final String street_name;

  HouseNumberScraper(this.street_name);

  Future<String> getHouseNumbers() async {

    var encoded_street_name = Uri.encodeQueryComponent(
      Uri.decodeComponent(street_name),
      encoding: Encoding.getByName('iso-8859-1')
    );

    // gro%DFe+johannisstra%DFe

    var dio = Dio(BaseOptions(
      baseUrl: 'http://213.168.213.236/bremereb/bify/hausnummer.jsp?strasse=',
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        HttpHeaders.userAgentHeader: 'dio',
        //HttpHeaders.contentTypeHeader: 'text/html;charset=ISO-8859-1'
      },
    ));

    var response = await dio.get(encoded_street_name);

    print(response.data);

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
