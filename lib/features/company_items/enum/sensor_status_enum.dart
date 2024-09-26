enum SensorStatusEnum { operating, alert }

extension SensorStatusEnumExtension on SensorStatusEnum? {
  bool get isOperating => this == SensorStatusEnum.operating;

  bool get isAlert => this == SensorStatusEnum.alert;
}
