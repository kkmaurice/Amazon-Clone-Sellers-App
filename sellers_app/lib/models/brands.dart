import 'package:cloud_firestore/cloud_firestore.dart';

class Brands {
  String brandID;
  String brandInfo;
  String brandTitle;
  Timestamp publishedDate;
  String sellerUID;
  String status;
  String thumbnailUrl;
  Brands({
    required this.brandID,
    required this.brandInfo,
    required this.brandTitle,
    required this.publishedDate,
    required this.sellerUID,
    required this.status,
    required this.thumbnailUrl,
  });

  factory Brands.fromDocument(Map<String, dynamic> json) {
    return Brands(
      brandID: json['brandID'],
      brandInfo: json['brandInfo'],
      brandTitle: json['brandTitle'],
      publishedDate: json['publishedDate'],
      sellerUID: json['sellerUID'],
      status: json['status'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}
