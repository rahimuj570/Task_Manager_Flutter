class Urls {
  static final String _base = "http://35.73.30.144:2005/api/v1";
  static final String userRegistration = "$_base/Registration";
  static final String userLogin = "$_base/Login";

  static final String createTodo = "$_base/createTask";
  static final String getTodoCount = "$_base/taskStatusCount";
  static String getTodoList(String status) => "$_base/listTaskByStatus/$status";

  static String updatestatus({
    required String todoId,
    required String status,
  }) => "$_base/updateTaskStatus/$todoId/$status";

  static String deleteTaskById(String taskId) => "$_base/deleteTask/$taskId";

  static final String updateProfile = "$_base/ProfileUpdate";

  static String recoverVerifyEmail(String email) =>
      '$_base/RecoverVerifyEmail/$email';
}
