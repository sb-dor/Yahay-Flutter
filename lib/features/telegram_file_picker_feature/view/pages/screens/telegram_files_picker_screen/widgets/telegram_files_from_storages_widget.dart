import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahay/features/app_theme/bloc/app_theme_bloc.dart';
import 'package:yahay/features/initialization/widgets/dependencies_scope.dart';
import 'package:yahay/features/telegram_file_picker_feature/data/models/data_models/telegram_storage_file_picker_data_model.dart';
import 'package:yahay/features/telegram_file_picker_feature/view/bloc/telegram_file_picker_bloc.dart';

class TelegramFilesFromStoragesWidget extends StatefulWidget {
  final TelegramFilePickerBloc telegramFilePickerBloc;

  const TelegramFilesFromStoragesWidget({
    super.key,
    required this.telegramFilePickerBloc,
  });

  @override
  State<TelegramFilesFromStoragesWidget> createState() => _TelegramFilesFromStoragesWidgetState();
}

class _TelegramFilesFromStoragesWidgetState extends State<TelegramFilesFromStoragesWidget> {
  late AppThemeBloc _appThemeBloc;
  late List<TelegramStorageFilePickerDataModel> telegramStorageFileDataModels;

  @override
  void initState() {
    super.initState();
    _appThemeBloc = DependenciesScope.of(
      context,
      listen: false,
    ).appThemeBloc;
    telegramStorageFileDataModels = TelegramStorageFilePickerDataModel.data(
      widget.telegramFilePickerBloc,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: _appThemeBloc.theme.value.brightness == Brightness.dark
            ? Colors.blueGrey.shade900.withOpacity(0.5)
            : Colors.white,
      ),
      child: Column(
        children: [
          ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: telegramStorageFileDataModels.length,
            itemBuilder: (context, index) {
              final item = telegramStorageFileDataModels[index];
              return IntrinsicHeight(
                child: GestureDetector(
                  onTap: item.onTap,
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: item.iconBackgroundColor,
                          ),
                          child: Center(
                            child: item.icon,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.title,
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                item.content,
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
