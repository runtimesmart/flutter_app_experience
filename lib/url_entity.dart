import 'package:json_annotation/json_annotation.dart';

part 'url_entity.g.dart';


@JsonSerializable()
class URLEntity {

  @JsonKey(name: 'http_api_host')
  String httpApiHost;

  @JsonKey(name: 'socket_host')
  String socketHost;

  URLEntity(this.httpApiHost,this.socketHost,);

  factory URLEntity.fromJson(Map<String, dynamic> srcJson) => _$url_entityFromJson(srcJson);

}

