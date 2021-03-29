import 'package:demo/model/news.dart';
import 'package:http/http.dart';
import 'dart:convert';

String apiKey = '0fb096f19f09469b931adc46bb3398f0';

Future<List<News>> getFeed(String category, {String language = 'en'}) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  Response response;
  try {
    response = await get(
        "https://newsapi.org/v2/sources?apiKey=" +
            apiKey +
            "&category=" +
            category +
            "&language=" +
            language,
        headers: headers);

    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);

      List<dynamic> ress = body['sources'];

      List<News> news = ress.map((dynamic x) => News.fromJson(x)).toList();

      if (ress.length == 0) {
        throw 'Could not retrieve news items';
      }

      return news;
    } else {
      throw 'Could not retrieve news items';
    }
  } catch (err) {
    throw err.toString();
  }
}
