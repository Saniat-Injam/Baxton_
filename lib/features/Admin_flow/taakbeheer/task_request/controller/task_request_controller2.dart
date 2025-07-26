import 'package:baxton/features/Admin_flow/taakbeheer/task_request/model/task_request_basic_model.dart';
import 'package:baxton/features/Admin_flow/taakbeheer/task_request/model/task_request_detail_model.dart';

import 'package:get/get.dart';

class TaskRequestViewAllController extends GetxController {
  var basicRequests = <TaskRequestBasic>[].obs;
  var detailedRequests = <TaskRequestDetail>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  void fetchRequests() {
    final List<TaskRequestBasic> basicList = [
      TaskRequestBasic(
        title: "Landscaping work at 258 Cedar St",
        user: "David Wilson",
        timeAgo: "5 minutes ago",
      ),

      TaskRequestBasic(
        title: "General maintenance at 147 Maple St",
        user: "Sarah Davis",
        timeAgo: "10 minutes ago",
      ),
      TaskRequestBasic(
        title: "Electrical work at 321 Pine St",
        user: "Michael Brown",
        timeAgo: "15 minutes ago",
      ),
      TaskRequestBasic(
        title: "Electrical work at 321 Pine St",
        user: "Michael Brown",
        timeAgo: "15 minutes ago",
      ),
      TaskRequestBasic(
        title: "Electrical work at 321 Pine St",
        user: "Michael Brown",
        timeAgo: "15 minutes ago",
      ),
      TaskRequestBasic(
        title: "Electrical work at 321 Pine St",
        user: "Michael Brown",
        timeAgo: "15 minutes ago",
      ),
      TaskRequestBasic(
        title: "Electrical work at 321 Pine St",
        user: "Michael Brown",
        timeAgo: "15 minutes ago",
      ),
    ];

    final List<TaskRequestDetail> detailList = [
      TaskRequestDetail(
        title: "Landscaping work at 258 Cedar St",
        user: "David Wilson",
        timeAgo: "5 minutes ago",
        location: "Amsterdam",
        phoneNumber: "0612345678",
        date: "2025-05-08",
        time: "10:00",
        category: "Installatie",
      ),
      TaskRequestDetail(
        title: "Landscaping work at 258 Cedar St",
        user: "David Wilson",
        timeAgo: "5 minutes ago",
        location: "Amsterdam",
        phoneNumber: "0612345678",
        date: "2025-05-08",
        time: "10:00",
        category: "Installatie",
      ),
      TaskRequestDetail(
        title: "Landscaping work at 258 Cedar St",
        user: "David Wilson",
        timeAgo: "5 minutes ago",
        location: "Amsterdam",
        phoneNumber: "0612345678",
        date: "2025-05-08",
        time: "10:00",
        category: "Installatie",
      ),
      TaskRequestDetail(
        title: "Landscaping work at 258 Cedar St",
        user: "David Wilson",
        timeAgo: "5 minutes ago",
        location: "Amsterdam",
        phoneNumber: "0612345678",
        date: "2025-05-08",
        time: "10:00",
        category: "Installatie",
      ),
      TaskRequestDetail(
        title: "Landscaping work at 258 Cedar St",
        user: "David Wilson",
        timeAgo: "5 minutes ago",
        location: "Amsterdam",
        phoneNumber: "0612345678",
        date: "2025-05-08",
        time: "10:00",
        category: "Installatie",
      ),
      TaskRequestDetail(
        title: "Landscaping work at 258 Cedar St",
        user: "David Wilson",
        timeAgo: "5 minutes ago",
        location: "Amsterdam",
        phoneNumber: "0612345678",
        date: "2025-05-08",
        time: "10:00",
        category: "Installatie",
      ),
    ];

    basicRequests.assignAll(basicList);
    detailedRequests.assignAll(detailList);
  }

  TaskRequestDetail getDetailFor(TaskRequestBasic basic) {
    return detailedRequests.firstWhere(
      (detail) =>
          detail.title == basic.title &&
          detail.user == basic.user &&
          detail.timeAgo == basic.timeAgo,
    );
  }

  
}
