import 'package:factory_asset_tree_flutter/flavors.dart';
import 'package:flutter_test/flutter_test.dart';

// Reference: https://github.com/Baseflow/flutter-geolocator/blob/main/geolocator/test/geolocator_test.dart
void main() {
  group('ProdFlavor', () {
    appBuildFlavor = AppBuildFlavorEnum.PROD;

    test('names returns PROD', () async {
      expect(appBuildFlavor.name, AppBuildFlavorEnum.PROD.name);
    });

    test('appTitle has the correct value', () async {
      expect(appBuildFlavor.appTitle, 'Asset Tree');
    });

    test('androidBundleName returns com.dvosoftwarehouse.assettree', () async {
      expect(appBuildFlavor.androidBundleName, 'com.dvosoftwarehouse.assettree');
    });

    test('iOSBundleName returns com.dvosoftwarehouse.assettree', () async {
      expect(appBuildFlavor.iOSBundleName, 'com.dvosoftwarehouse.assettree');
    });
  });
}
