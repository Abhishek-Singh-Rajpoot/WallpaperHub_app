class Photosmodel {
  String imgSrc;

  String photographerName;

  Photosmodel({required this.photographerName, required this.imgSrc});

  static Photosmodel fromApi2App(Map<String, dynamic> photoMap) {
    return Photosmodel(
        photographerName: photoMap['photographer'],
        imgSrc: (photoMap['src'])['portrait']);
  }
}
