import 'package:dartz/dartz.dart';
import 'package:mealorder/core/data/models/api/token_info.dart';
import 'package:mealorder/core/data/models/common_respons.dart';
import 'package:mealorder/core/data/network/endpoints/user_endpoints.dart';
import 'package:mealorder/core/data/network/network_config.dart';
import 'package:mealorder/core/enums/request_type.dart';
import 'package:mealorder/core/utils/network_utils.dart';

class UserRepository {
  Future<Either<String, TokenInfo>> login({
    required String email,
    required String password,
  }) async {
    try {
      return NetworkUtil.sendRequest(
          type: RequestType.POST,
          url: UserEndPoints.login,
          headers:
              NetworkConfig.getHeaders(needAuth: false, type: RequestType.POST),
          body: {
            'userName': email,
            'password': password,
          }).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);
        if (commonResponse.getStatus) {
          return Right(TokenInfo.fromJson(
            commonResponse.data ?? {},
          ));
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> register({
    required String email,
    required String password,
    required String lastname,
    required String firstname,
    required int age,
    required String photo,
  }) async {
    try {
      return NetworkUtil.sendMultipartRequest(
        type: RequestType.POST,
        url: UserEndPoints.rigester,
        fields: {
          'Email': email,
          'FirstName': firstname,
          'LastName': lastname,
          'Password': password,
          'Age': age.toString(),
        },
        files: {"Photo": photo},
        headers: NetworkConfig.getHeaders(
            needAuth: false,
            extraHeaders: {
              "Host": "training.owner-tech.com",
              "Content-Type":
                  "multipart/form-data; boundary=--------------------------5014115597297111058551",
              "Content-Length": "82554"
            },
            type: RequestType.MULTIPART),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);
        if (commonResponse.getStatus) {
          return Right(commonResponse.getStatus);
        } else {
          return Left(commonResponse.message ?? ''); //رسالة الخطأ
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
