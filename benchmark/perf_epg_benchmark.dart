import 'dart:math';

import 'package:xtream_code_client/src/epg_parser.dart';
import 'package:xtream_code_client/src/v2/mapper/epg_lite_parser.dart';

void main() {
  final xml = _buildXml(channels: 3000, programmes: 12000);

  _bench('epg.full_parse', () {
    EpgParser().parse(xml);
  }, runs: 3);

  _bench('epg.lite_parse', () {
    EpgLiteParser().parse(xml);
  }, runs: 3);
}

String _buildXml({
  required int channels,
  required int programmes,
}) {
  final buffer = StringBuffer('<tv>');
  for (var index = 0; index < channels; index++) {
    buffer.write(
      '<channel id=\"ch$index\"><display-name>Channel $index</display-name></channel>',
    );
  }

  for (var index = 0; index < programmes; index++) {
    final channel = index % max(1, channels);
    buffer.write(
      '<programme start=\"20240101120000 +0000\" stop=\"20240101130000 +0000\" channel=\"ch$channel\">'
      '<title>Programme $index</title><desc>Description $index</desc></programme>',
    );
  }
  buffer.write('</tv>');
  return buffer.toString();
}

void _bench(
  String label,
  void Function() run, {
  int runs = 5,
}) {
  for (var i = 0; i < 1; i++) {
    run();
  }

  final stopwatch = Stopwatch()..start();
  for (var i = 0; i < runs; i++) {
    run();
  }
  stopwatch.stop();

  final avgMs = stopwatch.elapsedMicroseconds / runs / 1000;
  // ignore: avoid_print
  print('$label: ${avgMs.toStringAsFixed(2)} ms avg');
}
