import 'dart:convert';

import 'package:xtream_code_client/src/v2/core/parse_context.dart';
import 'package:xtream_code_client/src/v2/core/value_parser.dart';
import 'package:xtream_code_client/src/v2/mapper/live_stream_mapper.dart';
import 'package:xtream_code_client/src/v2/mapper/series_mapper.dart';
import 'package:xtream_code_client/src/v2/mapper/vod_mapper.dart';

void main() {
  const itemCount = 15000;

  final streams = List<Map<String, dynamic>>.generate(itemCount, (index) {
    return <String, dynamic>{
      'num': '$index',
      'name': 'Live $index',
      'stream_type': 'live',
      'stream_id': '${index + 1000}',
      'stream_icon': 'https://cdn/$index.png',
      'epg_channel_id': 'epg_$index',
      'added': '1713304800',
      'custom_sid': '${index % 10}',
      'tv_archive': index.isEven ? '1' : '0',
      'direct_source': '',
      'tv_archive_duration': '${index % 24}',
      'category_id': '${index % 300}',
      'category_ids': <String>['${index % 300}', '${(index + 1) % 300}'],
      'thumbnail': null,
    };
  });

  final vods = List<Map<String, dynamic>>.generate(itemCount, (index) {
    return <String, dynamic>{
      'stream_id': '$index',
      'num': '$index',
      'name': 'Vod $index',
      'title': 'Vod $index',
      'year': '2024',
      'stream_type': 'movie',
      'stream_icon': 'https://cdn/$index.jpg',
      'rating': '4.5',
      'rating_5based': '4.5',
      'added': '1713304800',
      'category_id': '${index % 200}',
      'category_ids': <String>['${index % 200}', '${(index + 1) % 200}'],
      'container_extension': 'mp4',
      'custom_sid': null,
      'direct_source': '',
    };
  });

  final series = List<Map<String, dynamic>>.generate(itemCount, (index) {
    return <String, dynamic>{
      'num': '$index',
      'name': 'Series $index',
      'title': 'Series $index',
      'year': '2024',
      'stream_type': 'series',
      'series_id': '$index',
      'cover': 'https://cdn/$index.jpg',
      'plot': 'Plot',
      'cast': 'Cast',
      'director': 'Director',
      'genre': 'Drama',
      'release_date': '2024-01-01',
      'last_modified': '1713304800',
      'rating': '4.5',
      'rating_5based': '4.5',
      'backdrop_path': <String>['a', 'b'],
      'episode_run_time': '45',
      'category_id': '${index % 200}',
      'category_ids': <String>['${index % 200}', '${(index + 1) % 200}'],
    };
  });

  final encoded = jsonEncode(streams);
  _bench('json.decode (streams x$itemCount)', () => jsonDecode(encoded));

  _bench('mapper.live_streams', () {
    final context = ParseContext();
    LiveStreamMapper.fromList(streams, context, r'$');
  });

  _bench('mapper.vod_items', () {
    final context = ParseContext();
    VodMapper.itemsFromList(vods, context, r'$');
  });

  _bench('mapper.series_items', () {
    final context = ParseContext();
    SeriesMapper.itemsFromList(series, context, r'$');
  });

  _bench('path.overhead.constant_path', () {
    final context = ParseContext();
    for (var index = 0; index < 500000; index++) {
      ValueParser.asInt('123', context, r'$.x');
    }
  });

  _bench('path.overhead.dynamic_path', () {
    final context = ParseContext();
    for (var index = 0; index < 500000; index++) {
      ValueParser.asInt('123', context, '\$[$index].x');
    }
  });
}

void _bench(String label, void Function() run, {int runs = 5}) {
  for (var i = 0; i < 2; i++) {
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
