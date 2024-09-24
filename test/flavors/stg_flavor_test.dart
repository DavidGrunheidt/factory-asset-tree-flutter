import 'package:factory_asset_tree_flutter/flavors.dart';
import 'package:flutter_test/flutter_test.dart';

// Reference: https://github.com/Baseflow/flutter-geolocator/blob/main/geolocator/test/geolocator_test.dart
void main() {
  group('StgFlavor', () {
    appBuildFlavor = AppBuildFlavorEnum.STG;

    test('names returns STG', () async {
      expect(appBuildFlavor.name, AppBuildFlavorEnum.STG.name);
    });

    test('appTitle has the correct value', () async {
      expect(appBuildFlavor.appTitle, '[Stg]Asset Tree');
    });

    test('androidBundleName returns com.dvosoftwarehouse.assettree.stg', () async {
      expect(appBuildFlavor.androidBundleName, 'com.dvosoftwarehouse.assettree.stg');
    });

    test('iOSBundleName returns com.dvosoftwarehouse.assettree.stg', () async {
      expect(appBuildFlavor.iOSBundleName, 'com.dvosoftwarehouse.assettree.stg');
    });
  });
}
