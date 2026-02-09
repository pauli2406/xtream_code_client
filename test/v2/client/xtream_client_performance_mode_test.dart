import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  test('routes json/xml parsing through configured parse executor', () async {
    final recorder = _RecordingParseExecutor();
    final mock = MockClient((request) async {
      if (request.url.path.endsWith('/xmltv.php')) {
        return Response(
          '<tv><channel id=\"c1\"><display-name>C1</display-name></channel></tv>',
          200,
        );
      }
      return Response('[]', 200);
    });

    final client = XtreamClient(
      url: 'https://example.com',
      username: 'user',
      password: 'pass',
      httpClient: mock,
      parserOptions: const ParserOptions(
        mode: ParseMode.lenient,
        backgroundParsingMode: BackgroundParsingMode.always,
      ),
      parseExecutor: recorder,
    );

    await client.liveStreamCategoriesData();
    await client.epgLiteData();

    expect(recorder.calls, 2);
    expect(recorder.payloadTypes, <ParsePayloadType>[
      ParsePayloadType.json,
      ParsePayloadType.xml,
    ]);
    expect(
      recorder.modes,
      <BackgroundParsingMode>[
        BackgroundParsingMode.always,
        BackgroundParsingMode.always,
      ],
    );
    expect(recorder.payloadBytes.every((value) => value > 0), isTrue);
  });
}

class _RecordingParseExecutor extends ParseExecutor {
  int calls = 0;
  final List<ParsePayloadType> payloadTypes = <ParsePayloadType>[];
  final List<BackgroundParsingMode> modes = <BackgroundParsingMode>[];
  final List<int> payloadBytes = <int>[];

  @override
  Future<O> execute<I, O>({
    required I input,
    required ParseJob<I, O> job,
    required ParserOptions options,
    required ParsePayloadType payloadType,
    required int payloadBytes,
  }) async {
    calls++;
    payloadTypes.add(payloadType);
    modes.add(options.backgroundParsingMode);
    this.payloadBytes.add(payloadBytes);
    return job(input);
  }
}
