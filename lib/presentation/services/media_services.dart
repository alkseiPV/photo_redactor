import 'package:photo_manager/photo_manager.dart';

class MediaServices {
  Future loadAlbums(RequestType requestType) async {
    var permission = await PhotoManager.requestPermissionExtend();
    List<AssetPathEntity> albumList = [];

    if (permission.isAuth == true) {
      albumList = await PhotoManager.getAssetPathList(type: requestType);
    } else {
      PhotoManager.openSetting();
    }
    return albumList;
  }

  Future loadAssets(AssetPathEntity selectedAlbum, int start, int end) async {
    List<AssetEntity> assetsList = await selectedAlbum.getAssetListRange(
        start: start,
        // ignore: deprecated_member_use
        end: end);
    return assetsList;
  }
}
