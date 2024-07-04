import 'package:flutter/material.dart';
import 'package:wallpaper/controller/apiOper.dart';
import 'package:wallpaper/model/photosModel.dart';
import 'package:wallpaper/views/widgets/appbar.dart';
import 'package:wallpaper/views/widgets/searchBar.dart';
import 'package:wallpaper/views//widgets/catblock.dart';

import 'fullscreen.dart';

class SearchPage extends StatefulWidget {
  String query;

  SearchPage({super.key, required this.query});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<Photosmodel> searchResults;

  bool isLoading = true;

  GetSearchResult() async {
    searchResults = await Apioper.searchWallpaper(widget.query);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    GetSearchResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Appbars(),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 19),
                      child: Searchbar()),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 13,
                          mainAxisSpacing: 13,
                          mainAxisExtent: 400,
                        ),
                        itemCount: searchResults.length,
                        itemBuilder: ((context, index) => GridTile(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Fullscreen(
                                              imgUrl: searchResults[index]
                                                  .imgSrc)));
                                },
                                child: Hero(
                                  tag: searchResults[index].imgSrc,
                                  child: Container(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(34),
                                        child: Image.network(
                                            height: 800,
                                            width: 50,
                                            fit: BoxFit.cover,
                                            searchResults[index].imgSrc)),
                                  ),
                                ),
                              ),
                            ))),
                  ),
                ],
              ),
            ),
    );
  }
}
