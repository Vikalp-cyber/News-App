import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'News.dart';
import 'NewsModels.dart';
import 'articleview.dart';

class CategoryNews extends StatefulWidget {
  final String? Categories;
  const CategoryNews({Key? key, this.Categories}) : super(key: key);

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<Article> articles = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  Future<void> getCategoryNews() async {
    try {
      CategoryNewsClass newsclass = CategoryNewsClass();
      await newsclass.getNews(widget.Categories!);
      articles = newsclass.news;
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
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
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          ),
        ],
        elevation: 0,
        centerTitle: true,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(top: 16),
                    child: RefreshIndicator(
                      onRefresh: getCategoryNews,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            try {
                              return BlogTile(
                                imgurl: articles[index].urlToImage,
                                title: articles[index].title,
                                des: articles[index].description,
                                url: articles[index].articleUrl,
                              );
                            } catch (e) {
                              print(e);
                              return Container();
                            }
                          }),
                    ),
                  )
                ]),
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
