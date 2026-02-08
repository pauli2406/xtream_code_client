import 'package:xtream_code_client/src/v2/core/field_aliases.dart';
import 'package:xtream_code_client/src/v2/core/parse_context.dart';
import 'package:xtream_code_client/src/v2/core/value_parser.dart';
import 'package:xtream_code_client/src/v2/model/vod_info.dart';
import 'package:xtream_code_client/src/v2/model/vod_item.dart';
import 'package:xtream_code_client/src/v2/normalizer/response_normalizer.dart';

class VodMapper {
  static VodItem itemFromMap(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    return VodItem(
      streamId:
          ValueParser.asInt(json['stream_id'], context, '$jsonPath.stream_id'),
      num: ValueParser.asInt(json['num'], context, '$jsonPath.num'),
      name: ValueParser.asString(json['name'], context, '$jsonPath.name'),
      title: ValueParser.asString(json['title'], context, '$jsonPath.title'),
      year: ValueParser.asString(json['year'], context, '$jsonPath.year'),
      streamType: ValueParser.asString(
          json['stream_type'], context, '$jsonPath.stream_type'),
      streamIcon: ValueParser.asString(
          json['stream_icon'], context, '$jsonPath.stream_icon'),
      rating: ValueParser.asDouble(json['rating'], context, '$jsonPath.rating'),
      rating5based: ValueParser.asDouble(
        json['rating_5based'],
        context,
        '$jsonPath.rating_5based',
      ),
      added:
          ValueParser.asDateTimeUtc(json['added'], context, '$jsonPath.added'),
      categoryId: ValueParser.asInt(
          json['category_id'], context, '$jsonPath.category_id'),
      categoryIds: ValueParser.asIntList(
          json['category_ids'], context, '$jsonPath.category_ids'),
      containerExtension: ValueParser.asString(
        json['container_extension'],
        context,
        '$jsonPath.container_extension',
      ),
      customSid: ValueParser.asString(
          json['custom_sid'], context, '$jsonPath.custom_sid'),
      directSource: ValueParser.asString(
        json['direct_source'],
        context,
        '$jsonPath.direct_source',
      ),
    );
  }

  static List<VodItem> itemsFromList(
    List<Map<String, dynamic>> items,
    ParseContext context,
    String jsonPath,
  ) {
    final result = <VodItem>[];
    for (var index = 0; index < items.length; index++) {
      result.add(itemFromMap(items[index], context, '$jsonPath[$index]'));
    }
    return result;
  }

  static VodInfo infoFromMap(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    final infoJson =
        ResponseNormalizer.readObjectField(json, 'info', context, jsonPath);
    final movieJson = ResponseNormalizer.readObjectField(
      json,
      'movie_data',
      context,
      jsonPath,
    );

    return VodInfo(
      info: _details(infoJson, context, '$jsonPath.info'),
      movieData: _movieData(movieJson, context, '$jsonPath.movie_data'),
    );
  }

  static VodDetails _details(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    final releaseDateRaw = FieldAliases.resolve(
      json,
      <String>['release_date', 'releaseDate', 'releasedate'],
      context,
      '$jsonPath.releaseDate',
    );

    return VodDetails(
      kinopoiskUrl: ValueParser.asString(
        json['kinopoisk_url'],
        context,
        '$jsonPath.kinopoisk_url',
      ),
      tmdbId: ValueParser.asInt(json['tmdb_id'], context, '$jsonPath.tmdb_id'),
      name: ValueParser.asString(json['name'], context, '$jsonPath.name'),
      oName: ValueParser.asString(json['o_name'], context, '$jsonPath.o_name'),
      coverBig: ValueParser.asString(
          json['cover_big'], context, '$jsonPath.cover_big'),
      movieImage: ValueParser.asString(
          json['movie_image'], context, '$jsonPath.movie_image'),
      releaseDate: ValueParser.asDateTimeUtc(
          releaseDateRaw, context, '$jsonPath.releaseDate'),
      episodeRunTime: ValueParser.asInt(
        json['episode_run_time'],
        context,
        '$jsonPath.episode_run_time',
      ),
      youtubeTrailer: ValueParser.asString(
        json['youtube_trailer'],
        context,
        '$jsonPath.youtube_trailer',
      ),
      director:
          ValueParser.asString(json['director'], context, '$jsonPath.director'),
      actors: ValueParser.asString(json['actors'], context, '$jsonPath.actors'),
      cast: ValueParser.asString(json['cast'], context, '$jsonPath.cast'),
      description: ValueParser.asString(
        json['description'],
        context,
        '$jsonPath.description',
      ),
      plot: ValueParser.asString(json['plot'], context, '$jsonPath.plot'),
      age: ValueParser.asString(json['age'], context, '$jsonPath.age'),
      mpaaRating: ValueParser.asString(
        json['mpaa_rating'],
        context,
        '$jsonPath.mpaa_rating',
      ),
      ratingCountKinopoisk: ValueParser.asInt(
        json['rating_count_kinopoisk'],
        context,
        '$jsonPath.rating_count_kinopoisk',
      ),
      country:
          ValueParser.asString(json['country'], context, '$jsonPath.country'),
      genre: ValueParser.asString(json['genre'], context, '$jsonPath.genre'),
      backdropPath: ValueParser.asStringList(
        json['backdrop_path'],
        context,
        '$jsonPath.backdrop_path',
      ),
      durationSecs: ValueParser.asInt(
          json['duration_secs'], context, '$jsonPath.duration_secs'),
      duration:
          ValueParser.asString(json['duration'], context, '$jsonPath.duration'),
      bitrate: ValueParser.asInt(json['bitrate'], context, '$jsonPath.bitrate'),
      rating: ValueParser.asDouble(json['rating'], context, '$jsonPath.rating'),
      subtitles: ValueParser.asStringList(
          json['subtitles'], context, '$jsonPath.subtitles'),
    );
  }

  static MovieData _movieData(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    return MovieData(
      streamId:
          ValueParser.asInt(json['stream_id'], context, '$jsonPath.stream_id'),
      name: ValueParser.asString(json['name'], context, '$jsonPath.name'),
      title: ValueParser.asString(json['title'], context, '$jsonPath.title'),
      year: ValueParser.asString(json['year'], context, '$jsonPath.year'),
      added:
          ValueParser.asDateTimeUtc(json['added'], context, '$jsonPath.added'),
      categoryId: ValueParser.asInt(
          json['category_id'], context, '$jsonPath.category_id'),
      categoryIds: ValueParser.asIntList(
          json['category_ids'], context, '$jsonPath.category_ids'),
      containerExtension: ValueParser.asString(
        json['container_extension'],
        context,
        '$jsonPath.container_extension',
      ),
      customSid: ValueParser.asString(
          json['custom_sid'], context, '$jsonPath.custom_sid'),
      directSource: ValueParser.asString(
        json['direct_source'],
        context,
        '$jsonPath.direct_source',
      ),
    );
  }
}
