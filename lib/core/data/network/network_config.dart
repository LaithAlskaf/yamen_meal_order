import 'package:mealorder/core/enums/request_type.dart';

class NetworkConfig {
  static String BASE_API = 'api/web/';

  static String getFullApiRout(String apirout) {
    return BASE_API + apirout;
  }

  static Map<String, String> getHeaders(
      {bool? needAuth = true,
        required RequestType type,
        Map<String, String>? extraHeaders}) {
    return {
      if (needAuth!)
        "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiQ3VzdG9tZXIiLCJuYW1lIjoiMiIsIm5iZiI6MTY4NTMzOTIyOCwiZXhwIjoxNjg1ODU3NjI4LCJpYXQiOjE2ODUzMzkyMjh9.ofigylUBXXyBLv4XpNb0wrVSCNR8WgacaVLH4IHTs1g",
      if (type != RequestType.GET)
        "Content-Type": type == RequestType.MULTIPART
            ? "multipart/form-data"
            : "application/json",
      ...extraHeaders ?? {}
    };
  }
}