import 'package:dio/dio.dart';
import 'package:tryproject/app/constants/api_endpoints.dart';
import 'package:tryproject/features/artwork/data/data_source/artwork_datasource.dart';
import 'package:tryproject/features/artwork/data/dto/get_all_artwork_dto.dart';
import 'package:tryproject/features/artwork/data/model/artwork_api_model.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';

class ArtworkRemoteDatasource implements IArtworkDataSource {
  final Dio _dio;

  ArtworkRemoteDatasource({required Dio dio}) : _dio = dio;

  @override
  Future<List<ArtworkEntity>> getArtworks() async {
    try {
      var response = await _dio.get(ApiEndpoints.getArtworks);
      if (response.statusCode == 200) {
        GetAllArtworkDTO artworkaddDTO =
            GetAllArtworkDTO.fromJson(response.data);
        return ArtworkApiModel.toEntityList(artworkaddDTO.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ArtworkEntity> getArtworkById(String id) async {
    try {
      var response = await _dio.get('${ApiEndpoints.getArtworkbyId}/$id');
      if (response.statusCode == 200) {
        return ArtworkApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
