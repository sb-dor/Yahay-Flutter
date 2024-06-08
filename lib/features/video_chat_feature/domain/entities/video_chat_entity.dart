class VideoChatEntity {
  final String chatChannelName;
  bool channelAcception;
  bool channelCreator;

  VideoChatEntity({
    required this.chatChannelName,
    this.channelAcception = false,
    this.channelCreator = false,
  });
}
