class Urls {
  static const String baseUrl = 'https://freepik.softvenceomega.com/ts';
  // static const String baseUrl = 'https://1aa6ef016c19.ngrok-free.app/ts';

  static const String register = '$baseUrl/auth/register';
  static const String login = '$baseUrl/auth/login';
  static const String forgetpassword = '$baseUrl/auth/send-password-reset-code';
  static const String verifycode = '$baseUrl/auth/verify-reset-code';
  static const String resetpassword = '$baseUrl/auth/reset-password';
  static const String createkprofile = '$baseUrl/profile/create-client-profile';
  static const String profilesetup = '$baseUrl/profile/create-client-profile';
  static const String updateclientprofile =
      '$baseUrl/profile/update-client-profile/{id}';
  static const String taskType = '$baseUrl/meta/task-type';
  static const String employees = '$baseUrl/admin/employees';
  static const String userdetails = '$baseUrl/auth/me';
  static const String servicerequestoverview =
      '$baseUrl/service-request/get-client-service-request-overview';
  static const String clientrequest = '$baseUrl/service-request/create';
  static const String getinvoiceoverview = '$baseUrl/invoice/get-overview';
  static const String homedata = '$baseUrl/admin/home-data';
  static const String serviceRequestlist = '$baseUrl/service-request/list';
  static const String assignTask = '$baseUrl/service-request/assign-task';
  static const String rejectTask = '$baseUrl/admin/reject-task?id=';
  static const String taskdetails = '$baseUrl/task/details?id=';
  static const String adminalltask = '$baseUrl/admin/all-tasks';
  static const String getservicerequest = '$baseUrl/service-request/get/';
}
