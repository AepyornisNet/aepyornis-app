import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:result_dart/result_dart.dart';
import 'package:aepyornis_app/data/repositories/auth/auth_repository.dart';
import 'package:aepyornis_app/data/repositories/workout/workout_repository.dart';
import 'package:aepyornis_app/data/services/share_intent_service.dart';
import 'package:aepyornis_app/domain/models/equipment/equipment.dart';
import 'package:aepyornis_app/domain/models/workout/workout.dart';

class WorkoutTypeOption {
  const WorkoutTypeOption({
    required this.value,
    required this.name,
    this.location = true,
    this.distance = true,
    this.repetition = false,
    this.weight = false,
    this.duration = true,
    this.pace = false,
  });

  final String value;
  final String name;
  final bool location;
  final bool distance;
  final bool repetition;
  final bool weight;
  final bool duration;
  final bool pace;
}

const List<WorkoutTypeOption> kWorkoutTypes = [
  WorkoutTypeOption(
      value: 'generic',
      name: 'Generic Activity',
      location: true,
      distance: true,
      duration: true),
  WorkoutTypeOption(
      value: 'running',
      name: 'Running',
      location: true,
      distance: true,
      duration: true,
      pace: true),
  WorkoutTypeOption(
      value: 'cycling',
      name: 'Cycling',
      location: true,
      distance: true,
      duration: true),
  WorkoutTypeOption(
      value: 'swimming',
      name: 'Swimming',
      location: true,
      distance: true,
      duration: true),
  WorkoutTypeOption(
      value: 'walking',
      name: 'Walking',
      location: true,
      distance: true,
      duration: true),
  WorkoutTypeOption(
      value: 'hiking',
      name: 'Hiking',
      location: true,
      distance: true,
      duration: true),
  WorkoutTypeOption(
      value: 'training',
      name: 'Training',
      location: false,
      distance: false,
      repetition: true,
      weight: true,
      duration: true),
  WorkoutTypeOption(
      value: 'fitness_equipment',
      name: 'Fitness Equipment',
      location: false,
      distance: false,
      repetition: true,
      weight: true,
      duration: true),
  WorkoutTypeOption(
      value: 'hiit',
      name: 'HIIT',
      location: false,
      distance: false,
      repetition: true,
      weight: true,
      duration: true),
  WorkoutTypeOption(
      value: 'cross_country_skiing',
      name: 'Cross Country Skiing',
      location: true,
      distance: true,
      duration: true),
  WorkoutTypeOption(
      value: 'alpine_skiing',
      name: 'Alpine Skiing',
      location: true,
      distance: true,
      duration: true),
  WorkoutTypeOption(
      value: 'snowboarding',
      name: 'Snowboarding',
      location: true,
      distance: true,
      duration: true),
  WorkoutTypeOption(
      value: 'rowing',
      name: 'Rowing',
      location: true,
      distance: true,
      duration: true),
  WorkoutTypeOption(
      value: 'mountaineering',
      name: 'Mountaineering',
      location: true,
      distance: true,
      duration: true),
  WorkoutTypeOption(
      value: 'e_biking',
      name: 'E-Biking',
      location: true,
      distance: true,
      duration: true),
  WorkoutTypeOption(
      value: 'boxing',
      name: 'Boxing',
      location: true,
      distance: false,
      repetition: true,
      duration: true),
  WorkoutTypeOption(
      value: 'dance',
      name: 'Dance',
      location: false,
      distance: false,
      duration: true),
  WorkoutTypeOption(
      value: 'jump_rope',
      name: 'Jump Rope',
      location: false,
      distance: false,
      repetition: true,
      duration: true),
  WorkoutTypeOption(
      value: 'mobility',
      name: 'Mobility',
      location: false,
      distance: false,
      duration: true),
  WorkoutTypeOption(
      value: 'meditation',
      name: 'Meditation',
      location: false,
      distance: false,
      duration: true),
  WorkoutTypeOption(
      value: 'other',
      name: 'Other',
      location: true,
      distance: true,
      duration: true),
];

class WorkoutCreateViewModel extends ChangeNotifier {
  static const List<String> supportedExtensions = [
    'fit',
    'ftb',
    'gpx',
    'tcx',
    'zip',
  ];

  WorkoutCreateViewModel({
    required WorkoutRepository workoutRepository,
    AuthRepository? authRepository,
    ShareIntentService? shareIntentService,
  })  : _workoutRepository = workoutRepository,
        _authRepository = authRepository,
        _shareIntentService = shareIntentService {
    _shareIntentService?.addListener(_onShareIntentChanged);
    _checkAndProcessShareIntent();
  }

  final WorkoutRepository _workoutRepository;
  final AuthRepository? _authRepository;
  final ShareIntentService? _shareIntentService;

  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  bool _isEditMode = false;
  bool get isEditMode => _isEditMode;

  int? _editingWorkoutId;
  int? get editingWorkoutId => _editingWorkoutId;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _successMessage;
  String? get successMessage => _successMessage;

  // Equipment
  List<Equipment> _equipmentList = [];
  List<Equipment> get equipmentList => _equipmentList;

  // File Upload State
  List<PlatformFile> _selectedFiles = [];
  List<PlatformFile> get selectedFiles => _selectedFiles;

  String _fileUploadType = 'auto';
  String get fileUploadType => _fileUploadType;

  String _fileNotes = '';
  String get fileNotes => _fileNotes;

  // Manual Workout State
  String _manualWorkoutType = '';
  String get manualWorkoutType => _manualWorkoutType;

  String _name = '';
  String get name => _name;

  DateTime _date = DateTime.now();
  DateTime get date => _date;

  String _visibility = '';
  String get visibility => _visibility;

  String _location = '';
  String get location => _location;

  int _durationHours = 0;
  int get durationHours => _durationHours;

  int _durationMinutes = 0;
  int get durationMinutes => _durationMinutes;

  int _durationSeconds = 0;
  int get durationSeconds => _durationSeconds;

  double _distanceKm = 0.0;
  double get distanceKm => _distanceKm;

  int _repetitions = 0;
  int get repetitions => _repetitions;

  double _weightKg = 0.0;
  double get weightKg => _weightKg;

  String _manualNotes = '';
  String get manualNotes => _manualNotes;

  String _customType = '';
  String get customType => _customType;

  final List<int> _selectedEquipmentIds = [];
  List<int> get selectedEquipmentIds => _selectedEquipmentIds;

  // Computed field visibility
  WorkoutTypeOption? get currentTypeOption {
    try {
      return kWorkoutTypes.firstWhere((t) => t.value == _manualWorkoutType);
    } catch (_) {
      return null;
    }
  }

  bool get showLocation => currentTypeOption?.location ?? false;
  bool get showDistance => currentTypeOption?.distance ?? false;
  bool get showDuration => currentTypeOption?.duration ?? false;
  bool get showRepetitions => currentTypeOption?.repetition ?? false;
  bool get showWeight => currentTypeOption?.weight ?? false;
  bool get showCustomType => _manualWorkoutType == 'other';

  void setSelectedTab(int index) {
    if (index != _selectedTabIndex) {
      _selectedTabIndex = index;
      _errorMessage = null;
      _successMessage = null;
      notifyListeners();
    }
  }

  void loadInitialData() async {
    final result = await _workoutRepository.getEquipment();
    result.fold(
      (data) {
        _equipmentList = data;
        notifyListeners();
      },
      (_) {},
    );
  }

  Future<void> loadWorkoutForEdit(int id) async {
    _isLoading = true;
    _isEditMode = true;
    _editingWorkoutId = id;
    _selectedTabIndex = 1;
    _errorMessage = null;
    notifyListeners();

    loadInitialData();

    final result = await _workoutRepository.getOne(id);
    _isLoading = false;

    result.fold(
      (workout) {
        if (!workout.isOwnedBy(_authRepository?.currentUser)) {
          _errorMessage = 'You cannot edit another user\'s workout';
          notifyListeners();
          return;
        }

        _manualWorkoutType = workout.type.value;
        _name = workout.name;
        _date = workout.date.toLocal();
        _visibility = workout.visibility ?? '';
        _location = workout.addressString ?? '';

        final totalSecs = workout.totalDuration;
        _durationHours = totalSecs ~/ 3600;
        _durationMinutes = (totalSecs % 3600) ~/ 60;
        _durationSeconds = totalSecs % 60;

        _distanceKm =
            workout.totalDistance > 0 ? workout.totalDistance / 1000.0 : 0.0;
        _repetitions = workout.totalRepetitions;
        _weightKg = workout.totalWeight;
        _manualNotes = workout.notes;
        _customType = workout.customType ?? '';

        _selectedEquipmentIds.clear();
        if (workout.equipment.isNotEmpty) {
          for (final eq in workout.equipment) {
            if (eq.id != null) {
              _selectedEquipmentIds.add(eq.id!);
            }
          }
        }

        notifyListeners();
      },
      (error) {
        _errorMessage = 'Failed to load workout for editing';
        notifyListeners();
      },
    );
  }

  void _onShareIntentChanged() {
    _checkAndProcessShareIntent();
  }

  void _checkAndProcessShareIntent() {
    if (_shareIntentService != null && _shareIntentService.hasNewFiles) {
      final sharedFiles = _shareIntentService.consumePendingFiles();
      addFiles(sharedFiles);
    }
  }

  static bool isSupportedFile(PlatformFile file) {
    final ext = file.extension?.toLowerCase() ??
        (file.name.contains('.')
            ? file.name.split('.').last.toLowerCase()
            : '');
    return supportedExtensions.contains(ext);
  }

  // File Upload Handlers
  void setFileUploadType(String type) {
    _fileUploadType = type;
    notifyListeners();
  }

  void setFileNotes(String notes) {
    _fileNotes = notes;
    notifyListeners();
  }

  void addFiles(List<PlatformFile> files) {
    if (files.isEmpty) return;

    final validFiles = files.where(isSupportedFile).toList();
    final invalidCount = files.length - validFiles.length;

    if (validFiles.isNotEmpty) {
      _selectedFiles = [..._selectedFiles, ...validFiles];
      if (invalidCount > 0) {
        _errorMessage =
            'Some files were ignored. Only supported file types (.fit, .ftb, .gpx, .tcx, .zip) can be chosen.';
      } else {
        _errorMessage = null;
      }
    } else {
      _errorMessage =
          'Unsupported file type. Only supported file types (.fit, .ftb, .gpx, .tcx, .zip) can be chosen.';
    }
    _selectedTabIndex = 0;
    notifyListeners();
  }

  Future<void> pickFiles() async {
    try {
      final result = await FilePicker.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: supportedExtensions,
      );

      if (result != null && result.files.isNotEmpty) {
        addFiles(result.files);
      }
    } catch (e) {
      _errorMessage = 'Failed to pick files: $e';
      notifyListeners();
    }
  }

  void removeFile(int index) {
    if (index >= 0 && index < _selectedFiles.length) {
      _selectedFiles.removeAt(index);
      notifyListeners();
    }
  }

  Future<Result<List<Workout>>> uploadFiles() async {
    if (_selectedFiles.isEmpty) {
      _errorMessage = 'Please select at least one file';
      notifyListeners();
      return Failure(Exception('No files selected'));
    }

    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    final result = await _workoutRepository.uploadWorkoutFiles(
      files: _selectedFiles,
      type: _fileUploadType == 'auto' ? null : _fileUploadType,
      notes: _fileNotes.isEmpty ? null : _fileNotes,
    );

    _isLoading = false;
    result.fold(
      (workouts) {
        _successMessage = 'Successfully uploaded ${workouts.length} workout(s)';
        _selectedFiles = [];
        _fileNotes = '';
        notifyListeners();
      },
      (error) {
        _errorMessage = error.toString();
        notifyListeners();
      },
    );

    return result;
  }

  // Manual Workout Handlers
  void setManualWorkoutType(String type, [String? localizedTypeName]) {
    _manualWorkoutType = type;
    if (type.isNotEmpty) {
      final typeLabel =
          (localizedTypeName != null && localizedTypeName.isNotEmpty)
              ? localizedTypeName
              : (type.replaceAll('-', ' ')[0].toUpperCase() +
                  type.replaceAll('-', ' ').substring(1));
      final timeStr = DateFormat('yyyy-MM-dd HH:mm').format(_date);
      _name = '$typeLabel - $timeStr';
    }
    notifyListeners();
  }

  void setName(String val) {
    _name = val;
    notifyListeners();
  }

  void setDate(DateTime val) {
    _date = val;
    notifyListeners();
  }

  void setVisibility(String val) {
    _visibility = val;
    notifyListeners();
  }

  void setLocation(String val) {
    _location = val;
    notifyListeners();
  }

  void setDurationHours(int val) {
    _durationHours = val;
    notifyListeners();
  }

  void setDurationMinutes(int val) {
    _durationMinutes = val;
    notifyListeners();
  }

  void setDurationSeconds(int val) {
    _durationSeconds = val;
    notifyListeners();
  }

  void setDistanceKm(double val) {
    _distanceKm = val;
    notifyListeners();
  }

  void setRepetitions(int val) {
    _repetitions = val;
    notifyListeners();
  }

  void setWeightKg(double val) {
    _weightKg = val;
    notifyListeners();
  }

  void setManualNotes(String val) {
    _manualNotes = val;
    notifyListeners();
  }

  void setCustomType(String val) {
    _customType = val;
    notifyListeners();
  }

  void toggleEquipment(int equipmentId) {
    if (_selectedEquipmentIds.contains(equipmentId)) {
      _selectedEquipmentIds.remove(equipmentId);
    } else {
      _selectedEquipmentIds.add(equipmentId);
    }
    notifyListeners();
  }

  Future<Result<Workout>> submitManualWorkout() async {
    if (_manualWorkoutType.isEmpty) {
      _errorMessage = 'Please select a workout type';
      notifyListeners();
      return Failure(Exception('Workout type missing'));
    }

    if (_name.isEmpty) {
      _errorMessage = 'Please enter a workout name';
      notifyListeners();
      return Failure(Exception('Name missing'));
    }

    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    final dateStr = DateFormat("yyyy-MM-dd'T'HH:mm").format(_date);
    final timezone = DateTime.now().timeZoneName;

    final Map<String, dynamic> payload = {
      'name': _name,
      'date': dateStr,
      'timezone': timezone,
      'type': _manualWorkoutType,
      'visibility': _visibility,
      'notes': _manualNotes,
      'equipment_ids': _selectedEquipmentIds,
    };

    if (showLocation && _location.isNotEmpty) {
      payload['location'] = _location;
    }
    if (showDuration) {
      payload['duration_hours'] = _durationHours;
      payload['duration_minutes'] = _durationMinutes;
      payload['duration_seconds'] = _durationSeconds;
    }
    if (showDistance) {
      payload['distance'] = _distanceKm;
    }
    if (showRepetitions) {
      payload['repetitions'] = _repetitions;
    }
    if (showWeight) {
      payload['weight'] = _weightKg;
    }
    if (showCustomType && _customType.isNotEmpty) {
      payload['custom_type'] = _customType;
    }

    final Result<Workout> result;
    if (_isEditMode && _editingWorkoutId != null) {
      result =
          await _workoutRepository.updateWorkout(_editingWorkoutId!, payload);
    } else {
      result = await _workoutRepository.createWorkoutManual(payload);
    }

    _isLoading = false;
    result.fold(
      (workout) {
        _successMessage = _isEditMode
            ? 'Workout updated successfully'
            : 'Workout created successfully';
        notifyListeners();
      },
      (error) {
        _errorMessage = error.toString();
        notifyListeners();
      },
    );

    return result;
  }

  @override
  void dispose() {
    _shareIntentService?.removeListener(_onShareIntentChanged);
    super.dispose();
  }
}
