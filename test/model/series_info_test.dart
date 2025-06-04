import 'package:flutter_test/flutter_test.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  group('XTremeCodeSeriesItem', () {
    // Mock JSON with string values
    final mockJsonString = {
      'seasons': [
        {
          'air_date': '1980-09-13',
          'episode_count': '4',
          'id': '14542',
          'name': 'Extras',
          'overview': '',
          'season_number': '0',
          'cover': 'https://someurl.com/cover.jpg',
          'cover_big': 'https://someurl.com/cover.jpg',
        }
      ],
      'info': {
        'name': 'Some Series',
        'title': 'Some Series',
        'year': '1985',
        'cover': 'https://someimage.com/cover.jpg',
        'plot': 'Some Plot',
        'cast': 'Some Cast',
        'director': 'Some Director',
        'genre': 'Some Genre',
        'release_date': '1985-11-11',
        'releaseDate': '1985-11-11',
        'last_modified': '1678845321',
        'rating': '8',
        'rating_5based': 4,
        'backdrop_path': [
          'https://someurl.com/backdrop.jpg',
        ],
        'youtube_trailer': 'asddas212',
        'episode_run_time': '25',
        'category_id': '26',
        'category_ids': [26],
      },
      'episodes': {
        '1': [
          {
            'id': '225870',
            'episode_num': '1',
            'title': 'Some Title',
            'container_extension': 'mkv',
            'info': {
              'tmdb_id': '343786',
              'release_date': '1985-11-11',
              'plot': 'Some Plot',
              'duration_secs': '1459',
              'duration': '00:24:19',
              'movie_image': 'https://someurl.com/movie_image.jpg',
              'bitrate': '2177',
              'rating': '0',
              'season': '1',
              'cover_big': 'https://someurl.com/movie_image.jpg',
            },
            'subtitles': ['English'],
            'custom_sid': '',
            'added': '1678845306',
            'season': '1',
            'direct_source': '',
          },
        ],
      },
    };

    test('some values are strings', () {
      final item = XTremeCodeSeriesInfo.fromJson(mockJsonString);
      expect(item, isNotNull);
      expect(item.seasons, isNotNull);
      expect(item.seasons!.length, 1);
      final season = item.seasons![0];
      expect(season.airDate, DateTime.parse('1980-09-13'));
      expect(season.episodeCount, 4);
      expect(season.id, 14542);
      expect(season.name, 'Extras');
      expect(season.overview, '');
      expect(season.seasonNumber, 0);
      expect(season.cover, 'https://someurl.com/cover.jpg');
      expect(season.coverBig, 'https://someurl.com/cover.jpg');
      expect(item.info, isNotNull);
      expect(item.info.name, 'Some Series');
      expect(item.info.title, 'Some Series');
      expect(item.info.year, '1985');
      expect(item.info.cover, 'https://someimage.com/cover.jpg');
      expect(item.info.plot, 'Some Plot');
      expect(item.info.cast, 'Some Cast');
      expect(item.info.director, 'Some Director');
      expect(item.info.genre, 'Some Genre');
      expect(item.info.releaseDate, DateTime.parse('1985-11-11'));
      expect(item.info.lastModified, dateTimeFromEpochSeconds(1678845321));
      expect(item.info.rating, 8);
      expect(item.info.rating5based, 4);
      expect(item.info.backdropPath, ['https://someurl.com/backdrop.jpg']);
      expect(item.info.youtubeTrailer, 'asddas212');
      expect(item.info.episodeRunTime, 25);
      expect(item.info.categoryId, 26);
      expect(item.info.categoryIds, [26]);
      expect(item.episodes, isNotNull);
      expect(item.episodes?['1'], isNotNull);
      expect(item.episodes!.length, 1);
      final episode = item.episodes!['1']![0];
      expect(episode.id, 225870);
      expect(episode.episodeNum, 1);
      expect(episode.title, 'Some Title');
      expect(episode.containerExtension, 'mkv');
      expect(episode.info, isNotNull);
      expect(episode.info.tmdbId, 343786);
      expect(episode.info.releaseDate, DateTime.parse('1985-11-11'));
      expect(episode.info.plot, 'Some Plot');
      expect(episode.info.durationSecs, 1459);
      expect(episode.info.duration, '00:24:19');
      expect(episode.info.movieImage, 'https://someurl.com/movie_image.jpg');
      expect(episode.info.bitrate, 2177);
      expect(episode.info.rating, 0);
      expect(episode.info.season, 1);
      expect(episode.info.coverBig, 'https://someurl.com/movie_image.jpg');
      expect(episode.subtitles, ['English']);
      expect(episode.customSid, '');
      expect(episode.added, dateTimeFromEpochSeconds(1678845306));
      expect(episode.season, 1);
      expect(episode.directSource, '');
    });

    test('some values are numbers', () {
      final mockJsonString2 = {
        'seasons': [
          {
            'episode_count': 4,
            'id': 14542,
            'season_number': 0,
          }
        ],
        'info': {
          'last_modified': 1678845321,
          'rating': 8,
          'rating_5based': 4,
          'backdrop_path': <String>[],
          'episode_run_time': 25,
          'category_id': 26,
          'category_ids': <int>[],
        },
        'episodes': {
          '1': [
            {
              'id': 225870,
              'episode_num': 1,
              'info': {
                'tmdb_id': '343786',
                'duration_secs': '1459',
                'bitrate': '2177',
                'rating': '0',
                'season': '1',
              },
              'subtitles': <String>[],
              'added': 1678845306,
              'season': 1,
            },
          ],
        },
      };
      final item = XTremeCodeSeriesInfo.fromJson(mockJsonString2);
      expect(item, isNotNull);
      expect(item.seasons, isNotNull);
      expect(item.seasons!.length, 1);
      final season = item.seasons![0];
      expect(season.episodeCount, 4);
      expect(season.id, 14542);
      expect(season.seasonNumber, 0);
      expect(item.info, isNotNull);
      expect(item.info.lastModified, dateTimeFromEpochSeconds(1678845321));
      expect(item.info.rating, 8);
      expect(item.info.rating5based, 4);
      expect(item.info.backdropPath, <String>[]);
      expect(item.info.episodeRunTime, 25);
      expect(item.info.categoryId, 26);
      expect(item.info.categoryIds, <String>[]);
      expect(item.episodes, isNotNull);
      expect(item.episodes?['1'], isNotNull);
      expect(item.episodes!.length, 1);
      final episode = item.episodes!['1']![0];
      expect(episode.id, 225870);
      expect(episode.episodeNum, 1);
      expect(episode.info, isNotNull);
      expect(episode.info.tmdbId, 343786);
      expect(episode.info.durationSecs, 1459);
      expect(episode.info.bitrate, 2177);
      expect(episode.info.rating, 0);
      expect(episode.info.season, 1);
      expect(episode.subtitles, <String>[]);
      expect(episode.added, dateTimeFromEpochSeconds(1678845306));
      expect(episode.season, 1);
    });

    test('lists can contain nulls', () {
      final jsonWithNull = {
        ...mockJsonString as Map<String, dynamic>,
        'info': {
          ...(mockJsonString['info']! as Map<String, dynamic>),
          'backdrop_path': ['https://someurl.com/backdrop.jpg', null],
          'category_ids': [26, null],
        },
        'episodes': {
          '1': [
            {
              ...((mockJsonString['episodes']! as Map<String, dynamic>)['1']!
                  as List)[0] as Map<String, dynamic>,
              'subtitles': ['English', null],
            },
          ],
        },
      };

      final item = XTremeCodeSeriesInfo.fromJson(jsonWithNull);
      expect(item.info.backdropPath, ['https://someurl.com/backdrop.jpg']);
      expect(item.info.categoryIds, [26]);
      final episode = item.episodes?['1']?[0];
      expect(episode?.subtitles, ['English']);
    });
  });
}
