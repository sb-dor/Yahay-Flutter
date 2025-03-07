import 'package:yahay/src/features/telegram_file_picker_feature/domain/entities/telegram_file_folder_enums.dart';
import 'package:yahay/src/features/telegram_file_picker_feature/domain/entities/telegram_file_image_entity.dart';

class TelegramFilePickerStateModel {
  //
  final String? getPathForGettingImagesFrom;

  final bool openBottomSectionButton;

  final TelegramFileFolderEnum filePickerScreenSelectedScreen;

  final List<TelegramFileImageEntity> galleryPathFiles;

  final List<TelegramFileImageEntity> galleryPathPagination;

  final List<TelegramFileImageEntity> recentFiles;

  final List<TelegramFileImageEntity> recentFilesPagination;

  final List<TelegramFileImageEntity> pickedFiles;

  final List<TelegramFileImageEntity> specificFolderFilesAll;

  final List<TelegramFileImageEntity> specificFolderFilesPagination;

  const TelegramFilePickerStateModel({
    this.getPathForGettingImagesFrom,
    this.filePickerScreenSelectedScreen =
        TelegramFileFolderEnum.recentDownloadsScreen,
    this.openBottomSectionButton = true,
    required this.galleryPathFiles,
    required this.galleryPathPagination,
    required this.recentFiles,
    required this.recentFilesPagination,
    required this.pickedFiles,
    required this.specificFolderFilesAll,
    required this.specificFolderFilesPagination,
  });

  factory TelegramFilePickerStateModel.idle() =>
      const TelegramFilePickerStateModel(
        galleryPathFiles: <TelegramFileImageEntity>[],
        galleryPathPagination: <TelegramFileImageEntity>[],
        recentFiles: <TelegramFileImageEntity>[],
        recentFilesPagination: <TelegramFileImageEntity>[],
        pickedFiles: <TelegramFileImageEntity>[],
        specificFolderFilesAll: <TelegramFileImageEntity>[],
        specificFolderFilesPagination: <TelegramFileImageEntity>[],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TelegramFilePickerStateModel &&
          runtimeType == other.runtimeType &&
          getPathForGettingImagesFrom == other.getPathForGettingImagesFrom &&
          openBottomSectionButton == other.openBottomSectionButton &&
          filePickerScreenSelectedScreen ==
              other.filePickerScreenSelectedScreen &&
          galleryPathFiles == other.galleryPathFiles &&
          galleryPathPagination == other.galleryPathPagination &&
          recentFiles == other.recentFiles &&
          recentFilesPagination == other.recentFilesPagination &&
          pickedFiles == other.pickedFiles &&
          specificFolderFilesAll == other.specificFolderFilesAll &&
          specificFolderFilesPagination == other.specificFolderFilesPagination);

  @override
  int get hashCode =>
      getPathForGettingImagesFrom.hashCode ^
      openBottomSectionButton.hashCode ^
      filePickerScreenSelectedScreen.hashCode ^
      galleryPathFiles.hashCode ^
      galleryPathPagination.hashCode ^
      recentFiles.hashCode ^
      recentFilesPagination.hashCode ^
      pickedFiles.hashCode ^
      specificFolderFilesAll.hashCode ^
      specificFolderFilesPagination.hashCode;

  @override
  String toString() {
    return 'TelegramFilePickerStateModel{'
        ' getPathForGettingImagesFrom: $getPathForGettingImagesFrom,'
        ' openBottomSectionButton: $openBottomSectionButton,'
        ' filePickerScreenSelectedScreen: $filePickerScreenSelectedScreen,'
        ' galleryPathFiles: $galleryPathFiles,'
        ' galleryPathPagination: $galleryPathPagination,'
        ' recentFiles: $recentFiles,'
        ' recentFilesPagination: $recentFilesPagination,'
        ' pickedFiles: $pickedFiles,'
        ' specificFolderFilesAll: $specificFolderFilesAll,'
        ' specificFolderFilesPagination: $specificFolderFilesPagination,'
        '}';
  }

  TelegramFilePickerStateModel copyWith({
    String? getPathForGettingImagesFrom,
    bool? openBottomSectionButton,
    TelegramFileFolderEnum? filePickerScreenSelectedScreen,
    List<TelegramFileImageEntity>? galleryPathFiles,
    List<TelegramFileImageEntity>? galleryPathPagination,
    List<TelegramFileImageEntity>? recentFiles,
    List<TelegramFileImageEntity>? recentFilesPagination,
    List<TelegramFileImageEntity>? pickedFiles,
    List<TelegramFileImageEntity>? specificFolderFilesAll,
    List<TelegramFileImageEntity>? specificFolderFilesPagination,
  }) {
    return TelegramFilePickerStateModel(
      getPathForGettingImagesFrom:
          getPathForGettingImagesFrom ?? this.getPathForGettingImagesFrom,
      openBottomSectionButton:
          openBottomSectionButton ?? this.openBottomSectionButton,
      filePickerScreenSelectedScreen:
          filePickerScreenSelectedScreen ?? this.filePickerScreenSelectedScreen,
      galleryPathFiles: galleryPathFiles ?? this.galleryPathFiles,
      galleryPathPagination:
          galleryPathPagination ?? this.galleryPathPagination,
      recentFiles: recentFiles ?? this.recentFiles,
      recentFilesPagination:
          recentFilesPagination ?? this.recentFilesPagination,
      pickedFiles: pickedFiles ?? this.pickedFiles,
      specificFolderFilesAll:
          specificFolderFilesAll ?? this.specificFolderFilesAll,
      specificFolderFilesPagination:
          specificFolderFilesPagination ?? this.specificFolderFilesPagination,
    );
  }

  bool isFileInsidePickedFiles(TelegramFileImageEntity? value) =>
      pickedFiles.any((el) => el.uuid == value?.uuid);
}

//
//
//   // String? getFileBaseName(File? file) {
//   //   try {
//   //     return basename(file!.path);
//   //   } catch (e) {
//   //     debugPrint("get file base name error is: $e");
//   //     return null;
//   //   }
//   // }

//

// void clearPickedFiles() => _pickedFiles.clear();
//

//  void clearGetPathForGettingImagesFrom() => _getPathForGettingImagesFrom = null;
//
//   void setPathForGettingImagesFrom(String? path) => _getPathForGettingImagesFrom = path;

// void selectScreen(TelegramFileFolderEnum screen) {
//   _filePickerScreenSelectedScreen = screen;
// }

// void setGalleryPathFiles(TelegramFileImageEntity value) => _galleryPathFiles.add(value);

//void setOpenButtonSectionTimer(Timer? timer) {
//     if ((_openButtonSectionTimer?.isActive ?? false)) {
//       _openButtonSectionTimer?.cancel();
//     }
//     _openButtonSectionTimer = timer;
//   }
//
//   void setValueToOpenButtonSectionButton(bool value) {
//     _openBottomSectionButton = value;
//   }
//
//   void clearAllGalleryPath({bool clearAll = true}) {
//     if (_galleryPathFiles.isNotEmpty && !clearAll) {
//       _galleryPathFiles.removeRange(1, _galleryPathFiles.length);
//     } else {
//       _galleryPathFiles.clear();
//     }
//   }
//
//   void clearAllGalleryPaginationPath({bool clearAll = true}) {
//     if (_galleryPathPagination.isNotEmpty && !clearAll) {
//       _galleryPathPagination.removeRange(1, _galleryPathPagination.length);
//     } else {
//       _galleryPathPagination.clear();
//     }
//   }
//
//   void clearRecentFiles() => _recentFiles.clear();
//
//   void clearRecentPagFiles() => _recentFilesPagination.clear();
//
//   void clearSpecificFolderData() {
//     _specificFolderFilesAll.clear();
//     _specificFolderFilesPagination.clear();
//   }
//

//

//
//   void addToFolderDataList(TelegramFileImageEntity value) {
//     _specificFolderFilesAll.add(value);
//     if (_specificFolderFilesPagination.length < Constants.perPage) {
//       _specificFolderFilesPagination.add(value);
//     }
//   }
//
//   void addAllToFolderDataList(List<TelegramFileImageEntity> list) {
//     _specificFolderFilesPagination.addAll(list);
//   }
//
//   void addToPagination(List<TelegramFileImageEntity> list) => _galleryPathPagination.addAll(list);
//
//   void addToRecentFilesPagination(List<TelegramFileImageEntity> list) =>
//       _recentFilesPagination.addAll(list);

///// void initFileStreamData(
//   //   StreamSubscription<TelegramPathFolderFile?> stream,
//   // ) =>
//   //     _fileStreamData = stream;
//   //
//   // void initRecentFileStreamData(
//   //   StreamSubscription<TelegramPathFolderFile?> stream,
//   // ) =>
//   //     _recentFileData = stream;
//   //
//   // void initSpecificFolderDataStream(
//   //   StreamSubscription<TelegramPathFolderFile?> stream,
//   // ) =>
//   //     _specificFolderData = stream;
//   //
//   // Future<void> closeSpecificFolderDataStream() async {
//   //   await _specificFolderData?.cancel();
//   // }
//   //
//   // void closeAllStreamSubs() {
//   //   _fileStreamData?.cancel();
//   //   _recentFileData?.cancel();
//   // }
