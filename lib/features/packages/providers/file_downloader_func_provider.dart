import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futurstore/features/packages/functions/utils.dart';

import '../data/models/typedefs/file_background_download_function.dart';
import '../data/repo/i_package_file_installer.dart';

final fileDownloaderFuncProvider = Provider<FileBackgroundDownloadFunction>(
  (ref) {
    FileDownloader().configureNotification(
      running: const TaskNotification('Downloading', 'file: {filename}'),
      complete: const TaskNotification('Download finished', 'file: {filename}'),
      progressBar: true,
    );

    FileDownloader().registerCallbacks(
      taskNotificationTapCallback: (task, notificationType) {},
    );

    return backgroundDownloadApkFile;
  },
);

Future<File> backgroundDownloadApkFile(
  String url,
  String packageName,
  void Function(double)? onProgress,
  void Function(DownloadTaskStatus)? onStatus,
) async {
  try {
    final task = DownloadTask(
      url: url,
      filename: '$packageName.apk',
      baseDirectory: BaseDirectory.temporary,

      updates: Updates.statusAndProgress,
      // requiresWiFi: true,
      retries: 5,
      allowPause: true,
    );

    final _ = await FileDownloader().download(
      task,
      onProgress: (progress) {
        debugPrint('Progress: ${progress * 100}%');
        onProgress?.call(progress);
      },
      onStatus: (status) {
        debugPrint('Status: $status');
        onStatus?.call(DownloadTaskStatus.values.byName(status.name));
      },
    );

    // ignore: non_constant_identifier_names
    final __ = await task.filePath();

    final filePath = await getFilePathFromPackageName(packageName);

    return File(filePath);
  } catch (e) {
    debugPrint(e.toString());

    rethrow;
  }
}
