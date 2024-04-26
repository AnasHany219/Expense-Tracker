class ExpenseModel {
  String? name;
  int? cost;
  String? id;

  ExpenseModel({this.id, this.name, this.cost});

  ExpenseModel.fromJson(Map map) {
    id = map['id'].toString();
    name = map['name'];
    cost = map['cost'].toInt();
  }
}
