import '../Services/auth_service.dart';
import '../models/user_model.dart'; // Đảm bảo đã tạo model UserModel

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Lấy danh sách người dùng từ Firestore
  Future<List<UserModel>> getUsers() async {
    try {
      QuerySnapshot snapshot = await _db.collection('users').get();
      return snapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

  // Thêm người dùng mới vào Firestore
  Future<void> addUser(UserModel user) async {
    try {
      await _db.collection('users').add({
        'name': user.name,
        'age': user.age,
      });
    } catch (e) {
      throw Exception('Error adding user: $e');
    }
  }
}


