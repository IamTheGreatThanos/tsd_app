class DTOTokensResponse {
  DTOTokensResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  factory DTOTokensResponse.fromJson(Map<String, dynamic> json) {
    return DTOTokensResponse(
        accessToken: json["accessToken"] as String,
        refreshToken: json["refreshToken"] as String,
      );
  }

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}
