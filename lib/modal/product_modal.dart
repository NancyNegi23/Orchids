import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final String? desc;
  final List<String>? imageUrl;
  final String? reviews;
  final num price;
  final String? color;
  final String? fit;
  final String? composition;
  final String? articleNumber;
  final List? otherColors;
  final DocumentSnapshot? document;

  Product({
    required this.name,
    this.desc,
    this.imageUrl,
    this.reviews,
    required this.price,
    this.color,
    this.fit,
    this.composition,
    this.articleNumber,
    this.otherColors,
    this.document,
  });
}

Product greenSweatshirt = Product(
  name: "Relaxed Fit Sweatshirt",
  imageUrl: [
    "https://lp2.hm.com/hmgoepprod?set=quality%5B79%5D%2Csource%5B%2Fc4%2F58%2Fc4583e5b8e7a670e78570ab67bba3a0d6dfc8d68.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BLOOKBOOK%5D%2Cres%5Bm%5D%2Chmver%5B1%5D&call=url[file:/product/main]",
    "https://lp2.hm.com/hmgoepprod?set=format%5Bwebp%5D%2Cquality%5B79%5D%2Csource%5B%2F36%2F96%2F369633ba54a11b25d3315324521bab700a1053b7.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BLOOKBOOK%5D%2Cres%5Bm%5D%2Chmver%5B1%5D&call=url%5Bfile%3A%2Fproduct%2Fmain%5D",
    "https://lp2.hm.com/hmgoepprod?set=format%5Bwebp%5D%2Cquality%5B79%5D%2Csource%5B%2F4c%2F64%2F4c640f5ca9a9278ca213b5bf929438e91899ad57.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BLOOKBOOK%5D%2Cres%5Bm%5D%2Chmver%5B1%5D&call=url%5Bfile%3A%2Fproduct%2Fmain%5D",
    "https://lp2.hm.com/hmgoepprod?set=format%5Bwebp%5D%2Cquality%5B79%5D%2Csource%5B%2F9c%2F44%2F9c444c1a449b234b15230a41cca76ce8da62d90e.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BLOOKBOOK%5D%2Cres%5Bm%5D%2Chmver%5B1%5D&call=url%5Bfile%3A%2Fproduct%2Fmain%5D",
    "https://lp2.hm.com/hmgoepprod?set=format%5Bwebp%5D%2Cquality%5B79%5D%2Csource%5B%2F12%2F20%2F1220b67da42b56c1d771b10631160f15869dc8b8.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5Bmen_hoodiessweatshirts_sweatshirts%5D%2Ctype%5BDESCRIPTIVEDETAIL%5D%2Cres%5Bm%5D%2Chmver%5B2%5D&call=url%5Bfile%3A%2Fproduct%2Fmain%5D",
  ],
  price: 799.00,
  color: "Dark green",
  otherColors: [
    "https://lp2.hm.com/hmgoepprod?set=format%5Bwebp%5D%2Cquality%5B79%5D%2Csource%5B%2F0f%2F20%2F0f20e7da33ee29c56b9e44e2fbafcf5055a80726.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BDESCRIPTIVESTILLLIFE%5D%2Cres%5Bm%5D%2Chmver%5B2%5D&call=url%5Bfile%3A%2Fproduct%2Fmain%5D",
    "https://lp2.hm.com/hmgoepprod?set=format%5Bwebp%5D%2Cquality%5B79%5D%2Csource%5B%2Ffb%2Fbb%2Ffbbbfdb8b944bac9bb42bb8f15dc967a8522b910.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BDESCRIPTIVESTILLLIFE%5D%2Cres%5Bm%5D%2Chmver%5B2%5D&call=url%5Bfile%3A%2Fproduct%2Fmain%5D",
    "https://lp2.hm.com/hmgoepprod?set=format%5Bwebp%5D%2Cquality%5B79%5D%2Csource%5B%2Fcc%2F78%2Fcc783b01c22bb9a1f73293e2ac74c6d4c2727298.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BDESCRIPTIVESTILLLIFE%5D%2Cres%5Bm%5D%2Chmver%5B2%5D&call=url%5Bfile%3A%2Fproduct%2Fmain%5D",
    "https://lp2.hm.com/hmgoepprod?set=format%5Bwebp%5D%2Cquality%5B79%5D%2Csource%5B%2F00%2F62%2F0062c694c41559e7e7a0c201425f1e5d068948ea.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BDESCRIPTIVESTILLLIFE%5D%2Cres%5Bm%5D%2Chmver%5B2%5D&call=url%5Bfile%3A%2Fproduct%2Fmain%5D",
    "https://lp2.hm.com/hmgoepprod?set=format%5Bwebp%5D%2Cquality%5B79%5D%2Csource%5B%2Fee%2Fd0%2Feed000d32aac19b1f07eabbf8e112fecfaa3be0d.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BDESCRIPTIVESTILLLIFE%5D%2Cres%5Bm%5D%2Chmver%5B2%5D&call=url%5Bfile%3A%2Fproduct%2Fmain%5D",
    "https://lp2.hm.com/hmgoepprod?set=format%5Bwebp%5D%2Cquality%5B79%5D%2Csource%5B%2Fd2%2Fa5%2Fd2a59434aab62ca4a1f77c53df0cb6c54d19cb9a.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BDESCRIPTIVESTILLLIFE%5D%2Cres%5Bm%5D%2Chmver%5B2%5D&call=url%5Bfile%3A%2Fproduct%2Fmain%5D",
    "https://lp2.hm.com/hmgoepprod?set=format%5Bwebp%5D%2Cquality%5B79%5D%2Csource%5B%2F9a%2F0a%2F9a0aefaf2c34e8af4094a10a05e53b7e7e6b4100.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BDESCRIPTIVESTILLLIFE%5D%2Cres%5Bm%5D%2Chmver%5B3%5D&call=url%5Bfile%3A%2Fproduct%2Fmain%5D",
  ],
  desc:
      "Top in sweatshirt fabric made from a cotton blend. Relaxed fit with dropped shoulders and ribbing around the neckline, cuffs and hem. Soft brushed inside.",
  fit: 'Relaxed fit',
  composition: "Cotton 60%, Polyester 40%",
  articleNumber: "0970818010",
  reviews: "12341",
);
