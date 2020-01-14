import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../scraper/house_number_scraper.dart';
import '../scraper/street_scraper.dart';

class Api {

  Router get router {
    final router = Router();

    // Route to get all trashEntries
    router.get('/trashEntries/<streetname>/<housenumber>', (Request req) {
      var street_name = params(req, 'streetname');
      var house_number = params(req, 'housenumber');
      var  jsonString = '{ "streetname": "$street_name", "house_number": "$house_number" }';
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      return Response.ok(json.encode(jsonMap), headers: {
        'content-type': 'text/plain'
      });
    });

    router.get('/streets/<query>', (Request req, String query) async {
      final scraper = StreetScraper(query);
      var res = await scraper.getStreetJson();
      return Response.ok(res, encoding: Encoding.getByName('utf-8'), headers: {
        'content-type': 'text/plain'
      });
    });

    router.get('/houseNumbers/<street_name>', (Request req, String street_name) async {
      final scraper = HouseNumberScraper(street_name);
      final res = await scraper.getHouseNumbers();
      return Response.ok(res, encoding: Encoding.getByName('utf-8'), headers: {
        'content-type': 'text/plain'
      });
    });

    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Page not found');
    });

    return router;
  }

}