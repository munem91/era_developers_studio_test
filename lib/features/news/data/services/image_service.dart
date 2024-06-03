///This is a service for getting a picture from a website page.

// import 'package:dio/dio.dart';
// import 'package:html/parser.dart' show parse;

// class ImageService {
//   final Dio _dio = Dio();

//   Future<String?> fetchDirectImageUrl(String pageUrl) async {
//     try {
//       final response = await _dio.get(pageUrl);
//       if (response.statusCode == 200) {
//         var document = parse(response.data);
//         var metaTag = document.querySelector('meta[property="og:image"]');
//         if (metaTag != null) {
//           return metaTag.attributes['content'];
//         }
//       }
//     } catch (e) {
//       print('Error fetching image URL: $e');
//     }
//     return null;
//   }
// }
