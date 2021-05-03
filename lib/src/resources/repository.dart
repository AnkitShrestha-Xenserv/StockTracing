import 'user_info_db.dart';
import '../models/user_model.dart';
import '../resources/user_info_db.dart';
import '../models/item_model.dart';
import 'share_api_provider.dart';
import 'share_db_provider.dart';
import 'dart:io';

class Repository {
  static final shareDbProvider = ShareDbProvider.instance;
  List<Source> sources = <Source>[
    ShareApiProvider(),
    shareDbProvider,
  ];
  List<Cache> cache = <Cache>[
    shareDbProvider,
  ];

  final userInfoDb = UserInfoDb();

  void addUser(int userId, String firstName, String lastName, String password) {
    userInfoDb.addUser(
      UserModel.fromForm(
          userId: userId,
          firstName: firstName,
          lastName: lastName,
          password: password),
    );
  }

  Future<List<ItemModel>> fetchShare() async {
    if (await checkConnectivity()) {
      final list = await sources.first.fetchShare();
      if (!(list.length == 0)) {
        shareDbProvider.deleteShare();
        for (var item in list) {
          await cache[0].addShare(item);
        }
        print(await shareDbProvider.queryRowCount());
        return list;
      } else {
        final list = await sources[1].fetchShare();
        return list;
      }
    }
    final list = await sources[1].fetchShare();
    return list;
  }

  Future<List<ItemModel>> fetchShareDb() {
    return sources[1].fetchShare();
  }

  Future<bool> checkValidity(int userId, String password) async {
    return userInfoDb.checkValidity(userId, password);
  }
}

Future<bool> checkConnectivity() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('Internet');
      return true;
    }
  } on SocketException catch (_) {
    print('No Internet');
    return false;
  }
  return false;
}

abstract class Source {
  Future<List<ItemModel>> fetchShare();
}

abstract class Cache {
  Future<int> addShare(ItemModel item);
}
