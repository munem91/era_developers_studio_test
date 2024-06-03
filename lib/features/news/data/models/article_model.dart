// import '../../domain/domain.dart';

// class ArticleModel extends Article {
//   ArticleModel({
//     required String id,
//     required String title,
//     required DateTime publicationDate,
//     required String imageUrl,
//     bool readed = false,
//     String? description,
//   }) : super(
//           id: id,
//           title: title,
//           publicationDate: publicationDate,
//           imageUrl: imageUrl,
//           readed: readed,
//           description: description,
//         );

//   factory ArticleModel.fromJson(Map<String, dynamic> json) {
//     return ArticleModel(
//       id: json['id'],
//       title: json['title'],
//       publicationDate: DateTime.parse(json['publicationDate']),
//       imageUrl: json['imageUrl'],
//       readed: json['readed'],
//       description: json['description'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'publicationDate': publicationDate.toIso8601String(),
//       'imageUrl': imageUrl,
//       'readed': readed,
//       'description': description,
//     };
//   }
// }
