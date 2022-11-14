import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dtlive/model/subscriptionmodel.dart';
import 'package:dtlive/model/channelsectionmodel.dart';
import 'package:dtlive/model/episodebyseasonmodel.dart';
import 'package:dtlive/model/generalsettingmodel.dart';
import 'package:dtlive/model/genresmodel.dart';
import 'package:dtlive/model/langaugemodel.dart';
import 'package:dtlive/model/loginregistermodel.dart';
import 'package:dtlive/model/profilemodel.dart';
import 'package:dtlive/model/rentmodel.dart';
import 'package:dtlive/model/searchmodel.dart';
import 'package:dtlive/model/sectionbannermodel.dart';
import 'package:dtlive/model/sectiondetailmodel.dart';
import 'package:dtlive/model/sectionlistmodel.dart';
import 'package:dtlive/model/sectiontypemodel.dart';
import 'package:dtlive/model/successmodel.dart';
import 'package:dtlive/model/videobyidmodel.dart';
import 'package:dtlive/model/watchlistmodel.dart';
import 'package:dtlive/utils/constant.dart';

class ApiService {
  String baseUrl = Constant.baseurl;

  late Dio dio;

  Options optHeaders = Options(headers: <String, dynamic>{
    'Content-Type': 'application/json',
    'auth_token': 'jQfq4I2q6lv',
    'Accept': 'application/json'
  });

  ApiService() {
    dio = Dio();
  }

  // general_setting API
  Future<GeneralSettingModel> genaralSetting() async {
    GeneralSettingModel generalSettingModel;
    String generalsetting = "general_setting";
    Response response = await dio.post(
      '$baseUrl$generalsetting',
      options: optHeaders,
    );
    log('genaralSetting response ==>>> ${response.data}');
    log('genaralSetting statusCode ==>>> ${response.statusCode}');
    generalSettingModel = GeneralSettingModel.fromJson(response.data);
    return generalSettingModel;
  }

  /* type => 1-Facebook, 2-Google */
  // login API
  Future<LoginRegisterModel> loginWithSocial(email, name, type) async {
    log("email :==> $email");
    log("name :==> $name");
    log("type :==> $type");

    LoginRegisterModel loginModel;
    String gmailLogin = "login";
    Response response = await dio.post(
      '$baseUrl$gmailLogin',
      options: optHeaders,
      data: {
        'type': type,
        'email': email,
        'name': name,
      },
    );

    log("login statuscode :===> ${response.statusCode}");
    log("login Message :===> ${response.statusMessage}");
    log("login data :===> ${response.data}");
    loginModel = LoginRegisterModel.fromJson(response.data);
    return loginModel;
  }

  /* type => 3-OTP */
  // login API
  Future<LoginRegisterModel> loginWithOTP(mobile) async {
    log("mobile :==> $mobile");

    LoginRegisterModel loginModel;
    String doctorLogin = "login";
    Response response = await dio.post(
      '$baseUrl$doctorLogin',
      options: optHeaders,
      data: {
        'type': '3',
        'mobile': mobile,
      },
    );

    log("login statuscode :===> ${response.statusCode}");
    log("login Message :===> ${response.statusMessage}");
    log("login data :===> ${response.data}");
    loginModel = LoginRegisterModel.fromJson(response.data);
    return loginModel;
  }

  // forgot_password API
  Future<SuccessModel> forgotPassword(email) async {
    log("email :==> $email");

    SuccessModel successModel;
    String doctorLogin = "forgot_password";
    Response response = await dio.post(
      '$baseUrl$doctorLogin',
      options: optHeaders,
      data: {
        'email': email,
      },
    );

    log("forgotPassword statuscode :===> ${response.statusCode}");
    log("forgotPassword Message :===> ${response.statusMessage}");
    log("forgotPassword data :===> ${response.data}");
    successModel = successModelFromJson(response.data.toString());
    return successModel;
  }

  // get_profile API
  Future<ProfileModel> profile() async {
    log("profile userID :==> ${Constant.userID}");

    ProfileModel profileModel;
    String doctorLogin = "get_profile";
    Response response = await dio.post(
      '$baseUrl$doctorLogin',
      options: optHeaders,
      data: {
        'id': Constant.userID,
      },
    );

    log("get_profile statuscode :===> ${response.statusCode}");
    log("get_profile Message :===> ${response.statusMessage}");
    log("get_profile data :===> ${response.data}");
    profileModel = ProfileModel.fromJson(response.data);
    return profileModel;
  }

  // update_profile API
  Future<SuccessModel> updateProfile(name) async {
    log("updateProfile userID :==> ${Constant.userID}");
    log("updateProfile name :==> $name");

    SuccessModel successModel;
    String doctorLogin = "update_profile";
    Response response = await dio.post(
      '$baseUrl$doctorLogin',
      options: optHeaders,
      data: {
        'id': Constant.userID,
        'name': name,
      },
    );

    log("update_profile statuscode :===> ${response.statusCode}");
    log("update_profile Message :===> ${response.statusMessage}");
    log("update_profile data :===> ${response.data}");
    successModel = SuccessModel.fromJson(response.data);
    return successModel;
  }

  // image_upload API
  Future<ProfileModel> imageUpload(File? profileImg) async {
    ProfileModel uploadImgModel;
    String uploadImage = "image_upload";
    log("imageUpload API :==> $baseUrl$uploadImage");
    log("ProfileImg Filename :==> ${profileImg!.path.split('/').last}");
    log("profileImg Extension :==> ${profileImg.path.split('/').last.split(".").last}");
    Response response = await dio.post(
      '$baseUrl$uploadImage',
      data: FormData.fromMap({
        'id': Constant.userID,
        "image": profileImg.path.isNotEmpty
            ? (await MultipartFile.fromFile(
                profileImg.path,
                filename: profileImg.path.split('/').last,
              ))
            : "",
      }),
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("imageUpload statuscode :===> ${response.statusCode}");
    log("imageUpload Message :===> ${response.statusMessage}");
    log("imageUpload data :===> ${response.data}");
    uploadImgModel = ProfileModel.fromJson(response.data);
    return uploadImgModel;
  }

  /* type => 1-movies, 2-news, 3-sport, 4-tv show */
  // get_type API
  Future<SectionTypeModel> sectionType() async {
    SectionTypeModel sectionTypeModel;
    String sectionType = "get_type";
    Response response = await dio.post(
      '$baseUrl$sectionType',
      options: optHeaders,
    );
    log('type response ==>>> ${response.data.toString()}');
    log('type statusCode ==>>> ${response.statusCode}');
    sectionTypeModel = SectionTypeModel.fromJson(response.data);
    return sectionTypeModel;
  }

  // get_banner API
  Future<SectionBannerModel> sectionBanner(typeId, isHomePage) async {
    log('sectionBanner typeId ==>>> $typeId');
    log('sectionBanner isHomePage ==>>> $isHomePage');
    SectionBannerModel sectionBannerModel;
    String sectionBanner = "get_banner";
    Response response = await dio.post(
      '$baseUrl$sectionBanner',
      options: optHeaders,
      data: {
        'type_id': typeId,
        'is_home_page': isHomePage,
      },
    );
    // log('get_banner response ==>>> ${response.data}');
    // log('get_banner statusCode ==>>> ${response.statusCode}');
    sectionBannerModel = SectionBannerModel.fromJson(response.data);
    return sectionBannerModel;
  }

  // section_list API
  Future<SectionListModel> sectionList(typeId, isHomePage) async {
    SectionListModel sectionListModel;
    String sectionList = "section_list";
    Response response = await dio.post(
      '$baseUrl$sectionList',
      options: optHeaders,
      data: {
        'user_id': Constant.userID,
        'type_id': typeId,
        'is_home_page': isHomePage,
      },
    );
    // log('section_list response ==>>> ${response.data}');
    // log('section_list statusCode ==>>> ${response.statusCode}');
    sectionListModel = SectionListModel.fromJson(response.data);
    return sectionListModel;
  }

  // section_detail API
  Future<SectionDetailModel> sectionDetails(typeId, videoType, videoId) async {
    SectionDetailModel sectionDetailModel;
    String sectionList = "section_detail";
    Response response = await dio.post(
      '$baseUrl$sectionList',
      options: optHeaders,
      data: {
        'user_id': Constant.userID,
        'type_id': typeId,
        'video_type': videoType,
        'video_id': videoId,
      },
    );
    // log('section_detail response ==>>> ${response.data}');
    log('section_detail statusCode ==>>> ${response.statusCode}');
    sectionDetailModel = SectionDetailModel.fromJson(response.data);
    return sectionDetailModel;
  }

  // add_remove_bookmark API
  Future<SuccessModel> addRemoveBookmark(typeId, videoType, videoId) async {
    SuccessModel successModel;
    String sectionList = "add_remove_bookmark";
    Response response = await dio.post(
      '$baseUrl$sectionList',
      options: optHeaders,
      data: {
        'user_id': Constant.userID,
        'type_id': typeId,
        'video_type': videoType,
        'video_id': videoId,
      },
    );
    log('add_remove_bookmark response ==>>> ${response.data}');
    log('add_remove_bookmark statusCode ==>>> ${response.statusCode}');
    successModel = SuccessModel.fromJson(response.data);
    return successModel;
  }

  // get_video_by_session_id API
  Future<EpisodeBySeasonModel> episodeBySeason(seasonId, showId) async {
    EpisodeBySeasonModel episodeBySeasonModel;
    String episodeBySeasonList = "get_video_by_session_id";
    Response response = await dio.post(
      '$baseUrl$episodeBySeasonList',
      options: optHeaders,
      data: {
        'user_id': Constant.userID,
        'session_id': seasonId,
        'show_id': showId,
      },
    );
    // log('get_video_by_session_id response ==>>> ${response.data}');
    log('get_video_by_session_id statusCode ==>>> ${response.statusCode}');
    episodeBySeasonModel = EpisodeBySeasonModel.fromJson(response.data);
    return episodeBySeasonModel;
  }

  // get_category API
  Future<GenresModel> genres() async {
    GenresModel genresModel;
    String genres = "get_category";
    Response response = await dio.post(
      '$baseUrl$genres',
      options: optHeaders,
    );
    log('genres response ==>>> ${response.data.toString()}');
    log('genres statusCode ==>>> ${response.statusCode}');
    genresModel = GenresModel.fromJson(response.data);
    return genresModel;
  }

  // get_language API
  Future<LangaugeModel> language() async {
    LangaugeModel langaugeModel;
    String language = "get_language";
    Response response = await dio.post(
      '$baseUrl$language',
      options: optHeaders,
    );
    log('language response ==>>> ${response.data.toString()}');
    log('language statusCode ==>>> ${response.statusCode}');
    langaugeModel = LangaugeModel.fromJson(response.data);
    return langaugeModel;
  }

  // search_video API
  Future<SearchModel> searchVideo(searchText) async {
    log('searchVideo searchText ==>>> $searchText');
    SearchModel searchModel;
    String search = "search_video";
    Response response = await dio.post(
      '$baseUrl$search',
      options: optHeaders,
      data: {
        'name': searchText,
        'user_id': Constant.userID,
      },
    );
    // log('search_video response ==>>> ${response.data}');
    log('search_video statusCode ==>>> ${response.statusCode}');
    searchModel = SearchModel.fromJson(response.data);
    return searchModel;
  }

  // channel_section_list API
  Future<ChannelSectionModel> channelSectionList() async {
    ChannelSectionModel channelSectionModel;
    String channelSection = "channel_section_list";
    Response response = await dio.post(
      '$baseUrl$channelSection',
      options: optHeaders,
      data: {
        'user_id': Constant.userID,
      },
    );
    // log('channel_section_list response ==>>> ${response.data}');
    log('channel_section_list statusCode ==>>> ${response.statusCode}');
    channelSectionModel = ChannelSectionModel.fromJson(response.data);
    return channelSectionModel;
  }

  // rent_video_list API
  Future<RentModel> rentVideoList() async {
    RentModel rentModel;
    String rentList = "rent_video_list";
    Response response = await dio.post(
      '$baseUrl$rentList',
      options: optHeaders,
      data: {
        'user_id': Constant.userID,
      },
    );
    // log('rent_video_list response ==>>> ${response.data}');
    log('rent_video_list statusCode ==>>> ${response.statusCode}');
    rentModel = RentModel.fromJson(response.data);
    return rentModel;
  }

  // user_rent_video_list API
  Future<RentModel> userRentVideoList() async {
    RentModel rentModel;
    String rentList = "user_rent_video_list";
    Response response = await dio.post(
      '$baseUrl$rentList',
      options: optHeaders,
      data: {
        'user_id': Constant.userID,
      },
    );
    // log('user_rent_video_list response ==>>> ${response.data}');
    log('user_rent_video_list statusCode ==>>> ${response.statusCode}');
    rentModel = RentModel.fromJson(response.data);
    return rentModel;
  }

  // video_by_category API
  Future<VideoByIdModel> videoByCategory(categoryID) async {
    log('videoByCategory categoryID ==>>> $categoryID');
    VideoByIdModel videoByIdModel;
    String byCategory = "video_by_category";
    Response response = await dio.post(
      '$baseUrl$byCategory',
      options: optHeaders,
      data: {
        'user_id': Constant.userID,
        'category_id': categoryID,
      },
    );
    log('video_by_category response ==>>> ${response.data}');
    log('video_by_category statusCode ==>>> ${response.statusCode}');
    videoByIdModel = VideoByIdModel.fromJson(response.data);
    return videoByIdModel;
  }

  // video_by_language API
  Future<VideoByIdModel> videoByLanguage(languageID) async {
    log('videoByLanguage languageID ==>>> $languageID');
    VideoByIdModel videoByIdModel;
    String byLanguage = "video_by_language";
    Response response = await dio.post(
      '$baseUrl$byLanguage',
      options: optHeaders,
      data: {
        'user_id': Constant.userID,
        'language_id': languageID,
      },
    );
    log('video_by_language response ==>>> ${response.data}');
    log('video_by_language statusCode ==>>> ${response.statusCode}');
    videoByIdModel = VideoByIdModel.fromJson(response.data);
    return videoByIdModel;
  }

  // get_package API
  Future<SubscriptionModel> subscriptionPackage() async {
    log('subscriptionPackage userID ==>>> ${Constant.userID}');
    SubscriptionModel subscriptionModel;
    String getPackage = "get_package";
    Response response = await dio.post(
      '$baseUrl$getPackage',
      options: optHeaders,
      data: {
        'user_id': Constant.userID,
      },
    );
    log('get_package response ==>>> ${response.data}');
    log('get_package statusCode ==>>> ${response.statusCode}');
    subscriptionModel = SubscriptionModel.fromJson(response.data);
    return subscriptionModel;
  }

  // get_bookmark_video API
  Future<WatchlistModel> watchlist() async {
    log("watchlist userID :==> ${Constant.userID}");

    WatchlistModel watchlistModel;
    String getBookmarkVideo = "get_bookmark_video";
    log("getBookmarkVideo API :==> $baseUrl$getBookmarkVideo");
    Response response = await dio.post(
      '$baseUrl$getBookmarkVideo',
      options: optHeaders,
      data: {
        'user_id': Constant.userID,
      },
    );

    log("get_bookmark_video statuscode :===> ${response.statusCode}");
    log("get_bookmark_video Message :===> ${response.statusMessage}");
    log("get_bookmark_video data :===> ${response.data}");
    watchlistModel = WatchlistModel.fromJson(response.data);
    return watchlistModel;
  }
}
