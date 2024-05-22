class AppwriteConstants {
  static const String databaseId = '650f033b32d79de43873';

  //local
  // static const String projectId = '64caa6992ef2d821e2c3';

  //cloud
  static const String projectId = '650e5971aa68f5cd661e';

  //local
  // static const String endPoint = 'http://localhost:80/v1';
  //cloud
  static const String endPoint = 'https://cloud.appwrite.io/v1';
  static const String userCollection = '650f03426339595225d4';
  static const String tweetsCollection = '65126c0a014fdbf15c4b';
  static const String imagesBucket = '651294834052857f51c3';

  static String imageUrl(String imageId) =>
      "$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin";
}
