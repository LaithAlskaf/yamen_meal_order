import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mealorder/core/enums/request_type.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

class NetworkUtil {
  static String baseUrl = 'training.owner-tech.com';
  static var client = http
      .Client(); // حتى استطيع ارسال واصتقبال الطلبات من ال http يجب ان اهيأ متغير من نوع client
  static bool online = true;
  static Future<dynamic> sendRequest({
    required RequestType type,
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  }) async {
    try {
      //!--- Required for request ----
      //*--- Make full api url ------
      var uri = Uri.https(baseUrl, url, params);

      //?--- To Save api response ----
      late http.Response
          response; // حتى يتم استقبال البيانات من http ويتم تاخير تعريفه حتى يتم طلبه
      //?--- To Save api status code ----

      //!--- Required convert api response to Map ----
      Map<String, dynamic> jsonResponse = {};

      //*--- Make call correct request type ------
      switch (type) {
        case RequestType.GET:
          response = await client.get(uri, headers: headers);
          break;
        case RequestType.POST:
          response =
              await client.post(uri, body: jsonEncode(body), headers: headers);
          break;
        case RequestType.PUT:
          response =
              await client.put(uri, body: jsonEncode(body), headers: headers);
          break;
        case RequestType.DELETE:
          response = await client.delete(uri,
              body: jsonEncode(body), headers: headers);
          break;
      }

      dynamic result;

      try {
        result = jsonDecode(const Utf8Codec().decode(response.bodyBytes));
      } catch (e) {
        e;
      }

      jsonResponse.putIfAbsent(
          'response',
          () => result == null
              ? jsonDecode(jsonEncode(
                  {'title': const Utf8Codec().decode(response.bodyBytes)}))
              : jsonDecode(const Utf8Codec().decode(response.bodyBytes)));
      jsonResponse.putIfAbsent('statusCode', () => response.statusCode);

      (jsonResponse);
      return jsonResponse;
    } catch (e) {
      (e);
    }
  }

  static Future<dynamic> sendMultipartRequest({
    required String url,
    required RequestType type,
    Map<String, String>? headers = const {},
    Map<String, String>? fields = const {},
    Map<String, String>? files = const {},
    Map<String, dynamic>? params,
  }) async {
    // assert(type == RequestType.GET || type == RequestType.MULTIPART);
    try {
      var request =
          http.MultipartRequest('POST', Uri.https(baseUrl, url, params));

      var _filesKeyList = files!.keys.toList();
      var _filesNameList = files.values.toList();
      for (int i = 0; i < _filesKeyList.length; i++) {
        if (_filesNameList[i].isNotEmpty) {
          var multipartFile = http.MultipartFile.fromPath(
            _filesKeyList[i],
            _filesNameList[i],
            filename: path.basename(_filesNameList[i]),
            contentType: getContentType(_filesNameList[i]),
          );
          request.files.add(await multipartFile);
        }
      }
      request.headers.addAll(headers!);
      request.fields.addAll(fields!);

      var response = await request.send();

      Map<String, dynamic> responseJson = {};
      var value = await response.stream.bytesToString();
      responseJson.putIfAbsent('statusCode', () => response.statusCode);
      responseJson.putIfAbsent('response', () => jsonDecode(value));
print(responseJson);
      return responseJson;
    } catch (error) {
      error.toString();
    }
  }

  static MediaType getContentType(String name) {
    var ext = name.split('.').last.toLowerCase();
    MediaType mediaType;
    if (ext == ("png")) {
      mediaType = MediaType.parse("image/png");
    } else if (ext == "jpeg" || ext == "jpg") {
      mediaType = MediaType.parse("image/jpeg");
    } else if (ext == "gif") {
      mediaType = MediaType.parse("image/gif");
    } else if (ext == "bmp") {
      mediaType = MediaType.parse("image/bmp");
    } else if (ext == "webp") {
      mediaType = MediaType.parse("image/webp");
    } else if (ext == "pdf") {
      mediaType = MediaType.parse("application/pdf");
    } else if (ext == "doc" || ext == "docx") {
      mediaType = MediaType.parse("application/vnd.ms-word");
    } else if (ext == "xls" || ext == "xlsx") {
      mediaType = MediaType.parse("application/vnd.ms-excel");
    } else if (ext == "ppt" || ext == "pptx") {
      mediaType = MediaType.parse("application/vnd.ms-powerpoint");
    } else {
      mediaType = MediaType.parse("application/octet-stream");
    }
    return mediaType;
  }
}
