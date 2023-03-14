

class ActionResponse {
  String status;

  ActionResponse({required this.status});


  factory ActionResponse.fromMap(Map<String, dynamic> map) =>  ActionResponse(status: map["status"]);

}