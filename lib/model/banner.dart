class AppBanner {
  final String bannerType;
  final List<String> bannerUrls;

  AppBanner({
    required this.bannerType,
    required this.bannerUrls,
  });

  factory AppBanner.fromJson(Map<String, dynamic> json) {
    return AppBanner(
      bannerType: json['banner_type'],
      bannerUrls: List<String>.from(json['banner_urls']),
    );
  }
}
