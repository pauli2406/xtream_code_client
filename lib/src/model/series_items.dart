import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'series_items.g.dart';

/// Represents a series item in XTremeCode.
///
/// This class provides information about a series item, such as its
/// properties and methods.
///
/// Example usage:
///
/// ```dart
/// XTremeCodeSeriesItem seriesItem = XTremeCodeSeriesItem();
/// // Use the seriesItem object to access and manipulate series item data.
/// ```
@JsonSerializable()
class XTremeCodeSeriesItem {
  /// Creates a [XTremeCodeSeriesItem] instance
  XTremeCodeSeriesItem({
    required this.num,
    required this.name,
    required this.title,
    required this.year,
    required this.streamType,
    required this.seriesId,
    required this.cover,
    required this.plot,
    required this.cast,
    required this.director,
    required this.genre,
    required this.releaseDate,
    required this.lastModified,
    required this.rating,
    required this.rating5based,
    required this.backdropPath,
    required this.youtubeTrailer,
    required this.episodeRunTime,
    required this.categoryId,
    required this.categoryIds,
  });

  /// Creates a [XTremeCodeSeriesItem] instance from a JSON map.
  factory XTremeCodeSeriesItem.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeSeriesItemFromJson(json);

  /// The number of the series item.
  @JsonKey(fromJson: dynamicToIntConverter)
  final int? num;

  /// The name of the series item.
  final String? name;

  /// The title of the series item.
  final String? title;

  /// The year of the series item.
  final String? year;

  /// The stream type of the series item.
  @JsonKey(name: 'stream_type')
  final String? streamType;

  /// The ID of the series.
  @JsonKey(name: 'series_id', fromJson: dynamicToIntConverter)
  final int? seriesId;

  /// The cover image URL of the series item.
  final String? cover;

  /// The plot of the series item.
  final String? plot;

  /// The cast of the series item.
  final String? cast;

  /// The director of the series item.
  final String? director;

  /// The genre of the series item.
  final String? genre;

  /// The release date of the series item.
  final String? releaseDate;

  /// The last modified date of the series item.
  @JsonKey(name: 'last_modified', fromJson: dateTimeFromEpochSeconds)
  final DateTime? lastModified;

  /// The rating of the series item.
  @JsonKey(fromJson: dynamicToDoubleConverter)
  final double? rating;

  /// The 5-based rating of the series item.
  @JsonKey(name: 'rating_5based', fromJson: dynamicToDoubleConverter)
  final double? rating5based;

  /// The backdrop image paths of the series item.
  @JsonKey(name: 'backdrop_path', fromJson: stringListFromJson)
  final List<String>? backdropPath;

  /// The YouTube trailer URL of the series item.
  @JsonKey(name: 'youtube_trailer')
  final String? youtubeTrailer;

  /// The episode run time of the series item.
  @JsonKey(name: 'episode_run_time', fromJson: dynamicToIntConverter)
  final int? episodeRunTime;

  /// The category ID of the series item.
  @JsonKey(name: 'category_id', fromJson: dynamicToIntConverter)
  final int? categoryId;

  /// The category IDs of the series item.
  @JsonKey(name: 'category_ids', fromJson: intListFromJson)
  final List<int>? categoryIds;

  /// Converts this [XTremeCodeSeriesItem] instance to a JSON map.
  Map<String, dynamic> toJson() => _$XTremeCodeSeriesItemToJson(this);
}
