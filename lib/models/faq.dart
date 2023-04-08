import 'package:cloud_firestore/cloud_firestore.dart';

class FAQItem {
  FAQItem({required this.title, required this.body});

  String title;
  String body;

  factory FAQItem.fromDocument(DocumentSnapshot doc) {
    return FAQItem(body: doc.get('body'), title: doc.get('title'));
  }

  factory FAQItem.fromJson(json) {
    return FAQItem(title: json['title'], body: json['body']);
  }
}
