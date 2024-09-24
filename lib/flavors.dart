enum AppBuildFlavorEnum {
  STG(
    '[Stg]Asset Tree',
    'com.dvosoftwarehouse.assettree.stg',
    'com.dvosoftwarehouse.assettree.stg',
  ),
  PROD(
    'Asset Tree',
    'com.dvosoftwarehouse.assettree',
    'com.dvosoftwarehouse.assettree',
  );

  const AppBuildFlavorEnum(
    this.appTitle,
    this.androidBundleName,
    this.iOSBundleName,
  );

  final String appTitle;
  final String androidBundleName;
  final String iOSBundleName;
}

late final AppBuildFlavorEnum appBuildFlavor;
