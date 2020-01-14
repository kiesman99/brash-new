import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const url1 = 'http://213.168.213.236/bremereb/bify/strasse.jsp?strasse=Ema';
const url2 = 'http://213.168.213.236/bremereb/bify/strasse.jsp?strasse=Em';


void old() async {
  var client = HttpClient();
  final url =
      Uri.parse('http://213.168.213.236/bremereb/bify/strasse.jsp?strasse=Em');
  // var request = await client.getUrl(url);
  var response = await client.getUrl(url).then((HttpClientRequest request) {
    // request.headers.contentLength = 3040;
    request.encoding = Encoding.getByName('iso_8859-1');

    return request.close();
  });
  //request.encoding = Encoding.getByName('iso_8859-1');
  //var response = await request.close();
  print('Got response');
  print('Response length: ${response.contentLength}');
  await response.drain();
  //await response.transform(Latin1Decoder()).listen(print);
  print('Done');
  client.close();
}

void old2() async {
  var client = HttpClient();
  final url =
      Uri.parse('http://213.168.213.236/bremereb/bify/strasse.jsp?strasse=Em');
  client
      .getUrl(url)
      .then((HttpClientRequest request) {
    // Optionally set up headers...
    // Optionally write to the request object...
    // Then call close.
    //request.headers.set(HttpHeaders.contentLengthHeader, 8952);
    
    print('Length is ${request.contentLength}');
    return request.close();
  }).then((HttpClientResponse response) {

    print(response.headers);
    // Process the response.
    return response.listen((el) {
      //print(el);
    });
  });
}

void main() async {

  var res = await http.get('https://material.io/components/app-bars-bottom/#anatomy');

  // print(res.headers);

  print(res.body);

}
