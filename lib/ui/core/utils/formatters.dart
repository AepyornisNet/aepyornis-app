String formatWorkoutDuration(int totalSeconds) {
  if (totalSeconds <= 0) return '0s';
  final hours = totalSeconds ~/ 3600;
  final minutes = (totalSeconds % 3600) ~/ 60;
  final seconds = totalSeconds % 60;

  if (hours > 0) {
    if (minutes > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${hours}h';
  }
  if (minutes > 0) {
    if (seconds > 0) {
      return '${minutes}m ${seconds}s';
    }
    return '${minutes}m';
  }
  return '${seconds}s';
}
