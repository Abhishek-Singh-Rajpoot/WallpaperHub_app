import 'package:flutter/material.dart';
import 'package:wallpaper/controller/apiOper.dart';
import 'package:wallpaper/views/screens/fullscreen.dart';
import 'package:wallpaper/views/widgets/appbar.dart';
import 'package:wallpaper/views/widgets/searchBar.dart';
import 'package:wallpaper/views//widgets/catblock.dart';
import 'package:wallpaper/model/photosModel.dart';
import '../../model/categoryModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Photosmodel> trandingWallLsit;

  late List<CategoryModel> CatModList = [];
  bool isLoading = true;

  GetCatDetails() async {
    CatModList = await Apioper.getCategoriesList();
    print("GETTTING CAT MOD LIST");
    print(CatModList);
    setState(() {
      CatModList = CatModList;
    });
  }

  //  this method is for the refresh screen
  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
    });
    await GetCatDetails();
    await GetTrandingWallper();
    setState(() {
      isLoading = false;
    });
  }

  GetTrandingWallper() async {
    trandingWallLsit = await Apioper.getTrandingWallpapers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    GetTrandingWallper();
    GetCatDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Appbars(),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      // the isLoading is use for the process indicator
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _refreshData,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Searchbar()),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 21),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 49,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: CatModList.length,
                            itemBuilder: ((context, index) => catagoriacal(
                                  categoryImgSrc: CatModList[index].catImgUrl,
                                  categoryName: CatModList[index].catName,
                                ))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      // height: MediaQuery.of(context).size.height,
                      height: 700,
                      child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 13,
                            mainAxisSpacing: 13,
                            mainAxisExtent: 400,
                          ),
                          itemCount: trandingWallLsit.length,
                          itemBuilder: ((context, index) => GridTile(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Fullscreen(
                                                imgUrl: trandingWallLsit[index]
                                                    .imgSrc)));
                                  },
                                  child: Hero(
                                    tag: trandingWallLsit[index].imgSrc,
                                    child: Container(
                                      height: 800,
                                      width: 50,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(34),
                                          child: Image.network(
                                              fit: BoxFit.cover,
                                              trandingWallLsit[index].imgSrc)),
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
