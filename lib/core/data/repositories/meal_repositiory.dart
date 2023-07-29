import 'package:dartz/dartz.dart';
import 'package:mealorder/core/data/models/api/category_model.dart';
import 'package:mealorder/core/data/models/common_respons.dart';
import 'package:mealorder/core/data/network/endpoints/category_endpoints.dart';
import 'package:mealorder/core/data/network/network_config.dart';
import 'package:mealorder/core/enums/request_type.dart';
import 'package:mealorder/core/utils/network_utils.dart';

class MealRepositiory {
  Future<Either<String, List<MealModel>>> getAll() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: CategoryEndPoints.getallMeal,
        headers:
            NetworkConfig.getHeaders(needAuth: false, type: RequestType.GET),
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<MealModel> result = [];
          commonResponse.data!.forEach(
            (element) {
              result.add(MealModel.fromJson(element));
            },
          );
          return Right(result);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
