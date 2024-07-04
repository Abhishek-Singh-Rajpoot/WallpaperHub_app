import 'package:flutter/material.dart';
import 'package:wallpaper/controller/apiOper.dart';
import 'package:wallpaper/model/photosModel.dart';
import 'package:wallpaper/views/widgets/appbar.dart';
import 'package:wallpaper/views/widgets/searchBar.dart';
import 'package:wallpaper/views/screens/fullscreen.dart';
import 'package:wallpaper/views//widgets/catblock.dart';

class CatagoryPage extends StatefulWidget {
  String catName;
  String catImgUrl;

  CatagoryPage({super.key, required this.catImgUrl, required this.catName});

  @override
  State<CatagoryPage> createState() => _CatagoryPageState();
}

class _CatagoryPageState extends State<CatagoryPage> {
  late List<Photosmodel> categoryResults;
  bool isLoading = true;

  GetCatRelWall() async {
    categoryResults = await Apioper.searchWallpaper(widget.catName);

    setState(() {
      isLoading = false;
    });
  }
  Future<void> _res() async {
    setState(() {
      isLoading = true;
    });
    await GetCatRelWall();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    GetCatRelWall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Appbars(),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator( onRefresh: _res,
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.network(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            widget.catImgUrl),
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black38,
                        ),
                        Positioned(
                          left: 180,
                          top: 40,
                          child: Column(
                            children: [
                              Text('Category',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300)),
                              Text(
                                widget.catName,
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
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
                          itemCount: categoryResults.length,
                          itemBuilder: ((context, index) => GridTile(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Fullscreen(
                                                imgUrl: categoryResults[index]
                                                    .imgSrc)));
                                  },
                                  child: Hero(
                                    tag: categoryResults[index].imgSrc,
                                    child: Container(
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(34),
                                          child: Image.network(
                                              fit: BoxFit.cover,
                                              categoryResults[index].imgSrc)),
                                    ),
                                  ),
                                ),
                              ))),
                    ),
                  ],
                ),
              ),
          ),
    );
  }
}
