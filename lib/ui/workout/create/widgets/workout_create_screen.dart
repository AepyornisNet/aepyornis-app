import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracker_app/l10n/app_localizations.dart';
import 'package:workout_tracker_app/routing/routes.dart';
import 'package:workout_tracker_app/ui/core/utils/workout_type_l10n.dart';
import 'package:workout_tracker_app/ui/workout/create/view_models/workout_create_viewmodel.dart';

class WorkoutCreateScreen extends StatefulWidget {
  const WorkoutCreateScreen({super.key, required this.viewModel});

  final WorkoutCreateViewModel viewModel;

  @override
  State<WorkoutCreateScreen> createState() => _WorkoutCreateScreenState();
}

class _WorkoutCreateScreenState extends State<WorkoutCreateScreen> {
  final _manualFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.viewModel.loadInitialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.addWorkout),
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, _) {
            final vm = widget.viewModel;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Mode Switcher
                  SegmentedButton<int>(
                    segments: [
                      ButtonSegment<int>(
                        value: 0,
                        label: Text(l10n.useAFile),
                        icon: const Icon(Icons.upload_file_rounded, size: 18),
                      ),
                      ButtonSegment<int>(
                        value: 1,
                        label: Text(l10n.manual),
                        icon: const Icon(Icons.edit_note_rounded, size: 18),
                      ),
                    ],
                    selected: {vm.selectedTabIndex},
                    onSelectionChanged: (newSelection) {
                      if (newSelection.isNotEmpty) {
                        vm.setSelectedTab(newSelection.first);
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  // Messages Banners
                  if (vm.successMessage != null) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green.shade400),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green.shade800),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              vm.successMessage!,
                              style: TextStyle(color: Colors.green.shade900),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (vm.errorMessage != null) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colorScheme.error),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error, color: colorScheme.error),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              vm.errorMessage!,
                              style: TextStyle(color: colorScheme.onErrorContainer),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Content based on selected tab
                  if (vm.selectedTabIndex == 0)
                    _buildFileUploadTab(context, vm, l10n, colorScheme)
                  else
                    _buildManualFormTab(context, vm, l10n, colorScheme),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFileUploadTab(
    BuildContext context,
    WorkoutCreateViewModel vm,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.useAFile,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            // Pick File Dropzone / Button
            InkWell(
              onTap: vm.isLoading ? null : vm.pickFiles,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.5),
                    style: BorderStyle.solid,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: colorScheme.primaryContainer.withValues(alpha: 0.15),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 40,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.selectFile,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Supports .fit, .gpx, .tcx, .zip',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // List of selected files
            if (vm.selectedFiles.isNotEmpty) ...[
              ...vm.selectedFiles.asMap().entries.map((entry) {
                final idx = entry.key;
                final file = entry.value;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.insert_drive_file,
                          size: 20, color: colorScheme.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          file.name,
                          style: const TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        onPressed:
                            vm.isLoading ? null : () => vm.removeFile(idx),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 16),
            ],

            // Type Dropdown
            DropdownButtonFormField<String>(
              initialValue: vm.fileUploadType,
              decoration: InputDecoration(
                labelText: l10n.workoutType,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: [
                DropdownMenuItem<String>(
                  value: 'auto',
                  child: Text(l10n.autoDetect),
                ),
                ...kWorkoutTypes.map((wt) {
                  return DropdownMenuItem<String>(
                    value: wt.value,
                    child: Text(getLocalizedWorkoutTypeName(context, wt.value)),
                  );
                }),
              ],
              onChanged: vm.isLoading
                  ? null
                  : (val) {
                      if (val != null) vm.setFileUploadType(val);
                    },
            ),
            const SizedBox(height: 16),

            // Notes Text Field
            TextField(
              decoration: InputDecoration(
                labelText: l10n.notes,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 3,
              enabled: !vm.isLoading,
              onChanged: vm.setFileNotes,
            ),
            const SizedBox(height: 24),

            // Submit Button
            FilledButton.icon(
              onPressed: vm.isLoading || vm.selectedFiles.isEmpty
                  ? null
                  : () async {
                      final result = await vm.uploadFiles();
                      if (result.isSuccess() && context.mounted) {
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          if (context.mounted) {
                            context.go(Routes.workouts);
                          }
                        });
                      }
                    },
              icon: vm.isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.check_rounded),
              label: Text(l10n.addWorkout),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManualFormTab(
    BuildContext context,
    WorkoutCreateViewModel vm,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _manualFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.manual,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),

              // Workout Type Dropdown
              DropdownButtonFormField<String>(
                initialValue: vm.manualWorkoutType.isEmpty
                    ? null
                    : vm.manualWorkoutType,
                decoration: InputDecoration(
                  labelText: l10n.workoutType,
                  hintText: l10n.selectWorkoutType,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: kWorkoutTypes.map((wt) {
                  return DropdownMenuItem<String>(
                    value: wt.value,
                    child: Text(getLocalizedWorkoutTypeName(context, wt.value)),
                  );
                }).toList(),
                onChanged: vm.isLoading
                    ? null
                    : (val) {
                        if (val != null) {
                          vm.setManualWorkoutType(
                            val,
                            getLocalizedWorkoutTypeName(context, val),
                          );
                        }
                      },
                validator: (val) => val == null || val.isEmpty
                    ? l10n.selectWorkoutType
                    : null,
              ),
              const SizedBox(height: 16),

              if (vm.manualWorkoutType.isNotEmpty) ...[
                // Custom Type
                if (vm.showCustomType) ...[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: l10n.customType,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    enabled: !vm.isLoading,
                    onChanged: vm.setCustomType,
                  ),
                  const SizedBox(height: 16),
                ],

                // Name
                TextFormField(
                  initialValue: vm.name,
                  decoration: InputDecoration(
                    labelText: l10n.name,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  enabled: !vm.isLoading,
                  onChanged: vm.setName,
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),

                // Date & Time Picker
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.date),
                  subtitle: Text(
                    DateFormat('yyyy-MM-dd HH:mm').format(vm.date),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  trailing: const Icon(Icons.calendar_today_rounded),
                  onTap: vm.isLoading
                      ? null
                      : () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: vm.date,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null && context.mounted) {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(vm.date),
                            );
                            if (pickedTime != null) {
                              vm.setDate(
                                DateTime(
                                  pickedDate.year,
                                  pickedDate.month,
                                  pickedDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                ),
                              );
                            }
                          }
                        },
                ),
                const SizedBox(height: 16),

                // Visibility Dropdown
                DropdownButtonFormField<String>(
                  initialValue: vm.visibility,
                  decoration: InputDecoration(
                    labelText: l10n.visibility,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: [
                    DropdownMenuItem<String>(
                      value: '',
                      child: Text(l10n.private),
                    ),
                    DropdownMenuItem<String>(
                      value: 'followers',
                      child: Text(l10n.followers),
                    ),
                    DropdownMenuItem<String>(
                      value: 'public',
                      child: Text(l10n.public),
                    ),
                  ],
                  onChanged: vm.isLoading
                      ? null
                      : (val) {
                          if (val != null) vm.setVisibility(val);
                        },
                ),
                const SizedBox(height: 16),

                // Location (if supported)
                if (vm.showLocation) ...[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: l10n.location,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    enabled: !vm.isLoading,
                    onChanged: vm.setLocation,
                  ),
                  const SizedBox(height: 16),
                ],

                // Duration (if supported)
                if (vm.showDuration) ...[
                  Text(
                    l10n.total_duration,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: l10n.durationHours,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          enabled: !vm.isLoading,
                          onChanged: (val) =>
                              vm.setDurationHours(int.tryParse(val) ?? 0),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: l10n.durationMinutes,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          enabled: !vm.isLoading,
                          onChanged: (val) =>
                              vm.setDurationMinutes(int.tryParse(val) ?? 0),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: l10n.durationSeconds,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          enabled: !vm.isLoading,
                          onChanged: (val) =>
                              vm.setDurationSeconds(int.tryParse(val) ?? 0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],

                // Distance (if supported)
                if (vm.showDistance) ...[
                  TextFormField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: l10n.distanceKm,
                      suffixText: 'km',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    enabled: !vm.isLoading,
                    onChanged: (val) =>
                        vm.setDistanceKm(double.tryParse(val) ?? 0.0),
                  ),
                  const SizedBox(height: 16),
                ],

                // Repetitions (if supported)
                if (vm.showRepetitions) ...[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: l10n.repetitions,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    enabled: !vm.isLoading,
                    onChanged: (val) =>
                        vm.setRepetitions(int.tryParse(val) ?? 0),
                  ),
                  const SizedBox(height: 16),
                ],

                // Weight (if supported)
                if (vm.showWeight) ...[
                  TextFormField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: l10n.weight,
                      suffixText: 'kg',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    enabled: !vm.isLoading,
                    onChanged: (val) =>
                        vm.setWeightKg(double.tryParse(val) ?? 0.0),
                  ),
                  const SizedBox(height: 16),
                ],

                // Equipment Selection
                if (vm.equipmentList.isNotEmpty) ...[
                  Text(
                    l10n.equipment,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: vm.equipmentList.map((eq) {
                      if (eq.id == null) return const SizedBox.shrink();
                      final isSelected =
                          vm.selectedEquipmentIds.contains(eq.id!);
                      return FilterChip(
                        label: Text(eq.name),
                        selected: isSelected,
                        onSelected: vm.isLoading
                            ? null
                            : (_) => vm.toggleEquipment(eq.id!),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],

                // Notes
                TextFormField(
                  decoration: InputDecoration(
                    labelText: l10n.notes,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 4,
                  enabled: !vm.isLoading,
                  onChanged: vm.setManualNotes,
                ),
                const SizedBox(height: 24),

                // Save Button
                FilledButton.icon(
                  onPressed: vm.isLoading
                      ? null
                      : () async {
                          if (_manualFormKey.currentState?.validate() ?? false) {
                            final result = await vm.submitManualWorkout();
                            if (result.isSuccess() && context.mounted) {
                              final created = result.getOrThrow();
                              if (created.id != null) {
                                context.go(Routes.workoutWithId(created.id!));
                              } else {
                                context.go(Routes.workouts);
                              }
                            }
                          }
                        },
                  icon: vm.isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.check_rounded),
                  label: Text(l10n.createWorkout),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
