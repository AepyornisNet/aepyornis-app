import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class ShareIntentService extends ChangeNotifier {
  ShareIntentService() {
    _init();
  }

  StreamSubscription? _intentDataStreamSubscription;
  final List<PlatformFile> _pendingFiles = [];
  bool _hasNewFiles = false;

  List<PlatformFile> get pendingFiles => List.unmodifiable(_pendingFiles);
  bool get hasNewFiles => _hasNewFiles;

  void _init() {
    // Listen to media sharing when app is running in memory
    _intentDataStreamSubscription = ReceiveSharingIntent.instance
        .getMediaStream()
        .listen(_handleSharedFiles, onError: (err) {
      debugPrint('getMediaStream error: $err');
    });

    // Get media sharing when app is opened from closed state
    ReceiveSharingIntent.instance.getInitialMedia().then((value) {
      if (value.isNotEmpty) {
        _handleSharedFiles(value);
        ReceiveSharingIntent.instance.reset();
      }
    }).catchError((err) {
      debugPrint('getInitialMedia error: $err');
    });
  }

  void _handleSharedFiles(List<SharedMediaFile> sharedFiles) {
    if (sharedFiles.isEmpty) return;

    final platformFiles = sharedFiles.map((file) {
      final name = file.path.split('/').last.split('\\').last;
      return PlatformFile(
        path: file.path,
        name: name,
        size: 0,
      );
    }).toList();

    _pendingFiles.addAll(platformFiles);
    _hasNewFiles = true;
    notifyListeners();
  }

  List<PlatformFile> consumePendingFiles() {
    final files = List<PlatformFile>.from(_pendingFiles);
    _pendingFiles.clear();
    _hasNewFiles = false;
    return files;
  }

  @override
  void dispose() {
    _intentDataStreamSubscription?.cancel();
    super.dispose();
  }
}
