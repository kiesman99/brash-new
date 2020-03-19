import 'dart:convert';
import 'package:html/parser.dart';

import '../pcurl.dart';

class HouseNumberScraper {
  final String street_name;

  HouseNumberScraper(this.street_name);

  Future<String> getHouseNumbers() async {

    var encoded_street_name = Uri.encodeQueryComponent(
      Uri.decodeComponent(street_name),
      encoding: Encoding.getByName('iso-8859-1')
    );

    var url = 'http://213.168.213.236/bremereb/bify/hausnummer.jsp?strasse=$encoded_street_name';

    var response = await PCurl.GET(url);

    //Use html parser
    var document = parse(response);
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
