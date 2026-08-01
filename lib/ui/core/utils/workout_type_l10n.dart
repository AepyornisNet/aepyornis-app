import 'package:flutter/material.dart';
import 'package:aepyornis_app/domain/models/workout_type/workout_type.dart';
import 'package:aepyornis_app/l10n/app_localizations.dart';

/// Returns localized human-readable name for a given workout type key.
String getLocalizedWorkoutTypeName(BuildContext context, String? type) {
  if (type == null || type.trim().isEmpty) return '';

  final l10n = AppLocalizations.of(context);
  final normalized = type.toLowerCase().trim();

  if (normalized == 'all') {
    return l10n?.all ?? 'All';
  }

  if (l10n != null) {
    final localized = l10n.getWorkoutTypeName(normalized);
    if (localized != null && localized.isNotEmpty) {
      return localized;
    }
  }

  final config = kWorkoutTypeMap[normalized];
  if (config != null) {
    return config.name;
  }

  final formatted = normalized.replaceAll('-', ' ').replaceAll('_', ' ');
  return formatted[0].toUpperCase() + formatted.substring(1);
}
