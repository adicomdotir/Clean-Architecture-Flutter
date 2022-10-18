import 'package:clean_architecture_flutter/core/error/exceptions.dart';
import 'package:clean_architecture_flutter/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeLocalDataSource {
  Future<bool> clearToken();
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  final SharedPreferences sharedPreferences;

  HomeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> clearToken() async {
    final removed = await sharedPreferences.remove(cachedTokenKey);
    if (!removed) {
      throw CacheException();
    }
    return removed;
  }
}
