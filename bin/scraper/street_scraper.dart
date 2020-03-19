import 'dart:convert';

import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import '../pcurl.dart';

class StreetScraper {
  final String query;

  StreetScraper(this.query);

  Future<String> getStreetJson() async {

    var encoded_street_name = Uri.encodeQueryComponent(
      Uri.decodeComponent(query),
      encoding: Encoding.getByName('iso-8859-1')
    );

    var url =
        'http://213.168.213.236/bremereb/bify/strasse.jsp?strasse=$encoded_street_name';

    var res = await PCurl.GET(url);
    //Use html parser
    var document = parse(res);
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
