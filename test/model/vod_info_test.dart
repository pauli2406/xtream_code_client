import 'package:flutter_test/flutter_test.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  group('XTremeCodeVodItem', () {
    // Mock JSON with string values
    final mockJsonString = {
      'info': {
        'kinopoisk_url': 'https://www.some.com',
        'tmdb_id': '955916',
        'name': 'Movie',
        'o_name': 'Movie',
        'cover_big': 'https://www.some.com',
        'movie_image': 'https://www.some.com',
        'release_date': '2024-01-12',
        'episode_run_time': '106',
        'youtube_trailer': 'asdasd12',
        'director': 'Director',
        'actors': 'Actor',
        'cast': 'Cast',
        'description': 'Description',
        'plot': 'Plooot',
        'age': '1993',
        'mpaa_rating': '',
        'rating_count_kinopoisk': '0',
        'country': 'United States of America',
        'genre': 'Action, Komödie, Krimi',
        'backdrop_path': [
          'https://someurl.com',
        ],
        'duration_secs': '6403',
        'duration': '01:46:43',
        'bitrate': '3841',
        'rating': '10',
        'releasedate': '2024-01-12',
        'subtitles': ['de'],
      },
      'movie_data': {
        'stream_id': '344391',
        'name': 'Movie',
        'title': 'Movie',
        'year': '2024',
        'added': '1705050604',
        'category_id': '295',
        'category_ids': [295],
        'container_extension': 'mkv',
        'custom_sid': '',
        'direct_source': '',
      },
    };
    test('some values are strings', () {
      final item = XTremeCodeVodInfo.fromJson(mockJsonString);
      expect(item, isNotNull);
      expect(item.info, isNotNull);
      expect(item.info.kinopoiskUrl, 'https://www.some.com');
      expect(item.info.tmdbId, 955916);
      expect(item.info.name, 'Movie');
      expect(item.info.oName, 'Movie');
      expect(item.info.coverBig, 'https://www.some.com');
      expect(item.info.movieImage, 'https://www.some.com');
      expect(item.info.releaseDate, DateTime.parse('2024-01-12'));
      expect(item.info.episodeRunTime, 106);
      expect(item.info.youtubeTrailer, 'asdasd12');
      expect(item.info.director, 'Director');
      expect(item.info.actors, 'Actor');
      expect(item.info.cast, 'Cast');
      expect(item.info.description, 'Description');
      expect(item.info.plot, 'Plooot');
      expect(item.info.age, '1993');
      expect(item.info.mpaaRating, '');
      expect(item.info.ratingCountKinopoisk, 0);
      expect(item.info.country, 'United States of America');
      expect(item.info.genre, 'Action, Komödie, Krimi');
      expect(item.info.backdropPath, ['https://someurl.com']);
      expect(item.info.durationSecs, 6403);
      expect(item.info.duration, '01:46:43');
      expect(item.info.bitrate, 3841);
      expect(item.info.rating, 10);
      expect(item.info.releasedate, DateTime.parse('2024-01-12'));
      expect(item.info.subtitles, ['de']);

      expect(item.movieData, isNotNull);
      expect(item.movieData.streamId, 344391);
      expect(item.movieData.name, 'Movie');
      expect(item.movieData.title, 'Movie');
      expect(item.movieData.year, '2024');
      expect(item.movieData.added, dateTimeFromEpochSeconds(1705050604));
      expect(item.movieData.categoryId, 295);
      expect(item.movieData.categoryIds, [295]);
      expect(item.movieData.containerExtension, 'mkv');
      expect(item.movieData.customSid, '');
      expect(item.movieData.directSource, '');
    });

    test('some values are numbers', () {
      final mockJsonString2 = {
        ...mockJsonString,
        'info': {
          ...?mockJsonString['info'],
          'tmdb_id': '955916',
          'release_date': '2024-01-12',
          'episode_run_time': 106,
          'rating_count_kinopoisk': '0',
          'duration_secs': '6403',
          'bitrate': '3841',
          'rating': '10',
          'releasedate': '2024-01-12',
        },
        'movie_data': {
          ...?mockJsonString['movie_data'],
          'stream_id': 344391,
          'added': 1705050604,
          'category_id': 295,
        },
      };
      final item = XTremeCodeVodInfo.fromJson(mockJsonString2);
      expect(item, isNotNull);
      expect(item.info, isNotNull);
      expect(item.info.tmdbId, 955916);
      expect(item.info.releaseDate, DateTime.parse('2024-01-12'));
      expect(item.info.episodeRunTime, 106);
      expect(item.info.ratingCountKinopoisk, 0);
      expect(item.info.durationSecs, 6403);
      expect(item.info.bitrate, 3841);
      expect(item.info.rating, 10);
      expect(item.info.releasedate, DateTime.parse('2024-01-12'));

      expect(item.movieData, isNotNull);
      expect(item.movieData.streamId, 344391);
      expect(item.movieData.added, dateTimeFromEpochSeconds(1705050604));
      expect(item.movieData.categoryId, 295);
    });
  });
}
