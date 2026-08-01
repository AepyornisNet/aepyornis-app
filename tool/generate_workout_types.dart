import 'dart:convert';
import 'dart:io';
import 'package:yaml/yaml.dart';

void main(List<String> args) {
  final yamlFile = _findYamlFile(args);
  if (yamlFile == null) {
    stderr.writeln('Error: Could not find workout-types.yaml');
    exit(1);
  }

  print('Reading workout types from ${yamlFile.path}...');
  final content = yamlFile.readAsStringSync();
  final yaml = loadYaml(content);

  if (yaml is! Map || !yaml.containsKey('workout_types')) {
    stderr.writeln('Error: Invalid workout-types.yaml format');
    exit(1);
  }

  final workoutTypesMap = yaml['workout_types'] as Map;
  final workoutTypes = <WorkoutTypeItem>[];

  for (final entry in workoutTypesMap.entries) {
    final key = entry.key.toString();
    final valueMap = entry.value as Map;

    final name = valueMap['name']?.toString() ?? key;
    final location = valueMap['location'] == true;
    final distance = valueMap['distance'] == true;
    final repetition = valueMap['repetition'] == true;
    final weight = valueMap['weight'] == true;
    final pace = valueMap['pace'] == true;
    final duration = valueMap.containsKey('duration')
        ? (valueMap['duration'] == true)
        : true;

    final subTypes = <String, String>{};
    if (valueMap['sub_types'] is Map) {
      final subMap = valueMap['sub_types'] as Map;
      for (final subEntry in subMap.entries) {
        final subKey = subEntry.key.toString();
        final subName = (subEntry.value as Map)['name']?.toString() ?? subKey;
        subTypes[subKey] = subName;
      }
    }

    workoutTypes.add(
      WorkoutTypeItem(
        key: key,
        name: name,
        location: location,
        distance: distance,
        repetition: repetition,
        weight: weight,
        duration: duration,
        pace: pace,
        subTypes: subTypes,
      ),
    );
  }

  print('Found ${workoutTypes.length} workout types.');

  // Update ARB files with workout type keys
  _updateArbFiles(workoutTypes);

  // Generate Dart code
  final generatedCode = _generateDartCode(workoutTypes);

  final targetPath =
      'lib/domain/models/workout_type/workout_type_generated.dart';
  final outputFile = File(targetPath);
  outputFile.writeAsStringSync(generatedCode);

  print('Successfully generated $targetPath');
}

File? _findYamlFile(List<String> args) {
  if (args.isNotEmpty) {
    final f = File(args.first);
    if (f.existsSync()) return f;
  }

  final candidates = [
    '../aepyornis/workout-types.yaml',
    './workout-types.yaml',
    '../workout-types.yaml',
    '../../workout-types.yaml',
    '/home/brihm/Projects/aepyornis/workout-types.yaml',
  ];

  for (final path in candidates) {
    final f = File(path);
    if (f.existsSync()) return f;
  }

  return null;
}

class WorkoutTypeItem {
  WorkoutTypeItem({
    required this.key,
    required this.name,
    required this.location,
    required this.distance,
    required this.repetition,
    required this.weight,
    required this.duration,
    required this.pace,
    required this.subTypes,
  });

  final String key;
  final String name;
  final bool location;
  final bool distance;
  final bool repetition;
  final bool weight;
  final bool duration;
  final bool pace;
  final Map<String, String> subTypes;

  String get arbKey {
    final parts = key.split(RegExp(r'[_-]'));
    final buffer = StringBuffer('workoutType');
    for (final part in parts) {
      if (part.isNotEmpty) {
        buffer.write(part[0].toUpperCase());
        buffer.write(part.substring(1).toLowerCase());
      }
    }
    return buffer.toString();
  }
}

void _updateArbFiles(List<WorkoutTypeItem> items) {
  final germanNames = <String, String>{
    'generic': 'Allgemeine Aktivität',
    'running': 'Laufen',
    'cycling': 'Radsport',
    'transition': 'Wechselzone',
    'fitness_equipment': 'Fitnessgeräte',
    'swimming': 'Schwimmen',
    'basketball': 'Basketball',
    'soccer': 'Fußball',
    'tennis': 'Tennis',
    'american_football': 'American Football',
    'training': 'Krafttraining',
    'walking': 'Gehen',
    'cross_country_skiing': 'Langlauf',
    'alpine_skiing': 'Ski Alpin',
    'snowboarding': 'Snowboarden',
    'rowing': 'Rudern',
    'mountaineering': 'Bergsteigen',
    'hiking': 'Wandern',
    'multisport': 'Multisport',
    'paddling': 'Paddeln',
    'flying': 'Fliegen',
    'e_biking': 'E-Bike',
    'motorcycling': 'Motorradfahren',
    'boating': 'Bootfahren',
    'driving': 'Fahren',
    'golf': 'Golf',
    'hang_gliding': 'Drachenfliegen',
    'horseback_riding': 'Reiten',
    'hunting': 'Jagen',
    'fishing': 'Angeln',
    'inline_skating': 'Inlineskaten',
    'rock_climbing': 'Klettern',
    'sailing': 'Segeln',
    'ice_skating': 'Schlittschuhlaufen',
    'sky_diving': 'Fallschirmspringen',
    'snowshoeing': 'Schneeschuhwandern',
    'snowmobiling': 'Schneemobil',
    'stand_up_paddleboarding': 'Stand-Up-Paddling',
    'surfing': 'Surfen',
    'wakeboarding': 'Wakeboarden',
    'water_skiing': 'Wasserski',
    'kayaking': 'Kajakfahren',
    'rafting': 'Rafting',
    'windsurfing': 'Windsurfen',
    'kitesurfing': 'Kitesurfen',
    'tactical': 'Taktik',
    'jumpmaster': 'Jumpmaster',
    'boxing': 'Boxen',
    'floor_climbing': 'Treppensteigen',
    'baseball': 'Baseball',
    'diving': 'Tauchen',
    'shooting': 'Sportschießen',
    'winter_sport': 'Wintersport',
    'grinding': 'Grinding',
    'hiit': 'HIIT',
    'video_gaming': 'E-Sport',
    'racket': 'Racketsport',
    'wheelchair_push_walk': 'Rollstuhl Gehen',
    'wheelchair_push_run': 'Rollstuhl Laufen',
    'meditation': 'Meditation',
    'para_sport': 'Parasport',
    'disc_golf': 'Disc-Golf',
    'team_sport': 'Teamsport',
    'cricket': 'Cricket',
    'rugby': 'Rugby',
    'hockey': 'Hockey',
    'lacrosse': 'Lacrosse',
    'volleyball': 'Volleyball',
    'water_tubing': 'Water-Tubing',
    'wakesurfing': 'Wakesurfen',
    'water_sport': 'Wassersport',
    'archery': 'Bogenschießen',
    'mixed_martial_arts': 'MMA',
    'motor_sports': 'Motorsport',
    'snorkeling': 'Schnorcheln',
    'dance': 'Tanzen',
    'jump_rope': 'Seilspringen',
    'mobility': 'Mobilität',
    'other': 'Sonstiges',
  };

  _syncArbFile('lib/l10n/app_en.arb', items, (item) => item.name);
  _syncArbFile('lib/l10n/app_de.arb', items, (item) {
    if (germanNames.containsKey(item.key)) {
      return germanNames[item.key]!;
    }
    return item.name;
  });
}

void _syncArbFile(String path, List<WorkoutTypeItem> items,
    String Function(WorkoutTypeItem) getValue) {
  final file = File(path);
  if (!file.existsSync()) return;

  final jsonMap =
      Map<String, dynamic>.from(jsonDecode(file.readAsStringSync()) as Map);

  if (!jsonMap.containsKey('all')) {
    jsonMap['all'] = path.contains('_de') ? 'Alle' : 'All';
  }

  for (final item in items) {
    jsonMap[item.arbKey] = getValue(item);
  }

  final encoder = JsonEncoder.withIndent('  ');
  file.writeAsStringSync('${encoder.convert(jsonMap)}\n');
  print('Updated ARB file $path');
}

String _generateDartCode(List<WorkoutTypeItem> items) {
  final sb = StringBuffer();

  sb.writeln(
      '// Code generated by tool/generate_workout_types.dart; DO NOT EDIT.');
  sb.writeln();
  sb.writeln("import 'package:aepyornis_app/l10n/app_localizations.dart';");
  sb.writeln();
  sb.writeln(
      '/// Workout type configuration item generated from workout-types.yaml');
  sb.writeln('class WorkoutTypeOption {');
  sb.writeln('  const WorkoutTypeOption({');
  sb.writeln('    required this.value,');
  sb.writeln('    required this.name,');
  sb.writeln('    this.location = false,');
  sb.writeln('    this.distance = false,');
  sb.writeln('    this.repetition = false,');
  sb.writeln('    this.weight = false,');
  sb.writeln('    this.duration = true,');
  sb.writeln('    this.pace = false,');
  sb.writeln('    this.subTypes = const {},');
  sb.writeln('  });');
  sb.writeln();
  sb.writeln('  final String value;');
  sb.writeln('  final String name;');
  sb.writeln('  final bool location;');
  sb.writeln('  final bool distance;');
  sb.writeln('  final bool repetition;');
  sb.writeln('  final bool weight;');
  sb.writeln('  final bool duration;');
  sb.writeln('  final bool pace;');
  sb.writeln('  final Map<String, String> subTypes;');
  sb.writeln('}');
  sb.writeln();
  sb.writeln('/// All workout types defined in workout-types.yaml');
  sb.writeln('const List<WorkoutTypeOption> kWorkoutTypes = [');

  for (final item in items) {
    sb.writeln('  WorkoutTypeOption(');
    sb.writeln("    value: '${item.key}',");
    sb.writeln("    name: '${item.name.replaceAll("'", "\\'")}',");
    sb.writeln('    location: ${item.location},');
    sb.writeln('    distance: ${item.distance},');
    sb.writeln('    repetition: ${item.repetition},');
    sb.writeln('    weight: ${item.weight},');
    sb.writeln('    duration: ${item.duration},');
    sb.writeln('    pace: ${item.pace},');
    if (item.subTypes.isEmpty) {
      sb.writeln('    subTypes: {},');
    } else {
      sb.writeln('    subTypes: {');
      for (final sub in item.subTypes.entries) {
        sb.writeln(
            "      '${sub.key}': '${sub.value.replaceAll("'", "\\'")}',");
      }
      sb.writeln('    },');
    }
    sb.writeln('  ),');
  }

  sb.writeln('];');
  sb.writeln();

  sb.writeln('/// Map of workout type keys to WorkoutTypeOption');
  sb.writeln('final Map<String, WorkoutTypeOption> kWorkoutTypeMap = {');
  sb.writeln('  for (final option in kWorkoutTypes) option.value: option,');
  sb.writeln('};');
  sb.writeln();

  sb.writeln('/// Get WorkoutTypeOption by workout type string');
  sb.writeln('WorkoutTypeOption? getWorkoutTypeConfig(String? type) {');
  sb.writeln('  if (type == null) return null;');
  sb.writeln('  return kWorkoutTypeMap[type.toLowerCase().trim()];');
  sb.writeln('}');
  sb.writeln();

  sb.writeln(
      '/// Extension to lookup localized workout type names dynamically');
  sb.writeln('extension WorkoutTypeLocalizations on AppLocalizations {');
  sb.writeln('  String? getWorkoutTypeName(String type) {');
  sb.writeln('    switch (type.toLowerCase().trim()) {');
  for (final item in items) {
    sb.writeln("      case '${item.key}':");
    sb.writeln('        return ${item.arbKey};');
  }
  sb.writeln('      default:');
  sb.writeln('        return null;');
  sb.writeln('    }');
  sb.writeln('  }');
  sb.writeln('}');
  sb.writeln();

  return sb.toString();
}
