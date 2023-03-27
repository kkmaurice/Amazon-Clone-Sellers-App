import 'package:cloud_firestore/cloud_firestore.dart';

class Brands {
  String? brandID;
  String? brandInfo;
  String? brandTitle;
  Timestamp? publishedDate;
  String? sellerID;
  String? status;
  String? thumbnailUrl;

  Brands({
    this.brandID,
    this.brandInfo,
    this.brandTitle,
    this.publishedDate,
    this.sellerID,
    this.status,
    this.thumbnailUrl,
  });

  factory Brands.fromMap(Map<String, dynamic> data) {
    return Brands(
      brandID: data['brandID'] ?? '',
      brandInfo: data['brandInfo'] ?? '',
      brandTitle: data['brandTitle'] ?? '',
      publishedDate: data['publishedDate'] as Timestamp,
      sellerID: data['sellerID'] ?? '',
      status: data['status'] ?? '',
      thumbnailUrl: data['thumbnailUrl'] ?? '',
    );
  }
}
