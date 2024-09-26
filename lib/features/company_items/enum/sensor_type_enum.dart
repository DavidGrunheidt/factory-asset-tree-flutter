enum SensorTypeEnum { energy, vibration }

extension SensorTypeEnumExtension on SensorTypeEnum? {
  bool get isEnergy => this == SensorTypeEnum.energy;

  bool get isVibration => this == SensorTypeEnum.vibration;
}
