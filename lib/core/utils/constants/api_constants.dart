class ApiConstants {
  //static const String baseUrl = "https://yourapi.com";

  // Base URL for the API
  static const String baseUrl = "https://freepik.softvenceomega.com";

  // Authentication URLs
  static const String registerUrl = "$baseUrl/ts/auth/register";
  static const String loginUrl = "$baseUrl/ts/auth/login";
  static const String resetPasswordUrl =
      "$baseUrl/ts/auth/send-password-reset-code";

  //static const String resetPasswordUrl = "$baseUrl/ts/auth/forget-password";
  static const String verifyResetCodeUrl = "$baseUrl/ts/auth/verify-reset-code";
  static const String changePasswordUrl = "$baseUrl/ts/auth/reset-password";
  static const String createWorkerProfileUrl =
      "$baseUrl/ts/profile/create-worker-profile";

  static const String serviceRequestUrl = "$baseUrl/ts/service-request/create";
}
