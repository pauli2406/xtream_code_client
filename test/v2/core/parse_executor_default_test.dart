import 'dart:io';

import 'package:test/test.dart';
import 'package:xtream_code_client/src/v2/core/parse_executor.dart';
import 'package:xtream_code_client/src/v2/core/parse_executor_default.dart';
import 'package:xtream_code_client/src/v2/core/parser_options.dart';

void main() {
  group('DefaultParseExecutor', () {
    test('propagates parse job errors without running the job twice', () async {
      final executor = const DefaultParseExecutor();
      final tempDir = await Directory.systemTemp.createTemp(
        'parse_executor_default_test_',
      );
      final markerFile = File('${tempDir.path}/calls.txt');

      addTearDown(() async {
        if (await tempDir.exists()) {
          await tempDir.delete(recursive: true);
        }
      });

      Future<int> run() {
        return executor.execute<String, int>(
          input: markerFile.path,
          options: const ParserOptions(
            backgroundParsingMode: BackgroundParsingMode.always,
          ),
          payloadType: ParsePayloadType.json,
          payloadBytes: 200000,
          job: (path) {
            File(path).writeAsStringSync('call\n', mode: FileMode.append);
            throw StateError('parse job failed');
          },
        );
      }

      await expectLater(run(), throwsA(isA<StateError>()));

      final lines = markerFile.existsSync()
          ? markerFile.readAsLinesSync()
          : <String>[];
      expect(lines, hasLength(1));
    });

    test('runs synchronously when background parsing mode is off', () async {
      final executor = const DefaultParseExecutor();
      var calls = 0;

      final result = await executor.execute<int, int>(
        input: 3,
        options: const ParserOptions(
          backgroundParsingMode: BackgroundParsingMode.off,
        ),
        payloadType: ParsePayloadType.json,
        payloadBytes: 200000,
        job: (value) {
          calls++;
          return value + 1;
        },
      );

      expect(result, 4);
      expect(calls, 1);
    });
  });
}
