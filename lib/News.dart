import 'dart:convert';

import 'package:flutternews/NewsModels.dart';
import 'package:http/http.dart' as http;

class News {
  List<Article> news = [];
  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=ed595439edfb49b7906b43be099e3397";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          Article article = Article(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              urlToImage: element['urlToImage'],
              articleUrl: element['url'],
              
              content: element['content']);
          news.add(article);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<Article> news = [];
  Future<void> getNews(String Cate) async {
    String url =
        "https://newsapi.org/v2/everything?q=$Cate&from=2022-06-21&sortBy=publishedAt&apiKey=ed595439edfb49b7906b43be099e3397";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          Article article = Article(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              urlToImage: element['urlToImage'],
              articleUrl: element['url'],
              
              content: element['content']);
          news.add(article);
        }
      });
    }
  }
}
