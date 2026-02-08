import 'package:test/test.dart';
import 'package:xtream_code_client/src/v2/mapper/epg_lite_parser.dart';

void main() {
  test('parses channels and programmes from xmltv input', () {
    const xml = '''
<tv>
  <channel id=\"c1\">
    <display-name>Channel One</display-name>
    <display-name>Kanal Eins</display-name>
  </channel>
  <programme start=\"20240101120000 +0000\" stop=\"20240101130000 +0000\" channel=\"c1\">
    <title>News</title>
    <desc>Morning news</desc>
  </programme>
</tv>
''';

    final epg = EpgLiteParser().parse(xml);

    expect(epg.channels.length, 1);
    expect(epg.channels.first.id, 'c1');
    expect(
        epg.channels.first.displayNames, <String>['Channel One', 'Kanal Eins']);

    expect(epg.programmes.length, 1);
    expect(epg.programmes.first.channelId, 'c1');
    expect(epg.programmes.first.title, 'News');
    expect(epg.programmes.first.description, 'Morning news');
    expect(epg.programmes.first.start, DateTime.utc(2024, 1, 1, 12));
    expect(epg.programmes.first.stop, DateTime.utc(2024, 1, 1, 13));
  });
}
