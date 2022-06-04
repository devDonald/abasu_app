class SmsModel {
  dynamic sender, to, message, type, routing, token;

  SmsModel(
      {this.sender,
      this.to,
      this.message,
      this.type,
      this.routing,
      this.token});

  toJson() {
    return {
      'token': token,
      'to': to,
      'sender': 'Abasu Team',
      'message': message,
      'type': 0,
      'routing': 3,
    };
  }
}
