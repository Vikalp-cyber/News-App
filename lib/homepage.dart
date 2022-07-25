import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutternews/Categories.dart';
import 'package:flutternews/Categorymodels.dart';
import 'package:flutternews/News.dart';
import 'package:flutternews/NewsModels.dart';
import 'package:flutternews/articleview.dart';
import 'package:flutternews/data.dart';
import 'package:flutternews/search.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CategoryModel> categories = [];
  List<Article> articles = [];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategory();
    getNews();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  Future<void> getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Flutter",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Search()));
            },
            icon: Icon(
              Icons.search,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Category(
                              imageurl: categories[index].imageurl,
                              categoryname: categories[index].categoryName,
                            );
                          }),
                    ),
                    const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Text(
                        "Latest News",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: RefreshIndicator(
                        onRefresh: getNews,
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: articles.length,
                            itemBuilder: (context, index) {
                              return BlogTile(
                                imgurl: articles[index].urlToImage,
                                title: articles[index].title,
                                des: articles[index].description,
                                url: articles[index].articleUrl,
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class Category extends StatelessWidget {
  final imageurl, categoryname;
  const Category({Key? key, this.imageurl, this.categoryname})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryNews(
              Categories: categoryname,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 16, left: 5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imageurl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              child: Center(
                child: Text(
                  categoryname,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String? imgurl, title, des, url;
  const BlogTile({@required this.imgurl, this.title, this.des, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      url: url,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imgurl!),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              title!,
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              des!,
              style: TextStyle(color: Colors.black45),
            )
          ],
        ),
      ),
    );
  }
}
