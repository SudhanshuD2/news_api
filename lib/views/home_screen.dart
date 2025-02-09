import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/model/article.dart';
import 'package:news_api/service/news_service.dart';
import 'package:news_api/views/description_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final NewsService _newsServices  =NewsService();
  List<Article> articles = [];
  bool isLoading = false;

  @override
  void initState(){
    _loadNews();
    super.initState();
  }

  Future<void> _loadNews() async{
    try{
      isLoading = true;
      final news = await _newsServices.getNews();
      isLoading = false;
      setState((){
        articles=news;
      });
    }catch(e){
      log('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        elevation: 5,
        shadowColor: Colors.black,
        title: Text(
          'Attento News',
          style: GoogleFonts.newsCycle(
            fontSize: 24, fontWeight: FontWeight.w700,
            color: Colors.black
          )
        ),
        centerTitle: true,
      ),
      body:isLoading ? CircularProgressIndicator() : ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=> DescriptionScreen(
                    title: articles[index].title,
                    description: articles[index].description,
                    content: articles[index].content,
                    author: articles[index].author,
                    sourse: articles[index].sourceName,
                    image: articles[index].urlToImage
                  )
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 170,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        articles[index].publishedTime,
                        style: GoogleFonts.inter(
                          fontSize: 12, color: Colors.black
                        ),
                        overflow: TextOverflow.fade,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          articles[index].title,
                          style: GoogleFonts.inter(
                            fontSize: 15, color: Colors.black,
                            fontWeight: FontWeight.w700
                          ), 
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      TextButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[400],
                          fixedSize: Size(110, 8),
                        ),
                        child: Text(
                          articles[index].author,
                          style: GoogleFonts.inter(
                            fontSize: 12, color: Colors.black
                          ),
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.3,
                    width: MediaQuery.of(context).size.width * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.grey[500],
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: articles[index].urlToImage.isNotEmpty ? 
                      Image.network(
                        articles[index].urlToImage,
                        fit: BoxFit.cover
                      ) : 
                      
                      Icon(Icons.image_not_supported, size: 65,
                      color: Color.fromRGBO(0,0,0,0.5),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      );
  }
}