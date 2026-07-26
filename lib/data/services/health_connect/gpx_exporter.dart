import 'package:health_connector/health_connector.dart';

class GpxExporter {
  static String buildGpx({
    required String title,
    required String activityType,
    required DateTime startTime,
    required List<ExerciseRouteLocation> locations,
    Map<DateTime, int> heartRates = const {},
    Map<DateTime, int> cadences = const {},
    Map<DateTime, double> powers = const {},
  }) {
    final buf = StringBuffer();
    buf.writeln('<?xml version="1.0" encoding="UTF-8"?>');
    buf.writeln('<gpx version="1.1" creator="Workout Tracker App"');
    buf.writeln('  xmlns="http://www.topografix.com/GPX/1/1"');
    buf.writeln('  xmlns:gpxtpx="http://www.garmin.com/xmlschemas/TrackPointExtension/v1">');
    buf.writeln('  <metadata>');
    buf.writeln('    <name>${_escapeXml(title)}</name>');
    buf.writeln('    <time>${startTime.toUtc().toIso8601String()}</time>');
    buf.writeln('  </metadata>');
    buf.writeln('  <trk>');
    buf.writeln('    <name>${_escapeXml(title)}</name>');
    buf.writeln('    <type>${_escapeXml(activityType)}</type>');
    buf.writeln('    <trkseg>');

    for (final loc in locations) {
      buf.write('      <trkpt lat="${loc.latitude}" lon="${loc.longitude}">');
      if (loc.altitude != null) {
        buf.write('<ele>${loc.altitude!.inMeters.toStringAsFixed(2)}</ele>');
      }
      buf.write('<time>${loc.time.toUtc().toIso8601String()}</time>');

      final hr = _findClosestMetric(loc.time, heartRates);
      final cad = _findClosestMetric(loc.time, cadences);
      final pwr = _findClosestMetric(loc.time, powers);

      if (hr != null || cad != null || pwr != null) {
        buf.write('<extensions>');
        if (hr != null || cad != null) {
          buf.write('<gpxtpx:TrackPointExtension>');
          if (hr != null) {
            buf.write('<gpxtpx:hr>$hr</gpxtpx:hr>');
          }
          if (cad != null) {
            buf.write('<gpxtpx:cad>$cad</gpxtpx:cad>');
          }
          buf.write('</gpxtpx:TrackPointExtension>');
        }
        if (pwr != null) {
          buf.write('<power>${pwr.round()}</power>');
        }
        buf.write('</extensions>');
      }

      buf.writeln('</trkpt>');
    }

    buf.writeln('    </trkseg>');
    buf.writeln('  </trk>');
    buf.writeln('</gpx>');

    return buf.toString();
  }

  static T? _findClosestMetric<T>(DateTime targetTime, Map<DateTime, T> metrics) {
    if (metrics.isEmpty) {
      return null;
    }
    T? closestValue;
    int minDiff = 15; // 15-second window
    metrics.forEach((time, val) {
      final diff = time.difference(targetTime).inSeconds.abs();
      if (diff < minDiff) {
        minDiff = diff;
        closestValue = val;
      }
    });
    return closestValue;
  }

  static String _escapeXml(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&apos;');
  }
}
