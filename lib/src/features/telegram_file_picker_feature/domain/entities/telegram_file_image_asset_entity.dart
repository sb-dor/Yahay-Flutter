base class TelegramFileImageAssetEntity {
  final String imagePath;
  final Duration? duration;

  TelegramFileImageAssetEntity(this.imagePath, {this.duration});

  factory TelegramFileImageAssetEntity.fromJson(Map<String, dynamic> json) {
    return TelegramFileImageAssetEntity(json['path']);
  }

  Map<String, dynamic> toJson() {
    return {"path": imagePath};
  }
}
