import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/expense.dart';
import 'package:expense_tracker/features/dashboard/modules/expense-list-page/model/repo/parent_date.dart';

class FirebaseRepo extends ParentRepo {
  static FirebaseRepo? _singletonObject;

  FirebaseRepo._init();

  static FirebaseRepo get instance {
    _singletonObject ??= FirebaseRepo._init();
    return _singletonObject!;
  }

  // Implementing deleteExpense method for Firebase data source
  @override
  Future<void> deleteExpense({required String id}) async {
    await FirebaseFirestore.instance.collection('expenses').doc(id).delete();
  }

  // Implementing fetchExpenses method for Firebase data source
  @override
  Future<List<Expense>> fetchExpenses({String? email = ''}) async {
    return await FirebaseFirestore.instance
        .collection('expenses')
        .where('email', isEqualTo: email)
        .get()
        .then(
      (QuerySnapshot querySnapshot) {
        final List<Expense> expenses = querySnapshot.docs
            .map(
              (doc) => Expense.fromMap(
                {
                  ...(doc.data() as Map<String, dynamic>?) ?? {},
                  'id': doc.reference.id
                },
              ),
            )
            .toList();
        return expenses;
      },
    );
  }

  // Implementing insertExpense method for Firebase data source
  @override
  Future<void> insertExpense(Expense expense) async {
    await FirebaseFirestore.instance
        .collection('expenses')
        .add(expense.toMap());
  }
}
