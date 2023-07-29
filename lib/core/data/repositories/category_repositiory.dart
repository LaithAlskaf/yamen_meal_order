import 'package:dartz/dartz.dart';
import 'package:mealorder/core/data/models/api/category_model.dart';
import 'package:mealorder/core/data/models/common_respons.dart';
import 'package:mealorder/core/data/network/endpoints/category_endpoints.dart';
import 'package:mealorder/core/data/network/network_config.dart';
import 'package:mealorder/core/enums/request_type.dart';
import 'package:mealorder/core/utils/network_utils.dart';

class CategoryRepository {
  Future<Either<String, List<CategoryModel>>> getAll() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: CategoryEndPoints.getallCategory,
        headers: NetworkConfig.getHeaders(needAuth: false,type: RequestType.GET),
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
        CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<CategoryModel>resultList=[];
          commonResponse.data!.forEach(
                (element)
            { resultList.add(CategoryModel.fromJson(element));
            },
          );
          return Right(resultList);}
        else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}