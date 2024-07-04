import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:wallpaper/model/photosModel.dart';
import 'package:wallpaper/model/categoryModel.dart';

class Apioper {
  static List<Photosmodel> trandingWallpapers = [];
  static List<Photosmodel> searchingWallpaper = [];
  static List<CategoryModel> cateogryModelList = [];

  static Future<List<Photosmodel>> getTrandingWallpapers() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=120'),
        headers: {
          'Authorization':
              'kk491b5kKGDWT88vJC5ZsT4QeRkCrbHD6hQSbQ5vVfpnj7mOPmbd1yq9'
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];

      photos.forEach((element) {
        trandingWallpapers.add(Photosmodel.fromApi2App(element));
      });
    });

    return trandingWallpapers;
  }

  static Future<List<Photosmodel>> searchWallpaper(String query) async {
    await http.get(
        Uri.parse(
            'https://api.pexels.com/v1/search?query=$query&per_page=60 &page=1'),
        headers: {
          'Authorization':
              'kk491b5kKGDWT88vJC5ZsT4QeRkCrbHD6hQSbQ5vVfpnj7mOPmbd1yq9'
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchingWallpaper.clear();

      photos.forEach((element) {
        searchingWallpaper.add(Photosmodel.fromApi2App(element));
      });
    });
    return searchingWallpaper;
  }

  static List<CategoryModel> getCategoriesList() {
    List categoryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];

    cateogryModelList.clear();

    categoryName.forEach(((catName) async {
      final _random = new Random();

      Photosmodel photoModel =
          (await searchWallpaper(catName))[0 + _random.nextInt(11 - 0)];
      print("IMG SRC IS HEAR");
      print(photoModel.imgSrc);

      cateogryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    }));

    return cateogryModelList;
  }
}
