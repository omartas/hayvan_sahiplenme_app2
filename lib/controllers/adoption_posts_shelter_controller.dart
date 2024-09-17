import 'package:get/get.dart';
import '../services/pet/adoption_posts_shelter_service.dart';

class AdoptionPostsController extends GetxController {
  final AdoptionPostsService _service = AdoptionPostsService();
  var posts = <dynamic>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> loadAdoptionPosts() async {
    try {
      isLoading(true);
      errorMessage('');
      var fetchedPosts = await _service.fetchAdoptionPosts();
      posts.assignAll(fetchedPosts);
    } catch (e) {
      errorMessage(e.toString());
      print('Error fetching adoption posts: $e');
    } finally {
      isLoading(false);
    }
  }
}
