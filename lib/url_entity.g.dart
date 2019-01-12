// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

URLEntity _$url_entityFromJson(Map<String, dynamic> json) {
  return URLEntity(
      json['http_api_host'] as String, json['socket_host'] as String);
}

Map<String, dynamic> _$url_entityToJson(URLEntity instance) =>
    <String, dynamic>{
      'http_api_host': instance.httpApiHost,
      'socket_host': instance.socketHost
    };
