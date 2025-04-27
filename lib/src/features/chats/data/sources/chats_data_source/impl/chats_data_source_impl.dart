import 'package:yahay/src/core/utils/dio/src/http_routes/http_routes.dart';
import 'package:yahay/src/core/utils/dio/dio_client.dart';
import 'package:yahay/src/core/models/chats_model/chat_model.dart';
import 'package:yahay/src/core/utils/extensions/extensions.dart';
import 'package:yahay/src/features/chats/data/sources/chats_data_source/chats_data_source.dart';

class ChatsDataSourceImpl implements ChatsDataSource {
  //
  ChatsDataSourceImpl({required final RestClientBase restClientBase})
    : _restClientBase = restClientBase;

  final RestClientBase _restClientBase;

  final String _getUserChatsUrl = "${HttpRoutes.chatsPrefix}/get/chats";

  @override
  Future<List<ChatModel>> chats() async {
    try {
      final response = await _restClientBase.get(_getUserChatsUrl);

      if (response == null) return <ChatModel>[];

      if (!response.containsKey(HttpServerResponses.serverSuccessResponse)) {
        return <ChatModel>[];
      }

      final List<dynamic> listD = response.getNested(['chats']);

      final result = listD.map((e) => ChatModel.fromJson(e)).toList();

      return result;
    } on RestClientException {
      rethrow;
    }
  }
}
