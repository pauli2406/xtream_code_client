import 'package:flutter_test/flutter_test.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  group('XTremeCodeSeriesItem', () {
    // Mock JSON with string values
    final mockJsonString = {
      'num': '1',
      'name': 'Some Series',
      'title': 'Some Series',
      'year': '2021',
      'stream_type': 'series',
      'series_id': '4142',
      'cover': 'https://someimage.com/cover.jpg',
      'plot': 'Some plot',
      'cast': 'Some cast',
      'director': 'Some director',
      'genre': 'Documentary',
      'release_date': '2021-07-30',
      'releaseDate': '2021-07-30',
      'last_modified': '1678846210',
      'rating': '9',
      'rating_5based': '4.5',
      'backdrop_path': [
        'https://someurl.com/backdrop.jpg',
      ],
      'youtube_trailer': 'sad2122e',
      'episode_run_time': '42',
      'category_id': '141',
      'category_ids': [141],
    };

    test('some values are strings', () {
      final item = XTremeCodeSeriesItem.fromJson(mockJsonString);
      expect(item, isNotNull);
      expect(item.num, 1);
      expect(item.name, 'Some Series');
      expect(item.title, 'Some Series');
      expect(item.year, '2021');
      expect(item.streamType, 'series');
      expect(item.seriesId, 4142);
      expect(item.cover, 'https://someimage.com/cover.jpg');
      expect(item.plot, 'Some plot');
      expect(item.cast, 'Some cast');
      expect(item.director, 'Some director');
      expect(item.genre, 'Documentary');
      expect(item.releaseDate, '2021-07-30');
      expect(item.lastModified, dateTimeFromEpochSeconds(1678846210));
      expect(item.rating, 9);
      expect(item.rating5based, 4.5);
      expect(item.backdropPath, ['https://someurl.com/backdrop.jpg']);
      expect(item.youtubeTrailer, 'sad2122e');
      expect(item.episodeRunTime, 42);
      expect(item.categoryId, 141);
      expect(item.categoryIds, [141]);
    });

    test('some values are numbers', () {
      final mockJsonString2 = {
        ...mockJsonString,
        'num': 1,
        'series_id': 4142,
        'last_modified': 1678846210,
        'rating': 9,
        'rating_5based': 4.5,
        'episode_run_time': 42,
        'category_id': 141,
      };
      final item = XTremeCodeSeriesItem.fromJson(mockJsonString2);
      expect(item, isNotNull);
      expect(item.num, 1);
      expect(item.seriesId, 4142);
      expect(item.lastModified, dateTimeFromEpochSeconds(1678846210));
      expect(item.rating, 9);
      expect(item.rating5based, 4.5);
      expect(item.episodeRunTime, 42);
      expect(item.categoryId, 141);
    });

    test('lists can contain nulls', () {
      final jsonWithNull = {
        ...mockJsonString,
        'backdrop_path': ['https://someurl.com/backdrop.jpg', null],
        'category_ids': [141, null],
      };

      final item = XTremeCodeSeriesItem.fromJson(jsonWithNull);
      expect(item.backdropPath, ['https://someurl.com/backdrop.jpg']);
      expect(item.categoryIds, [141]);
    });
  });
}
