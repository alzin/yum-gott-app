class VideoModel {
  final String id;
  final String videoUrl;
  final String thumbnailUrl;
  final String restaurantName;
  final String restaurantId;
  final String restaurantLogoUrl;
  final String foodName;
  final String foodCategory;
  final String description;
  final int likes;
  final int comments;
  final int shares;
  final double rating;
  final String distance;
  final String userName;
  final String userProfileUrl;
  final bool isLiked;

  VideoModel({
    required this.id,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.restaurantName,
    required this.restaurantId,
    required this.restaurantLogoUrl,
    required this.foodName,
    required this.foodCategory,
    required this.description,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.rating,
    required this.distance,
    required this.userName,
    required this.userProfileUrl,
    this.isLiked = false,
  });

  // Sample data for testing
  static List<VideoModel> getSampleVideos() {
    return [
      VideoModel(
        id: '1',
        videoUrl: 'assets/videos/video1.mp4',
        thumbnailUrl: 'assets/images/thumbnail1.jpg',
        restaurantName: 'Observatory Bar & Grill',
        restaurantId: '1',
        restaurantLogoUrl: 'assets/images/restaurant_logo1.png',
        foodName: 'Burger',
        foodCategory: 'Fast Food',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incide ...',
        likes: 1600,
        comments: 560,
        shares: 2400,
        rating: 4.8,
        distance: '5 km',
        userName: 'John Doe',
        userProfileUrl: 'assets/images/user_profile1.jpg',
        isLiked: true,
      ),
      VideoModel(
        id: '2',
        videoUrl: 'assets/videos/video2.mp4',
        thumbnailUrl: 'assets/images/thumbnail2.jpg',
        restaurantName: 'Pizza Palace',
        restaurantId: '2',
        restaurantLogoUrl: 'assets/images/restaurant_logo2.png',
        foodName: 'Pepperoni Pizza',
        foodCategory: 'Italian',
        description: 'Delicious pepperoni pizza with extra cheese and special sauce. Must try!',
        likes: 2300,
        comments: 780,
        shares: 1500,
        rating: 4.6,
        distance: '3.2 km',
        userName: 'Jane Smith',
        userProfileUrl: 'assets/images/user_profile2.jpg',
        isLiked: false,
      ),
      VideoModel(
        id: '3',
        videoUrl: 'assets/videos/video3.mp4',
        thumbnailUrl: 'assets/images/thumbnail3.jpg',
        restaurantName: 'Sushi World',
        restaurantId: '3',
        restaurantLogoUrl: 'assets/images/restaurant_logo3.png',
        foodName: 'Dragon Roll',
        foodCategory: 'Japanese',
        description: 'Fresh and delicious dragon roll with avocado and eel. Perfect for sushi lovers!',
        likes: 3400,
        comments: 920,
        shares: 2800,
        rating: 4.9,
        distance: '7.5 km',
        userName: 'Mike Johnson',
        userProfileUrl: 'assets/images/user_profile3.jpg',
        isLiked: true,
      ),
      VideoModel(
        id: '4',
        videoUrl: 'assets/videos/video4.mp4',
        thumbnailUrl: 'assets/images/thumbnail4.jpg',
        restaurantName: 'Taco Heaven',
        restaurantId: '4',
        restaurantLogoUrl: 'assets/images/restaurant_logo4.png',
        foodName: 'Beef Tacos',
        foodCategory: 'Mexican',
        description: 'Authentic Mexican tacos with seasoned beef, fresh vegetables, and homemade salsa.',
        likes: 1800,
        comments: 450,
        shares: 1200,
        rating: 4.5,
        distance: '2.8 km',
        userName: 'Sarah Williams',
        userProfileUrl: 'assets/images/user_profile4.jpg',
        isLiked: false,
      ),
      VideoModel(
        id: '5',
        videoUrl: 'assets/videos/video5.mp4',
        thumbnailUrl: 'assets/images/thumbnail5.jpg',
        restaurantName: 'Sweet Treats',
        restaurantId: '5',
        restaurantLogoUrl: 'assets/images/restaurant_logo5.png',
        foodName: 'Chocolate Cake',
        foodCategory: 'Dessert',
        description: 'Rich and moist chocolate cake with creamy frosting. Perfect for dessert lovers!',
        likes: 2700,
        comments: 630,
        shares: 1900,
        rating: 4.7,
        distance: '4.1 km',
        userName: 'Emily Davis',
        userProfileUrl: 'assets/images/user_profile5.jpg',
        isLiked: true,
      ),
    ];
  }
}