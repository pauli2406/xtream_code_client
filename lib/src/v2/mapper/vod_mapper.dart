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
      streamId: ValueParser.readInt(
        json,
        'stream_id',
        context,
        jsonPath,
      ),
      num: ValueParser.readInt(
        json,
        'num',
        context,
        jsonPath,
      ),
      name: ValueParser.readString(
        json,
        'name',
        context,
        jsonPath,
      ),
      title: ValueParser.readString(
        json,
        'title',
        context,
        jsonPath,
      ),
      year: ValueParser.readString(
        json,
        'year',
        context,
        jsonPath,
      ),
      streamType: ValueParser.readString(
        json,
        'stream_type',
        context,
        jsonPath,
      ),
      streamIcon: ValueParser.readString(
        json,
        'stream_icon',
        context,
        jsonPath,
      ),
      rating: ValueParser.readDouble(
        json,
        'rating',
        context,
        jsonPath,
      ),
      rating5based: ValueParser.readDouble(
        json,
        'rating_5based',
        context,
        jsonPath,
      ),
      added: ValueParser.readDateTimeUtc(
        json,
        'added',
        context,
        jsonPath,
      ),
      categoryId: ValueParser.readInt(
        json,
        'category_id',
        context,
        jsonPath,
      ),
      categoryIds: ValueParser.readIntList(
        json,
        'category_ids',
        context,
        jsonPath,
      ),
      containerExtension: ValueParser.readString(
        json,
        'container_extension',
        context,
        jsonPath,
      ),
      customSid: ValueParser.readString(
        json,
        'custom_sid',
        context,
        jsonPath,
      ),
      directSource: ValueParser.readString(
        json,
        'direct_source',
        context,
        jsonPath,
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
      kinopoiskUrl: ValueParser.readString(
        json,
        'kinopoisk_url',
        context,
        jsonPath,
      ),
      tmdbId: ValueParser.readInt(
        json,
        'tmdb_id',
        context,
        jsonPath,
      ),
      name: ValueParser.readString(
        json,
        'name',
        context,
        jsonPath,
      ),
      oName: ValueParser.readString(
        json,
        'o_name',
        context,
        jsonPath,
      ),
      coverBig: ValueParser.readString(
        json,
        'cover_big',
        context,
        jsonPath,
      ),
      movieImage: ValueParser.readString(
        json,
        'movie_image',
        context,
        jsonPath,
      ),
      releaseDate: ValueParser.asDateTimeUtc(
          releaseDateRaw, context, '$jsonPath.releaseDate'),
      episodeRunTime: ValueParser.readInt(
        json,
        'episode_run_time',
        context,
        jsonPath,
      ),
      youtubeTrailer: ValueParser.readString(
        json,
        'youtube_trailer',
        context,
        jsonPath,
      ),
      director: ValueParser.readString(
        json,
        'director',
        context,
        jsonPath,
      ),
      actors: ValueParser.readString(
        json,
        'actors',
        context,
        jsonPath,
      ),
      cast: ValueParser.readString(
        json,
        'cast',
        context,
        jsonPath,
      ),
      description: ValueParser.readString(
        json,
        'description',
        context,
        jsonPath,
      ),
      plot: ValueParser.readString(
        json,
        'plot',
        context,
        jsonPath,
      ),
      age: ValueParser.readString(
        json,
        'age',
        context,
        jsonPath,
      ),
      mpaaRating: ValueParser.readString(
        json,
        'mpaa_rating',
        context,
        jsonPath,
      ),
      ratingCountKinopoisk: ValueParser.readInt(
        json,
        'rating_count_kinopoisk',
        context,
        jsonPath,
      ),
      country: ValueParser.readString(
        json,
        'country',
        context,
        jsonPath,
      ),
      genre: ValueParser.readString(
        json,
        'genre',
        context,
        jsonPath,
      ),
      backdropPath: ValueParser.readStringList(
        json,
        'backdrop_path',
        context,
        jsonPath,
      ),
      durationSecs: ValueParser.readInt(
        json,
        'duration_secs',
        context,
        jsonPath,
      ),
      duration: ValueParser.readString(
        json,
        'duration',
        context,
        jsonPath,
      ),
      bitrate: ValueParser.readInt(
        json,
        'bitrate',
        context,
        jsonPath,
      ),
      rating: ValueParser.readDouble(
        json,
        'rating',
        context,
        jsonPath,
      ),
      subtitles: ValueParser.readStringList(
        json,
        'subtitles',
        context,
        jsonPath,
      ),
    );
  }

  static MovieData _movieData(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    return MovieData(
      streamId: ValueParser.readInt(
        json,
        'stream_id',
        context,
        jsonPath,
      ),
      name: ValueParser.readString(
        json,
        'name',
        context,
        jsonPath,
      ),
      title: ValueParser.readString(
        json,
        'title',
        context,
        jsonPath,
      ),
      year: ValueParser.readString(
        json,
        'year',
        context,
        jsonPath,
      ),
      added: ValueParser.readDateTimeUtc(
        json,
        'added',
        context,
        jsonPath,
      ),
      categoryId: ValueParser.readInt(
        json,
        'category_id',
        context,
        jsonPath,
      ),
      categoryIds: ValueParser.readIntList(
        json,
        'category_ids',
        context,
        jsonPath,
      ),
      containerExtension: ValueParser.readString(
        json,
        'container_extension',
        context,
        jsonPath,
      ),
      customSid: ValueParser.readString(
        json,
        'custom_sid',
        context,
        jsonPath,
      ),
      directSource: ValueParser.readString(
        json,
        'direct_source',
        context,
        jsonPath,
      ),
    );
  }
}
