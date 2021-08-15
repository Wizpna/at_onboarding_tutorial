import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class AtService {
  static final AtService _singleton = AtService._internal();

  AtService._internal();
  static final KeyChainManager _keyChainManager = KeyChainManager.getInstance();

  factory AtService.getInstance() {
    return _singleton;
  }

  Map<String, AtClientService> atClientServiceMap = {};

  //This function authentication the users whenever they wants to login
  Future<AtClientPreference> getAtClientPreference() async {
    final appDocumentDirectory =
    await path_provider.getApplicationSupportDirectory();
    String path = appDocumentDirectory.path;
    var _atClientPreference = AtClientPreference()
      ..isLocalStoreRequired = true
      ..commitLogPath = path
      ..syncStrategy = SyncStrategy.ONDEMAND
      ..rootDomain = 'root.atsign.org'
      ..hiveStoragePath = path;
    return _atClientPreference;
  }

  //This function deletes the user's at sign keys and logs the user out
  Future<void> deleteAtSign({String atsign}) async {
    print(atsign);
    var currentAtsign;
    atsign ??= currentAtsign;
    await _keyChainManager.deleteAtSignFromKeychain(atsign);
    atClientServiceMap.remove(atsign);
    if (atsign == currentAtsign) currentAtsign = null;
  }
}