import 'boot.dart';
import 'flavors.dart';

void main() {
  appBuildFlavor = AppBuildFlavorEnum.PROD;
  boot();
}
