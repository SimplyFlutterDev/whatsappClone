import 'dart:io';
import 'package:back_roads/ui/city/city_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:float_column/float_column.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../blocs/business_mail_bloc.dart';
import '../../blocs/country_eclipse_bloc.dart';
import '../../core/backroads_preference_manager.dart';
import '../../model/cityEclipsemodel.dart';
import '../../blocs/country_eclipse_data_bloc.dart';
import '../../model/eclipse_data_model.dart';
import '../../model/prepare_business_model.dart';
import '../../network/helper/api_tools.dart';
import '../../utility/color/color_util.dart';
import '../../utility/util/common_widget.dart';
import '../../utility/util/constants.dart';
import 'city_eclipse_timing.dart';
import 'country_eclipse_analytics.dart';

class CountryEclipse extends StatefulWidget {
  CountryEclipse({Key key}) : super(key: key);

  @override
  State<CountryEclipse> createState() => _CountryEclipseState();
}

class _CountryEclipseState extends State<CountryEclipse> {
  CountryEclipseBloc eclipseBloc = CountryEclipseBloc();
  CityEclipseBloc _bloc = CityEclipseBloc();
  BusinessMailBloc _businessMailBloc = BusinessMailBloc();
  CountryEclipseAnalytics countryAnalytics = CountryEclipseAnalytics();
  final _currentPageNotifier = ValueNotifier<int>(0);
  PageController _pageController = PageController(
    initialPage: 0,
  );
  List<GlobalKey> section1Keys = [];
  List<GlobalKey> section2Keys = [];
  List<bool> readMore = [];
  Map<int, bool> expansionStateMap = {};
  List expansionKeys = [];
  List expansionKeys3 = [];
  int jsutIndex = 0;
  int limit = 0;
  bool isZoomed = false;
  bool isZoomed2 = false;
  List<EclipseTravelButtons> sectionButton = [
    EclipseTravelButtons("FIND VACATION HOMES",
        "https://www.backroadstexas.net/texas-hill-country-eclipse-vacation-homes"),
    EclipseTravelButtons("FIND RV SPOTS",
        "https://www.backroadstexas.net/texas-eclipse-2023-2024-rv-vacation/#rvSpotLi"),
    EclipseTravelButtons("FIND TENT CAMPING",
        "https://www.backroadstexas.net/texas-eclipse-2023-2024-rv-vacation/#rvSpotLi")
  ];

  final GlobalKey expansionTileKey4 = GlobalKey();
  final GlobalKey expansionTileKey5 = GlobalKey();
  final GlobalKey expansionTileKey6 = GlobalKey();
  final GlobalKey expansionTileKey7 = GlobalKey();
  final GlobalKey expansionTileKey8 = GlobalKey();
  final GlobalKey expansionTileKey9 = GlobalKey();

  final GlobalKey expansionTileKey10 = GlobalKey();
  final GlobalKey expansionTileKe11 = GlobalKey();
  final GlobalKey expansionTileKey12 = GlobalKey();
  final GlobalKey expansionTileKey13 = GlobalKey();
  final GlobalKey expansionTileKey14 = GlobalKey();

  final GlobalKey expansionTileKey15 = GlobalKey();
  bool eclipseGearExpand = false;

  final GlobalKey businessTileKey = GlobalKey();
  bool businessExpansionKey = false;
  bool businessreadMore = false;

  List section2analyticsFunction = [];
  List section1analytics = [];
  int isUser;

  /// section type 1 variables

  List sectionOneIcons = [
    "assets/images/ic_total_solar.png",
    "assets/images/ic_eclipse_red_hq.png",
  ];

  /// annularity tool variables

  final List<EclipseTimings> cities_2023 = city_2023;
  final List<EclipseTimings> cities_2024 = city_2024;
  bool annularityExpansionKey = false;
  final GlobalKey expansionTileKey = GlobalKey();
  String selected_city;
  int city_index;
  int selected_index;
  String intial_city = "Bandera";
  String intial_year = "2023";
  String selected_year = "2023";
  List year = ["2023", "2024"];
  List city2 = cityList2;
  List city = cityList1;

  /// section type 2 variables

  Map<int, bool> expansionStateMap2 = {};
  List<bool> expansionStatus = [false, false, false, false, false];
  List<bool> listLengths = [false, false, false, false, false];
  List<bool> listStatus = [];
  Map<int, bool> expansionListLength = {};
  String rent_a_home_link =
      "https://www.backroadstexas.net/?search=search&regionKey=0&priceTag=0&propertyView=0&propertyType=0&one_night_stay=&pet_friendly=0&pooltype=0&hottub=0&hourse_welcome=0&fromDate=04%2F08%2F2024&toDate=04%2F09%2F2024&guestCnt=0/#findVacationHome";
  List readMore2 = [];
  List listLength = [];
  List tileIcons = [
    "assets/images/ic_home_red2.png",
    "assets/images/ic_take_an_rv_low.png",
    "assets/images/ic_tent.png",
    "assets/images/ic_town.png",
    "assets/images/ic_town.png"
  ];

  /// prepare your business textfields

  TextEditingController b_name_controller = TextEditingController();
  TextEditingController business_name_controller = TextEditingController();
  TextEditingController b_city_controller = TextEditingController();
  TextEditingController b_antiques_controller = TextEditingController();
  // TextEditingController b_phone_controller = TextEditingController();
  MaskedTextController b_phone_controller =
      MaskedTextController(mask: '000-000-0000');
  TextEditingController b_email_controller = TextEditingController();
  TextEditingController b_tellus_controller = TextEditingController();
  bool business_intrested = false;
  bool EclipseTravelSkp = false;

  /// Rent your property variables

  bool rentPropertyExpansionKey = false;
  final GlobalKey expansionTileKey2 = GlobalKey();
  bool contactMe = true;
  String parking_rv;
  String contact_me = "yes";
  bool rv_parking_intrest = false;
  List intreseted_year = ["2023 Eclipse", "2024 Eclipse", "Both"];
  int select_intrest_year;
  String intrest_year = "";
  bool network_status = true;
  String message;
  bool loading = false;
  bool form_response = false;

  /// Rent your property textfields

  TextEditingController name_controller = TextEditingController();
  MaskedTextController phone_controller =
      MaskedTextController(mask: '000-000-0000');
  TextEditingController email_controller = TextEditingController();
  TextEditingController property_address_controller = TextEditingController();
  TextEditingController city_controller = TextEditingController();
  TextEditingController state_controller = TextEditingController();
  TextEditingController zip_controller = TextEditingController();
  TextEditingController tell_us_controller = TextEditingController();
  TextEditingController usable_acer_controller = TextEditingController();

  ///Rent your property validation key

  bool name_valid = false;
  bool phone_valid = false;
  bool email_valid = false;
  bool address_valid = false;
  bool city_valid = false;
  bool state_valid = false;
  bool zip_valid = false;
  bool usable_valid = false;
  bool tell_us_valid = false;

  /// resources section variables

  bool resourcesExpansionKey = false;
  final GlobalKey expansionTileKey3 = GlobalKey();

  /// keys for business form validation

  bool b_name_valid = false;
  bool b_business_name_valid = false;
  bool b_city_valid = false;
  bool b_antiques_valid = false;
  bool b_phone_valid = false;
  bool b_email_valid = false;
  bool b_tell_us_valid = false;

  bool businessLoader = false;
  String businessMessage = "";
  bool eclipseGearReadMore = false;

  String selectedBusinessType;

  List<String> businessTypes = [];
  String eclipseGearUrl = "https://www.bkrds.com/eclipse-tshirt";
  List<bool> type5Expansions;
  int type5Count = 5;

  @override
  void initState() {
    super.initState();
    expansionKeys = [
      expansionTileKey4,
      expansionTileKey5,
      expansionTileKey6,
      expansionTileKey7
    ];
    expansionKeys3 = [
      expansionTileKey10,
      expansionTileKe11,
      expansionTileKey12,
      expansionTileKey13,
      expansionTileKey14
    ];
    getIsLogin();
    connectivity();
    eclipseBloc.getEclipseData();
    section1Keys = [expansionTileKey8, expansionTileKey9];
    //section2analyticsFunction=[CountryEclipseAnalytics.visitingRentAHome(isUser),CountryEclipseAnalytics.visitTakeRv(isUser),CountryEclipseAnalytics.visitTentCamping(isUser)];
    // section1analytics=[CountryEclipseAnalytics.visitRingsOfFire(isUser),CountryEclipseAnalytics.visitTotalSolar(isUser)];
  }

  final ScrollController businessFormController = ScrollController();

  @override
  Widget build(BuildContext context) {
    /// Eclipse gear section widget

    Widget eclipseGear(EclipseDataModel eclipseDataModel) {
      return ListView.builder(
          itemCount: eclipseDataModel.sections.length,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            if (eclipseDataModel.sections[index].type == 5) {
              return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: Container(
                  margin: EdgeInsets.only(bottom: 9),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: ExpansionTile(
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          eclipseDataModel.sections[index].icon != null
                              ? Container(
                                  height: 21.5, width: 23.5,
                                  child: CachedNetworkImage(
                                    imageUrl: ApiTools.imageBaseURL +
                                        eclipseDataModel.sections[index].icon,
                                    placeholder: (context, url) => Image.asset(
                                        "assets/images/ic_eclipse_gear.png"),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            "assets/images/ic_eclipse_gear.png"),
                                  ),
                                  // child: Image.network("https://backroadscms.zoondia.org"+ eclipseDataModel.sections[index].icon)
                                )
                              : Container(height: 21.5, width: 23.5),
                          SizedBox(
                            width: 8.5,
                          ),
                          Flexible(
                            child: Container(
                              child: Text(
                                eclipseDataModel.sections[index].title ?? "",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: "bebasPro",
                                  color: ColorUtil.brownA1,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ]),
                    trailing:
                        eclipseDataModel.sections[index].details.isExpand ==
                                true
                            ? Image.asset("assets/images/group_6_5.png")
                            : Container(
                                height: 26.5,
                                width: 26.5,
                                decoration: BoxDecoration(
                                    color: Color(0xfff4ede4),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: Icon(
                                  Icons.add,
                                  color: Color(0xffe0484c),
                                  size: 25,
                                ),
                              ),
                    key: expansionTileKey15,
                    onExpansionChanged: (isExpanded) {
                      _scrollToSelectedContent(
                          expansionTileKey: expansionTileKey15);
                      isExpanded == true ? eclipseType1Analytics(index) : null;
                      setState(() {
                        eclipseDataModel.sections[index].details.isExpand =
                            isExpanded;
                      });
                    },
                    children: <Widget>[
                      ListTile(
                          title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            FloatColumn(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Floatable(
                                  float: FCFloat.start,
                                  child: InkWell(
                                    onTap: () {
                                      if (eclipseDataModel
                                              .sections[index].details.image1 !=
                                          null) {
                                        pinchImagePopUp(eclipseDataModel
                                                .sections[index]
                                                .details
                                                .image1 ??
                                            null);
                                      }

                                      // setState((){
                                      //   eclipseDataModel.sections[index].details.image1Zoomed = ! eclipseDataModel.sections[index].details.image1Zoomed;
                                      // });
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(right: 10, bottom: 5),
                                      height:
                                          (MediaQuery.of(context).size.width *
                                              0.34),
                                      width: MediaQuery.of(context).size.width *
                                          0.32,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        //  color: Colors.green
                                      ),
                                      child: eclipseDataModel.sections[index]
                                                  .details.image1 !=
                                              null
                                          ? CachedNetworkImage(
                                              fit: BoxFit.contain,
                                              imageUrl: ApiTools.imageBaseURL +
                                                  eclipseDataModel
                                                      .sections[index]
                                                      .details
                                                      .image1,
                                              //imageUrl: "https://backroadscms.zoondia.org/uploads/eclipse/info-details/Screenshot_2022-10-28_131547.png",
                                              placeholder: (context, url) =>
                                                  Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                color: Colors.transparent,
                                              )),
                                              fadeOutDuration:
                                                  Duration(milliseconds: 1),
                                              fadeInDuration:
                                                  Duration(milliseconds: 3),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            )
                                          : Container(),
                                    ),
                                  ),
                                ),
                                Floatable(
                                  float: FCFloat.end,
                                  clear: FCClear.both,
                                  clearMinSpacing: 90,
                                  // padding: EdgeInsets.only(left: 8),
                                  child: InkWell(
                                    onTap: () {
                                      if (eclipseDataModel
                                              .sections[index].details.image2 !=
                                          null) {
                                        pinchImagePopUp(eclipseDataModel
                                            .sections[index].details.image2);
                                      }

                                      // setState((){
                                      //   eclipseDataModel.sections[index].details.image2Zoomed = !eclipseDataModel.sections[index].details.image2Zoomed;
                                      // });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: 10,
                                      ),
                                      height:
                                          (MediaQuery.of(context).size.width *
                                              0.34),
                                      width: MediaQuery.of(context).size.width *
                                          0.32,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        // image: DecorationImage(
                                        //   fit: BoxFit
                                        //       .cover,
                                        //   image: NetworkImage(
                                        //       "https://backroadscms.zoondia.org/" +
                                        //           snapshot
                                        //               .data
                                        //               .sections[index]
                                        //               .details
                                        //               .image2),
                                        // ),
                                      ),
                                      child: eclipseDataModel.sections[index]
                                                  .details.image2 !=
                                              null
                                          ? CachedNetworkImage(
                                              fit: BoxFit.contain,
                                              imageUrl: ApiTools.imageBaseURL +
                                                  eclipseDataModel
                                                      .sections[index]
                                                      .details
                                                      .image2,
                                              //imageUrl: "https://backroadscms.zoondia.org/uploads/eclipse/info-details/Screenshot_2022-10-28_131547.png",
                                              placeholder: (context, url) =>
                                                  Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                color: Colors.transparent,
                                              )),
                                              fadeOutDuration:
                                                  Duration(milliseconds: 1),
                                              fadeInDuration:
                                                  Duration(milliseconds: 3),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            )
                                          : Container(),
                                    ),
                                  ),
                                ),
                                Text(
                                  eclipseDataModel
                                      .sections[index].details.content,
                                  maxLines: eclipseDataModel.sections[index]
                                              .details.readMore ==
                                          true
                                      ? null
                                      : 25,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    height: 1.1,
                                    fontFamily: "bebasPro",
                                    color: ColorUtil.brownA1,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  isReadMoreNeeded(eclipseDataModel
                                          .sections[index].details.content)
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                eclipseDataModel.sections[index]
                                                        .details.readMore =
                                                    !eclipseDataModel
                                                        .sections[index]
                                                        .details
                                                        .readMore;
                                              });

                                              if (eclipseDataModel
                                                      .sections[index]
                                                      .details
                                                      .readMore ==
                                                  false) {
                                                _scrollToSelectedContent(
                                                    expansionTileKey:
                                                        expansionTileKey15);
                                              }
                                            },
                                            child: Text(
                                              eclipseDataModel.sections[index]
                                                          .details.readMore ==
                                                      true
                                                  ? 'Read less'
                                                  : 'Read More',
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: ColorUtil.redA3,
                                                fontFamily: "bebasPro",
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  Spacer(),
                                  InkWell(
                                      onTap: () {
                                        _launchUrl(Uri.parse(eclipseGearUrl));
                                      },
                                      child: Container(
                                          height: 36.5,
                                          decoration: BoxDecoration(
                                              color: ColorUtil.redA3,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: 9.5,
                                              right: 6.5,
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(width: 5),
                                                  Text(
                                                    "Buy Gear",
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 8,
                                                    style: TextStyle(
                                                      fontFamily: "bebasPro",
                                                      color: ColorUtil.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8.5,
                                                  ),
                                                  Container(
                                                    height: 20,
                                                    width: 20,
                                                    child: Image.asset(
                                                        "assets/images/spot_btn2.png",
                                                        fit: BoxFit.contain),
                                                  )
                                                ]),
                                          )))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ]))
                    ],
                  ),
                ),
              );
            }
            return Container();
          });
    }

    Widget bussinessForms(
        TextEditingController textEditingController,
        TextInputType textInputType,
        String hintText,
        bool maxline,
        bool errorStatus) {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: TextField(
          keyboardType: textInputType,
          controller: textEditingController,
          maxLines: maxline != true ? 1 : 4,
          style: TextStyle(
            fontFamily: "bebasPro",
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Color(0xffc0c0c0))),
              focusedErrorBorder: new OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Color(0xffc0c0c0))),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Color(0xffc0c0c0))),
              contentPadding:
                  EdgeInsets.only(left: 12, top: 13.5, bottom: 13.5),
              hintText: hintText,
              errorText: errorStatus ? TextConstants.textfield_error_msg : null,
              errorStyle: TextStyle(
                fontFamily: "bebasPro",
                color: Colors.red,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              hintStyle: TextStyle(
                fontFamily: "bebasPro",
                color: Color(0xff6d6964),
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.red, width: 5.0),
              )),
        ),
      );
    }

    Widget prepareBusinessForm() {
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      bussinessForms(b_name_controller, TextInputType.text,
                          "Name", false, b_name_valid),
                      bussinessForms(
                          business_name_controller,
                          TextInputType.text,
                          "Business Name",
                          false,
                          b_business_name_valid),
                      bussinessForms(b_city_controller, TextInputType.text,
                          "City", false, b_city_valid),
                      Container(
                        margin: EdgeInsets.only(bottom: 9),
                        width: double.infinity,
                        child: DropdownButtonFormField<String>(
                          menuMaxHeight: 300,
                          value: selectedBusinessType,
                          style: TextStyle(
                            fontFamily: "bebasPro",
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          items: businessTypes.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontFamily: "bebasPro",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String selected) {
                            setState(() {
                              selectedBusinessType = selected;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: "Type of Business",
                              errorText: b_antiques_valid
                                  ? TextConstants.textfield_error_msg
                                  : null,
                              errorStyle: TextStyle(
                                  fontFamily: "bebasPro", color: Colors.red),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      BorderSide(color: Color(0xffc0c0c0))),
                              focusedErrorBorder: new OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      BorderSide(color: Color(0xffc0c0c0))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      BorderSide(color: Color(0xffc0c0c0))),
                              contentPadding: EdgeInsets.only(
                                  left: 12, top: 13.5, bottom: 13.5),
                              hintStyle: TextStyle(
                                fontFamily: "bebasPro",
                                color: Color(0xff6d6964),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 5.0),
                              )),
                        ),
                      ),
                      bussinessForms(b_phone_controller, TextInputType.number,
                          "Phone Number", false, b_phone_valid),
                      bussinessForms(
                          b_email_controller,
                          TextInputType.emailAddress,
                          "Email Address",
                          false,
                          b_email_valid),
                      bussinessForms(
                          b_tellus_controller,
                          TextInputType.text,
                          "Tell Us More About Your Business",
                          true,
                          b_tell_us_valid),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: Container(
                              child: business_intrested
                                  ? Image.asset("assets/images/group_6_2.png")
                                  : Container(
                                      height: 20.5,
                                      width: 20.5,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorUtil.redA3),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                    ),
                            ),
                            onTap: () {
                              setState(() {
                                business_intrested = !business_intrested;
                              });
                            },
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Text(
                              "Are you intrested in promoting your business in our Hill Country Travel App ?",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: "bebasPro",
                                color: ColorUtil.brownA2,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                      StreamBuilder<PrepareBusinessResponseModel>(
                          stream: _businessMailBloc.businessMailStream,
                          builder: (context, snapshot) {
                            return GestureDetector(
                              onTap: () async {
                                setState(() {
                                  businessLoader = true;
                                });

                                if (business_form_validation(
                                        b_name_controller.text,
                                        business_name_controller.text,
                                        b_city_controller.text,
                                        selectedBusinessType,
                                        b_phone_controller.text,
                                        b_email_controller.text,
                                        b_tellus_controller.text) ==
                                    true) {
                                  bool result =
                                      await _businessMailBloc.businessMail(
                                          b_name_controller.text,
                                          business_name_controller.text,
                                          b_city_controller.text,
                                          selectedBusinessType,
                                          b_phone_controller.text,
                                          b_email_controller.text,
                                          b_tellus_controller.text,
                                          business_intrested ? "Yes" : "No");

                                  result == true
                                      ? print("Your message was sent")
                                      : print("Message sending failed");

                                  setState(() {
                                    result == true
                                        ? businessLoader = false
                                        : businessLoader = false;
                                    result == true
                                        ? businessMessage =
                                            "Your message was sent"
                                        : businessMessage =
                                            "Some thing went wrong";
                                  });
                                  clearBusinessTextfield(true);
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                height: 39,
                                decoration: BoxDecoration(
                                    color: Color(0xffa3ab5d),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Center(
                                  child: Text(
                                    "SUBMIT",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: "bebasPro",
                                      color: ColorUtil.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      businessLoader == true
                          ? SpinKitCircle(
                              color: Colors.red,
                              size: 25,
                            )
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          businessMessage,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: "bebasPro",
                            color: ColorUtil.redA3,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ]))
          ]);
    }

    /// unused
    Widget eclipseResources(Section deta) {
      return deta.type == 3
          ? ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: deta.details.content.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: deta.details.content[index]["heading"] == null
                          ? Container()
                          : Text(
                              deta.details.content[index]["heading"],
                              style: TextStyle(
                                fontFamily: "bebasPro",
                                color: ColorUtil.brownA1,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: deta.details.content[index]["data"].length,
                        itemBuilder: (BuildContext context, int e) {
                          return Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: deta.details.content[index]["data"][e]
                                        ["phrase"],
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontFamily: "bebasPro",
                                      color: ColorUtil.redA3,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        var url = ((deta
                                                    .details
                                                    .content[index]["data"][e]
                                                        ["link"]
                                                    .toString()
                                                    .contains("https://")) ||
                                                (deta
                                                    .details
                                                    .content[index]["data"][e]
                                                        ["link"]
                                                    .toString()
                                                    .contains("http://"))
                                            ? deta
                                                .details
                                                .content[index]["data"][e]
                                                    ["link"]
                                                .toString()
                                            : "https://" +
                                                deta
                                                    .details
                                                    .content[index]["data"][e]
                                                        ["link"]
                                                    .toString());
                                        // if (await canLaunch(url)) {
                                        //   await launch(url);
                                        // } else {
                                        //   throw 'Could not launch $url';
                                        // }
                                        _launchUrl(Uri.parse(url));
                                        CountryEclipseAnalytics
                                            .visitResourceLink(
                                                deta.details.content[index]
                                                    ["data"][e]["phrase"],
                                                isUser);
                                      }),
                              ])));
                        }),
                  ],
                );
              })
          : Container();
    }

    /// resource section new

    Widget resourcesSections(EclipseDataModel data) {
      return ListView.builder(
          itemCount: data.sections.length,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            if (data.sections[index].type == 3) {
              return Container(
                margin: EdgeInsets.only(top: 9),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: ExpansionTile(
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 21.5,
                              width: 23.5,
                              child: Image.asset(
                                "assets/images/ic_search_red_hq.png",
                                color: ColorUtil.redA3,
                              ),
                            ),
                            SizedBox(
                              width: 8.5,
                            ),
                            Expanded(
                              child: Text(
                                data.sections[index].title,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: "bebasPro",
                                  color: ColorUtil.brownA1,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ]),
                      trailing: resourcesExpansionKey
                          ? Image.asset("assets/images/group_6_5.png")
                          : Container(
                              height: 26.5,
                              width: 26.5,
                              decoration: BoxDecoration(
                                  color: Color(0xfff4ede4),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Icon(
                                Icons.add,
                                color: Color(0xffe0484c),
                                size: 25,
                              ),
                            ),
                      key: expansionTileKey3,
                      onExpansionChanged: (bool expanded) {
                        _scrollToSelectedContent(
                            expansionTileKey: expansionTileKey3);
                        setState(() => resourcesExpansionKey = expanded);
                        if (expanded == true)
                          CountryEclipseAnalytics.visitEclipseResourcesSection(
                              isUser);
                      },
                      children: <Widget>[
                        ListTile(
                            title: Padding(
                                padding: EdgeInsets.only(right: 24.5),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // SizedBox(
                                      //   height: 10.5,
                                      // ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: data.sections
                                            .map((e) => eclipseResources(e))
                                            .toList(),
                                      ),

                                      SizedBox(
                                        height: 23,
                                      ),
                                    ])))
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          });
    }

    /// section type 1 tile

    Widget sectionTile1(EclipseDataModel data) {
      return ListView.builder(
          itemCount: data.sections.length,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            if (data.sections[index].type == 1) {
              readMore.add(false);

              /// section type 1 tiles

              return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: Container(
                  margin: EdgeInsets.only(bottom: 9),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: ExpansionTile(
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: 21.5,
                              width: 23.5,
                              child: Image.asset(sectionOneIcons[index])),
                          SizedBox(
                            width: 8.5,
                          ),
                          Flexible(
                            child: Container(
                              child: Text(
                                data.sections[index].title,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: "bebasPro",
                                  color: ColorUtil.brownA1,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ]),
                    trailing: expansionStateMap[index] == true
                        ? Image.asset("assets/images/group_6_5.png")
                        : Container(
                            height: 26.5,
                            width: 26.5,
                            decoration: BoxDecoration(
                                color: Color(0xfff4ede4),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Icon(
                              Icons.add,
                              color: Color(0xffe0484c),
                              size: 25,
                            ),
                          ),
                    key: section1Keys[index],
                    onExpansionChanged: (isExpanded) {
                      _scrollToSelectedContent(
                          expansionTileKey: section1Keys[index]);
                      isExpanded == true ? eclipseType1Analytics(index) : null;
                      setState(() {
                        expansionStateMap[index] = isExpanded;
                      });
                    },
                    children: <Widget>[
                      ListTile(
                          title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            FloatColumn(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Floatable(
                                  float: FCFloat.start,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: (MediaQuery.of(context).size.width *
                                            0.32) *
                                        0.90,
                                    width: MediaQuery.of(context).size.width *
                                        0.32,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          "https://backroadscms.zoondia.org/" +
                                              data.sections[index].details
                                                  .image1,
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(
                                        color: Colors.transparent,
                                      )),
                                      fadeOutDuration:
                                          Duration(milliseconds: 1),
                                      fadeInDuration: Duration(milliseconds: 3),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Floatable(
                                  float: FCFloat.end,
                                  clear: FCClear.both,
                                  clearMinSpacing: 90,
                                  // padding: EdgeInsets.only(left: 8),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      top: 10,
                                    ),
                                    height: (MediaQuery.of(context).size.width *
                                            0.32) *
                                        0.90,
                                    width: MediaQuery.of(context).size.width *
                                        0.32,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      // image: DecorationImage(
                                      //   fit: BoxFit
                                      //       .cover,
                                      //   image: NetworkImage(
                                      //       "https://backroadscms.zoondia.org/" +
                                      //           snapshot
                                      //               .data
                                      //               .sections[index]
                                      //               .details
                                      //               .image2),
                                      // ),
                                    ),
                                    child: new CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          "https://backroadscms.zoondia.org/" +
                                              data.sections[index].details
                                                  .image2,
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(
                                        color: Colors.transparent,
                                      )),
                                      fadeOutDuration:
                                          Duration(milliseconds: 1),
                                      fadeInDuration: Duration(milliseconds: 3),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Text(
                                  data.sections[index].details.content,
                                  maxLines: readMore[index] == true ? null : 30,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    height: 1.1,
                                    fontFamily: "bebasPro",
                                    color: ColorUtil.brownA1,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    readMore[index] = !readMore[index];
                                  });

                                  if (readMore[index] == false) {
                                    _scrollToSelectedContent(
                                        expansionTileKey: section1Keys[index]);
                                  }
                                },
                                child: Text(
                                  readMore[index] == true
                                      ? 'Read less'
                                      : 'Read More',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: ColorUtil.redA3,
                                    fontFamily: "bebasPro",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ]))
                    ],
                  ),
                ),
              );
            }
            return Container();
          });
    }

    Widget annularityTool() {
      return Container(
        margin: EdgeInsets.only(bottom: 9),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: ExpansionTile(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 21.5,
                        width: 23.5,
                        child: Image.asset(
                            "assets/images/ic_eclipse_calculator.png")),
                    SizedBox(
                      width: 8.5,
                    ),
                    Expanded(
                      child: Text(
                        "Annularity and Totality Tool",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: "bebasPro",
                          color: ColorUtil.brownA1,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ]),
              trailing: annularityExpansionKey
                  ? Image.asset("assets/images/group_6_5.png")
                  : Container(
                      height: 26.5,
                      width: 26.5,
                      decoration: BoxDecoration(
                          color: Color(0xfff4ede4),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Icon(
                        Icons.add,
                        color: Color(0xffe0484c),
                        size: 25,
                      ),
                    ),
              key: expansionTileKey,
              onExpansionChanged: (bool expanded) {
                _scrollToSelectedContent(expansionTileKey: expansionTileKey);
                setState(() => annularityExpansionKey = expanded);

                if (expanded == true)
                  CountryEclipseAnalytics.visitTotalityTool(isUser);
              },
              children: <Widget>[
                ListTile(
                    title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: GestureDetector(
                                child: Container(
                                  height: 36.5,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: ColorUtil.grayA4),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      intial_year,
                                      textScaleFactor: MediaQuery.of(context)
                                                  .textScaleFactor >
                                              1
                                          ? (MediaQuery.of(context)
                                                  .textScaleFactor *
                                              0.9)
                                          : 1.2,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: "bebasPro",
                                        color: ColorUtil.brownA1,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {});
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                          color: Color(0xff3e3227),
                                          height: 200,
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 15, bottom: 5),
                                              child: ListView.builder(
                                                  itemCount: year.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return GestureDetector(
                                                      child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 10),
                                                          child: Center(
                                                              child: Text(
                                                            year[index],
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "bebasPro",
                                                              color: ColorUtil
                                                                  .yellowOrange,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 22,
                                                            ),
                                                          ))),
                                                      onTap: () {
                                                        setState(() {
                                                          intial_year =
                                                              year[index];
                                                          selected_year =
                                                              intial_year;
                                                          //checker = selected_year;

                                                          if (selected_year ==
                                                              year[0]) {
                                                            if (city2.contains(
                                                                    selected_city) ==
                                                                false) {
                                                              selected_city =
                                                                  null;
                                                            } else {
                                                              city_index =
                                                                  city2.indexOf(
                                                                      selected_city);
                                                            }
                                                          } else {
                                                            if (city.contains(
                                                                    selected_city) ==
                                                                false) {
                                                              selected_city =
                                                                  null;
                                                            } else {
                                                              city_index =
                                                                  city.indexOf(
                                                                      selected_city);
                                                            }
                                                          }

                                                          // selected_city = null;
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                        if (selected_city !=
                                                            null) {
                                                          if (selected_year ==
                                                              year[0]) {
                                                            CountryEclipseAnalytics
                                                                .searchTotality_2023(
                                                                    2023,
                                                                    selected_city,
                                                                    isUser);
                                                          } else {
                                                            CountryEclipseAnalytics
                                                                .searchTotality_2024(
                                                                    2024,
                                                                    selected_city,
                                                                    isUser);
                                                          }
                                                        } else {
                                                          if (selected_year ==
                                                              year[0]) {
                                                            CountryEclipseAnalytics
                                                                .searchTotality_2023(
                                                                    2023,
                                                                    "Bandera",
                                                                    isUser);
                                                          } else {
                                                            CountryEclipseAnalytics
                                                                .searchTotality_2024(
                                                                    2024,
                                                                    "Bandera",
                                                                    isUser);
                                                          }
                                                        }
                                                      },
                                                    );
                                                  }),
                                            ),
                                          ));
                                    },
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 8.5,
                            ),
                            Expanded(
                              child: InkWell(
                                child: Container(
                                  width: double.infinity,
                                  height: 36.5,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: ColorUtil.grayA4),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Padding(
                                    padding: EdgeInsets.all(7),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              selected_city == null
                                                  ? "Bandera"
                                                  : intial_city,
                                              overflow: TextOverflow.ellipsis,
                                              textScaleFactor:
                                                  MediaQuery.of(context)
                                                              .textScaleFactor >
                                                          1
                                                      ? (MediaQuery.of(context)
                                                              .textScaleFactor *
                                                          1.0)
                                                      : 1.3,
                                              style: TextStyle(
                                                fontFamily: "bebasPro",
                                                color: ColorUtil.brownA1,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Icon(Icons.arrow_drop_down_sharp)
                                        ]),
                                  ),
                                ),
                                onTap: () {
                                  selected_year != null
                                      ? showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                                color: Color(0xff3e3227),
                                                height: 200,
                                                child: Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 15, bottom: 5),
                                                    child: ListView.builder(
                                                        itemCount: selected_year ==
                                                                    year[0] ||
                                                                selected_year ==
                                                                    null
                                                            ? city2.length
                                                            : city.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return InkWell(
                                                            child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            10),
                                                                child: Center(
                                                                    child: Text(
                                                                  selected_year ==
                                                                              year[
                                                                                  0] ||
                                                                          selected_year ==
                                                                              null
                                                                      ? city2[
                                                                          index]
                                                                      : city[
                                                                          index],
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "bebasPro",
                                                                    color: ColorUtil
                                                                        .yellowOrange,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        22,
                                                                  ),
                                                                ))),
                                                            onTap: () {
                                                              setState(() {
                                                                intial_city = selected_year ==
                                                                            year[
                                                                                0] ||
                                                                        selected_year ==
                                                                            null
                                                                    ? city2[
                                                                        index]
                                                                    : city[
                                                                        index];
                                                                print(
                                                                    intial_city);

                                                                city_index = selected_year ==
                                                                        year[0]
                                                                    ? city2.indexOf(
                                                                        intial_city)
                                                                    : city.indexOf(
                                                                        intial_city);

                                                                print(
                                                                    city_index);

                                                                selected_city =
                                                                    intial_city;

                                                                if (selected_year ==
                                                                    year[0]) {
                                                                  CountryEclipseAnalytics
                                                                      .searchTotality_2023(
                                                                          2023,
                                                                          selected_city,
                                                                          isUser);
                                                                } else {
                                                                  CountryEclipseAnalytics
                                                                      .searchTotality_2024(
                                                                          2024,
                                                                          selected_city,
                                                                          isUser);
                                                                }
                                                              });

                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          );
                                                        }),
                                                  ),
                                                ));
                                          },
                                        )
                                      : null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10.5,
                            ),
                          ]),
                      SizedBox(
                        height: 10.5,
                      ),
                      //Eclipse calculator new Design

                      selected_city == null
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Color(0xfff1e8d9),
                                  border: Border.all(
                                      color:
                                          Color(0xffc0c0c0).withOpacity(0.5))),
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/img_annularity_bg.png"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10,
                                      right: 9.5,
                                      top: 23,
                                      bottom: 25),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            "BANDERA",
                                            style: TextStyle(
                                              fontFamily: "bebasPro",
                                              color: ColorUtil.brownA1,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 23,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 10,
                                          ),
                                          child: DottedLine(
                                            direction: Axis.horizontal,
                                            lineLength: double.infinity,
                                            lineThickness: 0.5,
                                            dashLength: 3,
                                            dashColor: Colors.black,
                                            dashRadius: 50,
                                            dashGapLength: 1,
                                            dashGapColor: Colors.transparent,
                                            dashGapRadius: 0.0,
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(top: 15),
                                            decoration: BoxDecoration(),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            "Entire Eclipse Duration",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "bebasPro",
                                                              color: ColorUtil
                                                                  .brownA1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 23,
                                                            )),
                                                        Text(
                                                            selected_year ==
                                                                    year[0]
                                                                ? city_2023[1]
                                                                    .entireDuration
                                                                    .toString()
                                                                : city_2024[1]
                                                                    .entireDuration,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "bebasPro",
                                                              color: ColorUtil
                                                                  .brownA1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 19,
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 23),
                                                  Center(
                                                    child: Container(
                                                      height: 30,
                                                      child: Image.asset(
                                                          "assets/images/img_eclipse_cycle.png",
                                                          fit: BoxFit.contain),
                                                    ),
                                                  ),
                                                  SizedBox(height: 24),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 11),
                                                    child: Container(
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                  "Partial Begins",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "bebasPro",
                                                                    color: ColorUtil
                                                                        .brownA1,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        21,
                                                                  )),
                                                            ),
                                                            Spacer(),
                                                            Text(
                                                                selected_year ==
                                                                        year[0]
                                                                    ? city_2023[
                                                                            1]
                                                                        .partialBegin
                                                                        .toString()
                                                                    : city_2024[
                                                                            1]
                                                                        .partialBegin,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "bebasPro",
                                                                  color: ColorUtil
                                                                      .brownA1,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 21,
                                                                )),
                                                          ]),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 28),
                                                    child: Container(
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                  selected_year ==
                                                                          year[
                                                                              0]
                                                                      ? "Annularity Begins"
                                                                      : "Totality Begins",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "bebasPro",
                                                                    color: ColorUtil
                                                                        .brownA1,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        21,
                                                                  )),
                                                            ),
                                                            Spacer(),
                                                            Text(
                                                                selected_year ==
                                                                        year[0]
                                                                    ? city_2023[
                                                                            1]
                                                                        .annularBegin
                                                                        .toString()
                                                                    : city_2024[
                                                                            1]
                                                                        .annularBegin,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "bebasPro",
                                                                  color: ColorUtil
                                                                      .brownA1,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 21,
                                                                )),
                                                          ]),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            selected_year ==
                                                                    year[0]
                                                                ? "DURATION OF ANNULARITY"
                                                                : "DURATION OF TOTALITY",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "bebasPro",
                                                              color: ColorUtil
                                                                  .brownA1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 27,
                                                            )),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                "${selected_year == year[0] ? city_2023[1].annularDuration.toString() : city_2024[1].annularDuration}",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "bebasPro",
                                                                  color: ColorUtil
                                                                      .brownA1,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      25.5,
                                                                )),
                                                            // SizedBox(width:13.5),
                                                            // Container(height:34.5,width:34.5,child:Image
                                                            //     .asset(
                                                            //     "assets/images/img_full_eclipse.png"))
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 32, bottom: 11),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                              selected_year ==
                                                                      year[0]
                                                                  ? "Annularity Ends"
                                                                  : "Totality Ends",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "bebasPro",
                                                                color: ColorUtil
                                                                    .brownA1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 21,
                                                              )),
                                                          Spacer(),
                                                          Text(
                                                              selected_year ==
                                                                      year[0]
                                                                  ? city_2023[1]
                                                                      .annularEnd
                                                                      .toString()
                                                                  : city_2024[1]
                                                                      .annularEnd,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "bebasPro",
                                                                color: ColorUtil
                                                                    .brownA1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 21,
                                                              )),
                                                        ]),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text("Partial Ends",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "bebasPro",
                                                                color: ColorUtil
                                                                    .brownA1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 21,
                                                              )),
                                                          Spacer(),
                                                          Text(
                                                              selected_year ==
                                                                      year[0]
                                                                  ? city_2023[1]
                                                                      .partialEnd
                                                                      .toString()
                                                                  : city_2024[1]
                                                                      .partialEnd,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "bebasPro",
                                                                color: ColorUtil
                                                                    .brownA1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 21,
                                                              )),
                                                        ]),
                                                  ),
                                                ])),
                                      ]),
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Color(0xfff1e8d9),
                                  border: Border.all(
                                      color:
                                          Color(0xffc0c0c0).withOpacity(0.5))),
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/img_annularity_bg.png"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10,
                                      right: 9.5,
                                      top: 23,
                                      bottom: 25),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            intial_city.toUpperCase(),
                                            style: TextStyle(
                                              fontFamily: "bebasPro",
                                              color: ColorUtil.brownA1,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 23,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 10,
                                          ),
                                          child: DottedLine(
                                            direction: Axis.horizontal,
                                            lineLength: double.infinity,
                                            lineThickness: 0.5,
                                            dashLength: 3,
                                            dashColor: Colors.black,
                                            dashRadius: 50,
                                            dashGapLength: 1,
                                            dashGapColor: Colors.transparent,
                                            dashGapRadius: 0.0,
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(top: 15),
                                            decoration: BoxDecoration(),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                              "Entire Eclipse Duration",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "bebasPro",
                                                                color: ColorUtil
                                                                    .brownA1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 23,
                                                              )),
                                                          Text(
                                                              selected_year ==
                                                                      year[0]
                                                                  ? city_2023[
                                                                          city_index]
                                                                      .entireDuration
                                                                  : city_2024[
                                                                          city_index]
                                                                      .entireDuration,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "bebasPro",
                                                                color: ColorUtil
                                                                    .brownA1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 19,
                                                              ))
                                                        ]),
                                                  ),
                                                  SizedBox(height: 23),
                                                  Center(
                                                    child: Container(
                                                      height: 30,
                                                      child: Image.asset(
                                                          "assets/images/img_eclipse_cycle.png",
                                                          fit: BoxFit.contain),
                                                    ),
                                                  ),
                                                  SizedBox(height: 24),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 11),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text("Partial Begins",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "bebasPro",
                                                                color: ColorUtil
                                                                    .brownA1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 21,
                                                              )),
                                                          Spacer(),
                                                          Text(
                                                              selected_year ==
                                                                      year[0]
                                                                  ? city_2023[
                                                                          city_index]
                                                                      .partialBegin
                                                                  : city_2024[
                                                                          city_index]
                                                                      .partialBegin,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "bebasPro",
                                                                color: ColorUtil
                                                                    .brownA1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 21,
                                                              )),
                                                        ]),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 28),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                              selected_year ==
                                                                      year[0]
                                                                  ? "Annularity Begins"
                                                                  : "Totality Begins",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "bebasPro",
                                                                color: ColorUtil
                                                                    .brownA1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 21,
                                                              )),
                                                          Spacer(),
                                                          Text(
                                                              selected_year ==
                                                                      year[0]
                                                                  ? city_2023[
                                                                          city_index]
                                                                      .annularBegin
                                                                  : city_2024[
                                                                          city_index]
                                                                      .annularBegin,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "bebasPro",
                                                                color: ColorUtil
                                                                    .brownA1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 21,
                                                              )),
                                                        ]),
                                                  ),
                                                  Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            selected_year ==
                                                                    year[0]
                                                                ? "DURATION OF ANNULARITY"
                                                                : "DURATION OF TOTALITY",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "bebasPro",
                                                              color: ColorUtil
                                                                  .brownA1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 27,
                                                            )),
                                                        Text(
                                                            "${selected_year == year[0] ? city_2023[city_index].annularDuration : city_2024[city_index].annularDuration}",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "bebasPro",
                                                              color: ColorUtil
                                                                  .brownA1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 25.5,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 32, bottom: 11),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                selected_year ==
                                                                        year[0]
                                                                    ? "Annularity Ends"
                                                                    : "Totality Ends",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "bebasPro",
                                                                  color: ColorUtil
                                                                      .brownA1,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 21,
                                                                )),
                                                            Spacer(),
                                                            Text(
                                                                selected_year ==
                                                                        year[0]
                                                                    ? city_2023[
                                                                            city_index]
                                                                        .annularEnd
                                                                    : city_2024[
                                                                            city_index]
                                                                        .annularEnd,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "bebasPro",
                                                                  color: ColorUtil
                                                                      .brownA1,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 21,
                                                                )),
                                                          ]),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text("Partial Ends",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "bebasPro",
                                                                color: ColorUtil
                                                                    .brownA1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 21,
                                                              )),
                                                          Spacer(),
                                                          Text(
                                                              selected_year ==
                                                                      year[0]
                                                                  ? city_2023[
                                                                          city_index]
                                                                      .partialEnd
                                                                  : city_2024[
                                                                          city_index]
                                                                      .partialEnd,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "bebasPro",
                                                                color: ColorUtil
                                                                    .brownA1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 21,
                                                              )),
                                                        ]),
                                                  ),
                                                ])),
                                      ]),
                                ),
                              ),
                            ),

                      SizedBox(height: 10)
                    ]))
              ],
            ),
          ),
        ),
      );
    }

    Widget type2section(EclipseDataModel data, bool removeFirst) {
      jsutIndex = jsutIndex + 1;

      return ListView.builder(
          itemCount: data.sections.length,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (context, indexs) {
            if (data.sections[indexs].type == 2) {
              if (removeFirst
                  ? data.sections[indexs - 1].type != 2
                  : data.sections[indexs - 1].type == 2) {
                return Container();
              } else {
                return Container(
                  margin: EdgeInsets.only(bottom: 9),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: ExpansionTile(
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: 21.5,
                                  width: 23.5,
                                  child: Image.asset(
                                    tileIcons[indexs - 2],
                                    color: ColorUtil.redA3,
                                  )),
                              SizedBox(
                                width: 8.5,
                              ),
                              Expanded(
                                child: Text(
                                  data.sections[indexs].title,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontFamily: "bebasPro",
                                    color: ColorUtil.brownA1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ]),
                        key: expansionKeys3[indexs - 2],
                        trailing: expansionStatus[indexs - 2]
                            ? Image.asset("assets/images/group_6_5.png")
                            : Container(
                                height: 26.5,
                                width: 26.5,
                                decoration: BoxDecoration(
                                    color: Color(0xfff4ede4),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: Icon(
                                  Icons.add,
                                  color: Color(0xffe0484c),
                                  size: 25,
                                ),
                              ),
                        onExpansionChanged: (bool expand) {
                          _scrollToSelectedContent(
                              expansionTileKey: expansionKeys3[indexs - 2]);
                          expand == true
                              ? eclipseType2Analytics(indexs - 2)
                              : null;
                          setState(() {
                            expansionStatus[indexs - 2] =
                                !expansionStatus[indexs - 2];
                          });
                        },
                        children: <Widget>[
                          ListTile(
                              title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Container(
                                  child: DropCapText(
                                      data.sections[indexs].details
                                          .introDescription,
                                      dropCapPadding: EdgeInsets.only(
                                        left: 5,
                                      ),
                                      style: TextStyle(
                                        height: 1.1,
                                        fontFamily: "bebasPro",
                                        color: ColorUtil.brownA1,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.justify,
                                      dropCapPosition: DropCapPosition.end,
                                      dropCap: DropCap(
                                        // height: (MediaQuery
                                        //     .of(context)
                                        //     .size
                                        //     .width * 0.32) * 0.90,
                                        // width: MediaQuery
                                        //     .of(context)
                                        //     .size
                                        //     .width * 0.32,
                                        height:
                                            (MediaQuery.of(context).size.width *
                                                    0.22) /
                                                2,
                                        width:
                                            (MediaQuery.of(context).size.width *
                                                    0.32) /
                                                2,

                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  ApiTools.imageBaseURL +
                                                      data.sections[indexs]
                                                          .details.image1),
                                            ),
                                          ),
                                        ),
                                      )),
                                ),
                                //       :
                                // Container(
                                //   child: DropCapText(
                                //       sections
                                //           .details
                                //           .introDescription,
                                //       dropCapPadding:
                                //       EdgeInsets
                                //           .only(
                                //         left: 5,
                                //       ),
                                //       style: TextStyle(
                                //         height: 1.1,
                                //         fontFamily: "bebasPro",
                                //         color:
                                //         ColorUtil
                                //             .brownA1,
                                //         fontWeight:
                                //         FontWeight
                                //             .w700,
                                //         fontSize: 14,
                                //       ),
                                //       textAlign:
                                //       TextAlign
                                //           .justify,
                                //       dropCapPosition:
                                //       DropCapPosition
                                //           .end,
                                //       dropCap: DropCap(
                                //         height: (MediaQuery
                                //             .of(
                                //             context)
                                //             .size
                                //             .width *
                                //             0.22) /
                                //             2,
                                //         width: (MediaQuery
                                //             .of(
                                //             context)
                                //             .size
                                //             .width *
                                //             0.32) /
                                //             2,
                                //         child: Container(
                                //           decoration:
                                //           BoxDecoration(
                                //             image:
                                //             DecorationImage(
                                //               fit: BoxFit
                                //                   .cover,
                                //               image: NetworkImage(
                                //                   "https://backroadscms.zoondia.org/" + data.sections[index].details.image1),
                                //             ),
                                //           ),
                                //         ),
                                //       )),
                                // ),
                                ListView.builder(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: listLengths[indexs - 2] == true
                                        ? data.sections[indexs].details.content
                                            .length
                                        : 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.sections[indexs].details
                                                    .content[index]["heading"],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontFamily: "bebasPro",
                                                  color: ColorUtil.brownA1,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                data.sections[indexs].details
                                                        .content[index]
                                                    ["paragraph"],
                                                textAlign: TextAlign.justify,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 18,
                                                style: TextStyle(
                                                  fontFamily: "bebasPro",
                                                  color: ColorUtil.brownA1,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ));
                                    }),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      data.sections[indexs].details.content
                                                  .length >
                                              1
                                          ? GestureDetector(
                                              child: Text(
                                                listLengths[indexs - 2]
                                                    ? "Read Less"
                                                    : "Read More",
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontFamily: "bebasPro",
                                                  color: ColorUtil.redA3,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  listLengths[indexs - 2] =
                                                      !listLengths[indexs - 2];
                                                });
                                              },
                                            )
                                          : Container(),
                                      Spacer(),
                                      indexs - 2 < sectionButton.length
                                          ? InkWell(
                                              onTap: () {
                                                _launchUrl(Uri.parse(indexs -
                                                            2 <
                                                        sectionButton.length
                                                    ? sectionButton[indexs - 2]
                                                        .url
                                                    : ""));
                                                eclipseType2ButtonAnalytics(
                                                    indexs - 2);
                                              },
                                              child: Container(
                                                  height: 36.5,
                                                  decoration: BoxDecoration(
                                                      color: ColorUtil.redA3,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8))),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 9.5,
                                                      right: 6.5,
                                                    ),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(width: 5),
                                                          Text(
                                                            indexs - 2 <
                                                                    sectionButton
                                                                        .length
                                                                ? sectionButton[
                                                                        indexs -
                                                                            2]
                                                                    .buttonName
                                                                : "",
                                                            textAlign:
                                                                TextAlign.start,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 8,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "bebasPro",
                                                              color: ColorUtil
                                                                  .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 8.5,
                                                          ),
                                                          Container(
                                                            height: 20,
                                                            width: 20,
                                                            child: Image.asset(
                                                                "assets/images/spot_btn2.png",
                                                                fit: BoxFit
                                                                    .contain),
                                                          )
                                                        ]),
                                                  )))
                                          : Container(),
                                    ]),
                                data.sections[indexs].title.contains("Business")
                                    ? prepareBusinessForm()
                                    : Container(),
                                SizedBox(
                                  height: 28,
                                )
                              ]))
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
            return Container();
          });
    }

    Widget businessFormSection(EclipseDataModel data) {
      return ListView.builder(
          itemCount: data.sections.length,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (context, indexs) {
            if (data.sections[indexs].type == 4) {
              return Container(
                margin: EdgeInsets.only(bottom: 9),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: ExpansionTile(
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 21.5,
                                width: 23.5,
                                child: Image.asset(
                                  tileIcons[indexs - 2],
                                  color: ColorUtil.redA3,
                                )),
                            SizedBox(
                              width: 8.5,
                            ),
                            Expanded(
                              child: Text(
                                data.sections[indexs].title,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: "bebasPro",
                                  color: ColorUtil.brownA1,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ]),
                      trailing: businessExpansionKey
                          ? Image.asset("assets/images/group_6_5.png")
                          : Container(
                              height: 26.5,
                              width: 26.5,
                              decoration: BoxDecoration(
                                  color: Color(0xfff4ede4),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Icon(
                                Icons.add,
                                color: Color(0xffe0484c),
                                size: 25,
                              ),
                            ),
                      key: businessTileKey,
                      onExpansionChanged: (bool expand) {
                        _scrollToSelectedContent(
                            expansionTileKey: businessTileKey);
                        setState(() {
                          businessExpansionKey = !businessExpansionKey;
                        });
                      },
                      children: <Widget>[
                        ListTile(
                            title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Container(
                                child: DropCapText(
                                    data.sections[indexs].details
                                        .introDescription,
                                    dropCapPadding: EdgeInsets.only(
                                      left: 5,
                                    ),
                                    style: TextStyle(
                                      height: 1.1,
                                      fontFamily: "bebasPro",
                                      color: ColorUtil.brownA1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.justify,
                                    dropCapPosition: DropCapPosition.end,
                                    dropCap: DropCap(
                                      height:
                                          (MediaQuery.of(context).size.width *
                                                  0.32) *
                                              0.90,
                                      width: MediaQuery.of(context).size.width *
                                          0.32,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                ApiTools.imageBaseURL +
                                                    data.sections[indexs]
                                                        .details.image1),
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                              //       :
                              // Container(
                              //   child: DropCapText(
                              //       sections
                              //           .details
                              //           .introDescription,
                              //       dropCapPadding:
                              //       EdgeInsets
                              //           .only(
                              //         left: 5,
                              //       ),
                              //       style: TextStyle(
                              //         height: 1.1,
                              //         fontFamily: "bebasPro",
                              //         color:
                              //         ColorUtil
                              //             .brownA1,
                              //         fontWeight:
                              //         FontWeight
                              //             .w700,
                              //         fontSize: 14,
                              //       ),
                              //       textAlign:
                              //       TextAlign
                              //           .justify,
                              //       dropCapPosition:
                              //       DropCapPosition
                              //           .end,
                              //       dropCap: DropCap(
                              //         height: (MediaQuery
                              //             .of(
                              //             context)
                              //             .size
                              //             .width *
                              //             0.22) /
                              //             2,
                              //         width: (MediaQuery
                              //             .of(
                              //             context)
                              //             .size
                              //             .width *
                              //             0.32) /
                              //             2,
                              //         child: Container(
                              //           decoration:
                              //           BoxDecoration(
                              //             image:
                              //             DecorationImage(
                              //               fit: BoxFit
                              //                   .cover,
                              //               image: NetworkImage(
                              //                   "https://backroadscms.zoondia.org/" + data.sections[index].details.image1),
                              //             ),
                              //           ),
                              //         ),
                              //       )),
                              // ),
                              ListView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  //controller: businessFormController,
                                  itemCount: businessreadMore
                                      ? data.sections[indexs].details.content
                                          .length
                                      : 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.sections[indexs].details
                                                  .content[index]["heading"],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontFamily: "bebasPro",
                                                color: ColorUtil.brownA1,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              data.sections[indexs].details
                                                  .content[index]["paragraph"],
                                              textAlign: TextAlign.justify,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 18,
                                              style: TextStyle(
                                                fontFamily: "bebasPro",
                                                color: ColorUtil.brownA1,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ));
                                  }),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      child: Text(
                                        businessreadMore
                                            ? "Read Less"
                                            : "Read More",
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontFamily: "bebasPro",
                                          color: ColorUtil.redA3,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          businessreadMore = !businessreadMore;
                                        });

                                        if (businessreadMore == false) {
                                          _scrollToSelectedContent(
                                              expansionTileKey:
                                                  businessTileKey);
                                        }
                                      },
                                    )
                                  ]),
                              prepareBusinessForm(),
                              SizedBox(
                                height: 28,
                              )
                            ]))
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          });
    }

    Widget sectionType2(EclipseDataModel data) {
      return ListView.builder(
          itemCount: data.sections.length,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (context, indexs) {
            if (data.sections[indexs].type == 2) {
              // readMore2.add(false);
              // listLength.add(false);
              return Container(
                margin: EdgeInsets.only(top: 9),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: ExpansionTile(
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 21.5,
                                width: 23.5,
                                child: Image.asset("assets/images/path.png")),
                            SizedBox(
                              width: 8.5,
                            ),
                            Expanded(
                              child: Text(
                                data.sections[indexs].title,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: "bebasPro",
                                  color: ColorUtil.brownA1,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ]),
                      trailing: expansionStateMap2[indexs] == true
                          ? Image.asset("assets/images/group_6_5.png")
                          : Container(
                              height: 26.5,
                              width: 26.5,
                              decoration: BoxDecoration(
                                  color: Color(0xfff4ede4),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Icon(
                                Icons.add,
                                color: Color(0xffe0484c),
                                size: 25,
                              ),
                            ),
                      key: Key("${indexs}"),
                      onExpansionChanged: (isExpanded) {
                        setState(() {
                          expansionStateMap2[indexs] = isExpanded;
                        });
                        if (isExpanded == true)
                          CountryEclipseAnalytics.visitingRentAHome(isUser);
                      },
                      children: <Widget>[
                        ListTile(
                            title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Container(
                                child: DropCapText(
                                    data.sections[indexs].details
                                        .introDescription,
                                    dropCapPadding: EdgeInsets.only(
                                      left: 5,
                                    ),
                                    style: TextStyle(
                                      height: 1.1,
                                      fontFamily: "bebasPro",
                                      color: ColorUtil.brownA1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.justify,
                                    dropCapPosition: DropCapPosition.end,
                                    dropCap: DropCap(
                                      height:
                                          (MediaQuery.of(context).size.width *
                                                  0.22) /
                                              2,
                                      width:
                                          (MediaQuery.of(context).size.width *
                                                  0.32) /
                                              2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                ApiTools.imageBaseURL +
                                                    data.sections[indexs]
                                                        .details.image1),
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                              ListView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      // listLength[index]
                                      //     ? data
                                      //     .sections[index]
                                      //     .details
                                      //     .content
                                      //     .length
                                      //     :
                                      2,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.sections[indexs].details
                                                  .content[index]["heading"],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontFamily: "bebasPro",
                                                color: ColorUtil.brownA1,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              data.sections[indexs].details
                                                  .content[index]["paragraph"],
                                              textAlign: TextAlign.justify,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 10,
                                              style: TextStyle(
                                                fontFamily: "bebasPro",
                                                color: ColorUtil.brownA1,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ));
                                  }),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      child: Text(
                                        listLength[indexs]
                                            ? "Read Less"
                                            : "Read More",
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontFamily: "bebasPro",
                                          color: ColorUtil.redA3,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          listLength[indexs] =
                                              !listLength[indexs];
                                        });
                                      },
                                    ),
                                    Spacer(),
                                    InkWell(
                                        onTap: () {
                                          _launchUrl(
                                              Uri.parse(rent_a_home_link));
                                          CountryEclipseAnalytics.rentAHomeFind(
                                              isUser);
                                        },
                                        child: Container(
                                            height: 36.5,
                                            decoration: BoxDecoration(
                                                color: ColorUtil.redA3,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: 9.5,
                                                right: 6.5,
                                              ),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 5),
                                                    Text(
                                                      "FIND VACATION HOMES",
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 8,
                                                      style: TextStyle(
                                                        fontFamily: "bebasPro",
                                                        color: ColorUtil.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8.5,
                                                    ),
                                                    Container(
                                                      height: 20,
                                                      width: 20,
                                                      child: Image.asset(
                                                          "assets/images/spot_btn2.png",
                                                          fit: BoxFit.contain),
                                                    )
                                                  ]),
                                            )))
                                  ]),
                              SizedBox(
                                height: 28,
                              )
                            ]))
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          });
    }

    Widget rentPropertyTextField(
        TextEditingController textEditingController,
        TextInputType textInputType,
        String hintText,
        bool validKey,
        bool inputFormaters) {
      return TextField(
        keyboardType: textInputType,
        inputFormatters: [
          inputFormaters == true ? LengthLimitingTextInputFormatter(13) : null,
        ],
        controller: textEditingController,
        style: TextStyle(
          fontFamily: "bebasPro",
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Color(0xffc0c0c0))),
            focusedErrorBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Color(0xffc0c0c0))),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Color(0xffc0c0c0))),
            contentPadding: EdgeInsets.only(left: 12, top: 13.5, bottom: 13.5),
            hintText: hintText,
            errorText: validKey ? "Please fill the field" : null,
            errorStyle: TextStyle(
              fontFamily: "bebasPro",
              color: Colors.red,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            hintStyle: TextStyle(
              fontFamily: "bebasPro",
              color: Color(0xff6d6964),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.red, width: 5.0),
            )),
      );
    }

    Widget rentYourPropety() {
      return Container(
        margin: EdgeInsets.only(),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: ExpansionTile(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 21.5,
                      width: 23.5,
                      child: Image.asset(
                        "assets/images/ic_bulb_black_hq.png",
                        color: ColorUtil.redA3,
                      ),
                    ),
                    SizedBox(
                      width: 8.5,
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          "Rent Your Property for the Eclipse!",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontFamily: "bebasPro",
                            color: ColorUtil.brownA1,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ]),
              trailing: rentPropertyExpansionKey
                  ? Image.asset("assets/images/group_6_5.png")
                  : Container(
                      height: 26.5,
                      width: 26.5,
                      decoration: BoxDecoration(
                          color: Color(0xfff4ede4),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Icon(
                        Icons.add,
                        color: Color(0xffe0484c),
                        size: 25,
                      ),
                    ),
              key: expansionTileKey2,
              onExpansionChanged: (bool expanded) {
                _scrollToSelectedContent(expansionTileKey: expansionTileKey2);
                print(expanded);
                setState(() => rentPropertyExpansionKey = expanded);
                if (expanded == true)
                  CountryEclipseAnalytics.visitRentProperty(isUser);
              },
              children: <Widget>[
                ListTile(
                  title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: rentPropertyTextField(name_controller,
                                TextInputType.text, "Name", name_valid, false)),
                        SizedBox(
                          height: 9,
                        ),
                        rentPropertyTextField(
                            phone_controller,
                            TextInputType.number,
                            "Phone Number",
                            phone_valid,
                            true),
                        SizedBox(
                          height: 9,
                        ),
                        rentPropertyTextField(
                            email_controller,
                            TextInputType.emailAddress,
                            "Email Address",
                            email_valid,
                            false),
                        SizedBox(
                          height: 9,
                        ),
                        rentPropertyTextField(
                            property_address_controller,
                            TextInputType.multiline,
                            "Property Address",
                            name_valid,
                            false),
                        SizedBox(
                          height: 9,
                        ),
                        rentPropertyTextField(city_controller,
                            TextInputType.text, "City", city_valid, false),
                        SizedBox(
                          height: 9,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: rentPropertyTextField(
                                  state_controller,
                                  TextInputType.text,
                                  "State",
                                  state_valid,
                                  false),
                            ),
                            SizedBox(
                              width: 10.5,
                            ),
                            Flexible(
                              child: rentPropertyTextField(
                                  zip_controller,
                                  TextInputType.number,
                                  "Zip",
                                  zip_valid,
                                  false),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 21.5,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                child: Container(
                                  child: rv_parking_intrest
                                      ? Image.asset(
                                          "assets/images/group_6_2.png")
                                      : Container(
                                          height: 21.5,
                                          width: 21.5,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ColorUtil.redA3),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                        ),
                                ),
                                onTap: () {
                                  setState(() {
                                    rv_parking_intrest = !rv_parking_intrest;
                                    rv_parking_intrest == true
                                        ? parking_rv = "yes"
                                        : parking_rv = "no";
                                  });
                                },
                              ),
                              SizedBox(
                                width: 11,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    rv_parking_intrest = !rv_parking_intrest;
                                    rv_parking_intrest == true
                                        ? parking_rv = "yes"
                                        : parking_rv = "no";
                                  });
                                },
                                child: Text(
                                  "I have land to rent for RV parking !",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontFamily: "bebasPro",
                                    color: ColorUtil.brownA1,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              rv_parking_intrest == true
                                  ? Flexible(
                                      child: TextField(
                                      keyboardType: TextInputType.text,
                                      readOnly: !rv_parking_intrest,
                                      controller: usable_acer_controller,
                                      style: TextStyle(
                                        fontFamily: "bebasPro",
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  color: Color(0xffc0c0c0))),
                                          focusedErrorBorder:
                                              new OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Color(0xffc0c0c0))),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  color: Color(0xffc0c0c0))),
                                          contentPadding: EdgeInsets.only(
                                              left: 12,
                                              top: 13.5,
                                              bottom: 13.5),
                                          hintText: "Usable Acres",
                                          errorText: usable_valid
                                              ? "Please fill the field"
                                              : null,
                                          errorStyle: TextStyle(
                                            fontFamily: "bebasPro",
                                            color: Colors.red,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                          hintStyle: TextStyle(
                                            fontFamily: "bebasPro",
                                            color: Color(0xff6d6964),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 5.0),
                                          )),
                                    ))
                                  : Container()
                            ]),
                        SizedBox(
                          height: 21.5,
                        ),
                        Text(
                          "Interested In:",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: "bebasPro",
                            color: ColorUtil.brownA2,
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        ListView.builder(
                            itemCount: intreseted_year.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorUtil.redA3, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        height: 18,
                                        width: 18,
                                        child: Center(
                                          child: Container(
                                            height: 11,
                                            width: 11,
                                            decoration: BoxDecoration(
                                                color:
                                                    select_intrest_year == index
                                                        ? ColorUtil.redA3
                                                        : ColorUtil.white,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          select_intrest_year = index;
                                          intrest_year = intreseted_year[index];
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: 10.5,
                                    ),
                                    Text(
                                      intreseted_year[index],
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: "bebasPro",
                                        color: ColorUtil.brownA2,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        SizedBox(
                          height: 14.5,
                        ),
                        TextField(
                          keyboardType: TextInputType.multiline,
                          controller: tell_us_controller,
                          style: TextStyle(
                            fontFamily: "bebasPro",
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      BorderSide(color: Color(0xffc0c0c0))),
                              focusedErrorBorder: new OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      BorderSide(color: Color(0xffc0c0c0))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      BorderSide(color: Color(0xffc0c0c0))),
                              contentPadding: EdgeInsets.only(
                                  left: 10, bottom: 50, top: 10),
                              hintText: "Tell us about your home or land",
                              errorText: tell_us_valid
                                  ? "Please fill the field"
                                  : null,
                              errorStyle: TextStyle(
                                fontFamily: "bebasPro",
                                color: Colors.red,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              hintStyle: TextStyle(
                                fontFamily: "bebasPro",
                                color: Color(0xff6d6964),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 5.0),
                              )),
                        ),
                        SizedBox(
                          height: 15.5,
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                child: Container(
                                  child: contactMe
                                      ? Image.asset(
                                          "assets/images/group_6_2.png")
                                      : Container(
                                          height: 21.5,
                                          width: 21.5,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ColorUtil.redA3),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                        ),
                                ),
                                onTap: () {
                                  setState(() {
                                    contactMe = !contactMe;
                                    contactMe == true
                                        ? contact_me = "yes"
                                        : contact_me = "no";
                                  });
                                },
                              ),
                              SizedBox(
                                width: 8.5,
                              ),
                              Expanded(
                                child: Text(
                                  "Contact me about Backroads Reservations vacation rental management services",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontFamily: "bebasPro",
                                    color: ColorUtil.brownA2,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ]),
                        SizedBox(
                          height: 17,
                        ),
                        StreamBuilder<CityEclipseModel>(
                            stream: _bloc.eclipseStream,
                            builder: (context, snapshot) {
                              return GestureDetector(
                                child: Container(
                                  height: 39,
                                  decoration: BoxDecoration(
                                      color: Color(0xffa3ab5d),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Center(
                                    child: Text(
                                      "SUBMIT",
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: "bebasPro",
                                        color: ColorUtil.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  setState(() {
                                    loading = true;
                                    message = "";
                                  });

                                  await validation();

                                  var internetStatus = await connectivity();

                                  var errorStatus = form_response
                                      ? await _bloc.mailingEclipse(
                                          name_controller.text.trim(),
                                          phone_controller.text.trim(),
                                          email_controller.text.trim(),
                                          property_address_controller.text
                                              .trim(),
                                          city_controller.text.trim(),
                                          state_controller.text.trim(),
                                          zip_controller.text.trim(),
                                          parking_rv,
                                          intrest_year,
                                          tell_us_controller.text.trim(),
                                          contact_me,
                                          usable_acer_controller.text.trim())
                                      : false;

                                  setState(() {
                                    (errorStatus && internetStatus) == true
                                        ? dispose()
                                        : null;
                                    (errorStatus && internetStatus) == true
                                        ? select_intrest_year = null
                                        : null;

                                    loading = false;
                                    (errorStatus && internetStatus) == true
                                        ? rv_parking_intrest = false
                                        : null;
                                    (errorStatus && internetStatus) == true
                                        ? message = "Your message was sent"
                                        : "No Network Connection";
                                    (errorStatus && internetStatus) == true
                                        ? CountryEclipseAnalytics
                                            .visitRentPropertySubmit(isUser)
                                        : null;

                                    errorStatus != true
                                        ? message = " Please fill all fields "
                                        : null;
                                  });
                                },
                              );
                            }),
                        loading
                            ? SpinKitCircle(
                                color: Colors.red,
                                size: 25,
                              )
                            : Container(),
                        network_status
                            ? Center(
                                child: Text(
                                  message ?? "",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "bebasPro",
                                    color: ColorUtil.redA3,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  "No Internet Connection",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "bebasPro",
                                    color: ColorUtil.redA3,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 34.5,
                        ),
                      ]),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff3e3227),
          elevation: 0,
          title: Text(
            "Texas Hill Country Eclipses",
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: "bebasPro",
              color: ColorUtil.white,
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Color(0xfff4f4f4),
        body: StreamBuilder<EclipseDataModel>(
            stream: eclipseBloc.dataStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: InkWell(
                    onTap: () {
                      eclipseBloc.getEclipseData();
                    },
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Icon(Icons.refresh),
                          Text(snapshot.error.toString(),
                              style: TextStyle(
                                fontFamily: "bebasPro",
                                color: ColorUtil.brownA1,
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center),
                        ])),
                  ),
                );
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: CommonLoader(),
                  );
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  businessTypes = snapshot.data.businessType;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(children: [
                          ///banner image pageview builder

                          Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: PageView.builder(
                                physics: ClampingScrollPhysics(),
                                controller: _pageController,
                                itemCount: snapshot.data.bannerImages.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                        ),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          // decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover,image: AssetImage("assets/images/slide_image1.jpg"))),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: ApiTools.imageUrl +
                                                snapshot
                                                    .data.bannerImages[index]
                                                    .toString(),
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            fadeOutDuration:
                                                Duration(milliseconds: 1),
                                            fadeInDuration:
                                                Duration(milliseconds: 3),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        )),
                                  );
                                },
                                onPageChanged: (int index) {
                                  _currentPageNotifier.value = index;
                                }),
                          ),

                          ///dot indicator for pageview builder

                          Positioned(
                            child: Align(
                              alignment: Alignment.center,
                              child: CirclePageIndicator(
                                size: 12,
                                dotColor: Colors.grey,
                                selectedDotColor: ColorUtil.redA3,
                                selectedBorderColor: ColorUtil.white,
                                borderWidth: 3,
                                selectedSize: 12,
                                itemCount: snapshot.data.bannerImages.length,
                                currentPageNotifier: _currentPageNotifier,
                              ),
                            ),
                            left: 0,
                            right: 0,
                            bottom: 40,
                          )
                        ]),
                        Padding(
                            padding: EdgeInsets.only(left: 19.5, right: 20),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),

                                  /// intro text

                                  Text(
                                    snapshot.data.intro ?? "",
                                    textAlign: TextAlign.justify,
                                    //maxLines: 2,
                                    style: TextStyle(
                                      fontFamily: "bebasPro",
                                      color: ColorUtil.brownA1,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 30),

                                  // eclipseGear(snapshot.data),

                                  eclipseGear(snapshot.data),

                                  /// section type 1 tiles
                                  type2section(snapshot.data, false),

                                  sectionTile1(snapshot.data),

                                  /// annularity and totality tool

                                  annularityTool(),

                                  businessFormSection(snapshot.data),

                                  /// prepare business section

                                  type2section(snapshot.data, true),

                                  /// rent a property

                                  rentYourPropety(),

                                  /// resources

                                  resourcesSections(snapshot.data),

                                  SizedBox(
                                    height: 60,
                                  )
                                ]))
                      ],
                    ),
                  );
              }
              return Container();
            }));
  }

  /// lauching url

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  /// rent property form validtaion

  validation() {
    name_controller.text.trim().isEmpty
        ? name_valid = true
        : name_valid = false;

    (phone_controller.text.toString().trim().isEmpty ||
            phone_controller.text.trim().length < 10)
        ? phone_valid = true
        : phone_valid = false;

    email_controller.text.trim().isEmpty
        ? email_valid = true
        : email_valid = false;

    property_address_controller.text.trim().isEmpty
        ? address_valid = true
        : address_valid = false;

    city_controller.text.trim().isEmpty
        ? city_valid = true
        : city_valid = false;

    state_controller.text.trim().isEmpty
        ? state_valid = true
        : state_valid = false;

    zip_controller.text.trim().isEmpty ? zip_valid = true : zip_valid = false;

    (rv_parking_intrest == true && usable_acer_controller.text.trim().isEmpty)
        ? usable_valid = true
        : usable_valid = false;

    tell_us_controller.text.trim().isEmpty
        ? tell_us_valid = true
        : tell_us_valid = false;

    (name_valid == true ||
                phone_valid == true ||
                email_valid == true ||
                address_valid == true ||
                city_valid == true ||
                state_valid == true ||
                zip_valid == true ||
                usable_valid == true ||
                tell_us_valid == true) ==
            true
        ? form_response = false
        : form_response = true;
  }

  /// checking internet connectivity

  Future connectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        network_status = true;
        return true;
      }
    } on SocketException catch (_) {
      network_status = false;
      return false;
    }
  }

  /// expansion tile scrolling top

  void _scrollToSelectedContent({GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(keyContext,
            alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
            duration: Duration(milliseconds: 200));
      });
    }
  }

  /// business for validtaion

  bool business_form_validation(String name, String businessName, String city,
      String antoques, String phone, String email, String tellUs) {
    setState(() {
      b_name_valid = name.trim().isEmpty == true ? true : false;
      b_business_name_valid =
          businessName.trim().isEmpty == true ? true : false;
      b_city_valid = city.trim().isEmpty == true ? true : false;
      b_antiques_valid = antoques == null ? true : false;
      // b_phone_valid = BusinessFieldValidation.validatePhone(phone) == true ? false : true;
      // b_email_valid = BusinessFieldValidation.validateEmail(email) == true ? false : true;
      b_phone_valid = phone.toString().trim().isEmpty == true ? true : false;
      b_email_valid = email.toString().trim().isEmpty == true ? true : false;
      b_tell_us_valid = tellUs.trim().isEmpty == true ? true : false;
    });
    if ((b_name_valid &&
            b_business_name_valid &&
            b_city_valid &&
            b_antiques_valid &&
            b_phone_valid &&
            b_email_valid &&
            b_tell_us_valid) ==
        false) {
      return true;
    } else {
      return false;
    }
  }

  /// clear business textfield

  void clearBusinessTextfield(bool status) {
    if (status == true) {
      b_name_controller.clear();
      business_name_controller.clear();
      b_city_controller.clear();
      selectedBusinessType = null;
      b_phone_controller.clear();
      b_email_controller.clear();
      b_tellus_controller.clear();
      setState(() {
        business_intrested = false;
      });
    }
  }

  /// get login or not

  void getIsLogin() async {
    bool status = await PreferenceManager.getLogin();

    setState(() {
      status == true ? isUser = 1 : isUser = 0;
    });
  }

  void _scrollToFirstIndex() {
    businessFormController.animateTo(
      businessFormController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  /// function for check the length of the text and return is read more is need or not

  bool isReadMoreNeeded(String lengthyText) {
    final textSpan =
        TextSpan(text: lengthyText, style: TextStyle(fontSize: 16));
    final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);
    return textPainter.height > 400;
  }

  Future<void> eclipseType1Analytics(int index) {
    if (index == 0) {
      return CountryEclipseAnalytics.visitRingsOfFire(isUser);
    } else {
      return CountryEclipseAnalytics.visitTotalSolar(isUser);
    }
  }

  Future<void> eclipseType2Analytics(int index) {
    if (index == 0) {
      return CountryEclipseAnalytics.visitingRentAHome(isUser);
    } else if (index == 1) {
      return CountryEclipseAnalytics.visitTakeRv(isUser);
    } else {
      return CountryEclipseAnalytics.visitTentCamping(isUser);
    }
  }

  Future<void> eclipseType2ButtonAnalytics(int index) {
    if (index == 0) {
      return CountryEclipseAnalytics.rentAHomeFind(isUser);
    } else if (index == 1) {
      return CountryEclipseAnalytics.clickTakeRvButton(isUser);
    } else {
      return CountryEclipseAnalytics.tentCampingButtonClick(isUser);
    }
  }

  /// pop up for show image for pinch & zoom in eclipse gear

  pinchImagePopUp(String imageUrl) {
    return showDialog(
        context: context,
        builder: (context) {
          return ScaffoldMessenger(
            child: Builder(builder: (BuildContext context) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: AlertDialog(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    contentPadding: EdgeInsets.only(bottom: 0),
                    alignment: Alignment.center,
                    insetPadding: EdgeInsets.only(left: 0, right: 0),
                    content: Stack(children: [
                      Container(
                        padding: EdgeInsets.all(0),
                        height:
                            (MediaQuery.of(context).size.width * 0.32) * 2.5,
                        width: (MediaQuery.of(context).size.width * 0.32) * 2.5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: PinchZoom(
                            maxScale: 2.5,
                            child: CachedNetworkImage(
                              fit: BoxFit.contain,
                              imageUrl: ApiTools.imageBaseURL + imageUrl,
                              //imageUrl: "https://backroadscms.zoondia.org/uploads/eclipse/info-details/Screenshot_2022-10-28_131547.png",
                              placeholder: (context, url) => Center(
                                  child: Image.asset(
                                      "assets/images/img_new_logo.png")),
                              fadeOutDuration: Duration(milliseconds: 1),
                              fadeInDuration: Duration(milliseconds: 3),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            child: Image.asset(
                              "assets/images/ic_rounded_redclose.png",
                              height: 33,
                              width: 33,
                            ),
                          ),
                        ),
                        top: 10,
                        right: 10,
                      )
                    ])),
              );
            }),
          );
        });
  }
}

class EclipseTravelButtons {
  String buttonName;
  String url;

  EclipseTravelButtons(this.buttonName, this.url);
}
