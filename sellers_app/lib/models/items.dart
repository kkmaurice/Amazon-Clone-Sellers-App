
import 'package:cloud_firestore/cloud_firestore.dart';

class Items {
     String itemID;
     String brandID;
     String sellerID;
     String sellerName;
     String itemTitle;
     String itemInfo;
     String longDescription;
     String itemPrice;
     String thumbnailUrl;
     Timestamp publishedDate;
     String status;
  Items({
    required this.itemID,
    required this.brandID,
    required this.sellerID,
    required this.sellerName,
    required this.itemTitle,
    required this.itemInfo,
    required this.longDescription,
    required this.itemPrice,
    required this.thumbnailUrl,
    required this.publishedDate,
    required this.status,
  });

  factory Items.fromDocument(Map<String, dynamic> doc) {
    return Items(
      itemID: doc['itemID'],
      brandID: doc['brandID'],
      sellerID: doc['sellerID'],
      sellerName: doc['sellerName'],
      itemTitle: doc['itemTitle'],
      itemInfo: doc['itemInfo'],
      longDescription: doc['longDescription'],
      itemPrice: doc['itemPrice'],
      thumbnailUrl: doc['thumbnailUrl'],
      publishedDate: doc['publishedDate'],
      status: doc['status'],
    );
  }
}
