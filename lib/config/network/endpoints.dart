class Endpoints {
  // ========buyer==========
  static const String buyer = "/buyer";
  static String buyerById(String id) => "/buyer/$id";

//   ========collection================
  static const String collection = "/collection";
  static String collectionWithId(String id) => "/collection/$id";

//   =======categories=============
  static const String categories = "/categories";
  static String categoryBySlud(String slug) =>
      "/categories/slug/$slug/products";
  static String categoryById(String id) => "/categories/$id";

//   =========coupon=============
  static const String coupon = "/coupon";
  static String couponWithId(String id) => "/coupon/$id/coupon";

//   =====follow==========
  static const String follow = "/follow";
  static String followWithId(String id) => "/follow/$id";
  static String brandWithId(String id) => "/follow/brand/$id";
  static const String followers = "/follow/brand";
  static String following(String id) => "/follow/brand/$id";
  static const String currentFollowing = "/follow/brand/current/following";
  static String followersBySlug(String slug) =>
      "/follow/brand/slug/$slug/followers";
  static String followingsBySlug(String slug) =>
      "/follow/brand/slug/$slug/following";

  //   =======fullfillment==========
  static const String fullfillment = "/fulfillment";
  static String fullfillmentWithId(String id) => "/fulfillment/$id";

//   =======fullfillment Provider=============
  static const String fullfillmentProvider = "/fulfillmentProvider/providers";
  static String fullfillmentProviderWithId(String id) =>
      "/fulfillmentProviders/providers/$id";

//   ========seller hero section===============
  static const String heroSection = "/heroSection";

//   ==========interests===================
  static const String interests = "/interests";
  static String interestsWithId(String id) => "/interests/$id";
  static const String getCurrentUserInterests = "/interests/user/current";
  static const String currentUserInterest = "/interests/user";

//   ==========links===============
  static const String links = "/links";
  static String linksById(String id) => "/links/$id";
  static String linksBySlug(String slug) => "/links/by-slug/$slug";

//   =========Media================
  static const String media = "/media";
  static String mediaWithId(String id) => "/media/$id";

//   ========messages==========
  static const String messages = "/messages";
  static String messagesWithId(String id) => "/messages/$id";
  static const String messagesHistory = "/messages/history";
  static const String messagesUnread = "/messages/unread";

//   =======Notifications================
  static const String notifications = "/notification";
  static String notificationsWithId(String id) => "/notification/$id";
  static String readNotification(String id) => "/notification/$id/read";
  static const String readAllNotifications = "/notification/read-all";

//   ========onBoarding=============
//   static const String onBoarding = "/onboarding";
//   static String onBoardingById(String id) => "/onboarding/$id";

//==========Seller auth===================
  static const String register = "/onboarding/register";
  static const String login = "/onboarding/login";
  static const String verifySellerEmail = "/onboarding/verify";
  static const String resendVerification = "/onboarding/resend-verification";
  static const String checkToken = "/onboarding/check-token";
  static const String refreshToken = "/onboarding/refresh-token";
  static const String logout = "/onboarding/logout";
  static const String forgotPassword = "/onboarding/forgot-password";
  static const String resetPassword = "/onboarding/reset-password";

//   =========orders==============
  static const String orders = "/orders";
  static String orderById(String id) => "/orders/$id";
//   ========buyerOrder========
  static const String buyerOrder = "/orders/buyer";
  static String buyerOrderById(String id) => "/orders/buyer/$id";
  static String cancelBuyerOrder(String id) => "/orders/buyer/$id/cancel";
//   =========SellerOrder=========
  static const String storeOrders = "/orders/seller/store";
  static String updateStoreOrderStatus(String id) =>
      "/orders/seller/store/$id/status";

//   ======Pages===========
  static const String pages = "/pages";
  static String pagesById(String id) => "/pages/$id";
  static String updatePageTitle(String id) => "/pages/$id/title";
  static String pagesBySlug(String slug) => "/pages/$slug";

//   ==========paymentMethods===========
  static const String paymentMethods = "/paymentMethods";
  static String paymentMethodsById(String id) => "/paymentMethods/$id";

//   =======payments============
//   static const String payment = "/payments";
//   static String paymentById(String id) => "/payments/$id";

//   ========posts=============
  static const String posts = "/posts";
  static String postsById(String id) => "/posts/$id";
  static const String discoverPosts = "/posts/discover";
  static String postBySlug(String slug) => "/posts/slug/$slug";
  static String likePost(String id) => "/posts/$id/like";
  static String comment(String id) => "/posts/$id/comments";
  static String updateComment(String id) => "/posts/comments/$id";

//   =======products==========
  static const String products = "/products";
  static String productsById(String id) => "/products/$id";
  static const String productsFeed = "/products/feed";
  static const String myProducts = "/products/current";
  static const String searchProduct = "/products/search";
  static const String productForUser = "/products/user";
  static String storeProductsBySlug(String slug) =>
      "/products/stores/$slug/products";
  static String productReview(String id) => "/products/$id/reviews";
  static String productRecommendations(String id) =>
      "/products/$id/recommendations";

//   ========promotions========
  static const String promotions = "/promotions";
  static String promotionsById(String id) => "/promotions/$id";

//   =========reports============
  static const String reports = "/reports";
  static String reportsById(String id) => "/reports/$id";

//   =========squads===========
  static const String squads = "/squads";
  static String squadsById(String id) => "/squads/$id";

//   ===========stores===========
  static const String stores = "/stores"; //protected
  // static String storesById(String id) => "/stores/$id";
  static const String recentStores = "/stores/recent";
  static const String minimalStores = "/stores/min";
  static const String currentStore = "/stores/current"; //Protected
  static String storeByHandle(String handle) => "/stores/lookup/$handle";
  static String storeBySlug(String slug) => "/stores/public/$slug";
  static const String searchStore = "/stores/search";

//   ========Subscriptions=============
//   static const String subscription = "/subscriptions";
//   static String subscriptionById(String id) => "/subscriptions/$id";

//   =========taxDocuments=============
  static const String taxDocument = "/taxDocuments";
  static String taxDocumentById(String id) => "/taxDocuments/$id";

//   ========Themes================
  static const String theme = "/themes";
  static String themeById(String id) => "/themes/$id";
  static const String currentStoreTheme = "/themes/current";
  static const String customTheme = "/themes/custom";
  static const String allSellerThemes = "/themes/my-themes";

//   ============user==============
  static const String userProfile = "/user/profile";
  static const String userWithPosts = "/user/with-posts";
  static const String user = "/user";
  static const String changePassword = "/user/password";
}
