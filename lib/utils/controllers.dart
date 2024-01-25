import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:newproject/model/UsersListModel.dart';
import 'package:newproject/model/chatmessageModel.dart';
import 'package:newproject/model/getEventDetails.dart';
import 'package:newproject/model/loginResponse.dart';
import 'package:newproject/model/myFollowingListMidel.dart';

import '../model/AccountFollowingListModel.dart';
import '../model/eventsOfCurrentWeek.dart';
import '../model/getCategories.dart';
import '../model/getCountries.dart';
import '../model/getEventswithFilters.dart';
import '../model/getHostedEvent.dart';
import '../model/listOfUniversitiesModel.dart';
import '../model/message_response_model.dart';
import '../model/userProfileDetails.dart';

final nameControllers = TextEditingController();
final universityControllers = TextEditingController();
final businessAddressController = TextEditingController();
final businessNameController = TextEditingController();
final businessLastController = TextEditingController();

final cityControllers = TextEditingController();
final eventcityControllers = TextEditingController();

final businessCityController = TextEditingController();
final postalControllers = TextEditingController();
final businessPostalController = TextEditingController();
final associationNameController = TextEditingController();

//Student
final studentNameController = TextEditingController();
final studentlastNameControllers = TextEditingController();
final studentBirthdayController = TextEditingController();
final studentbioController = TextEditingController();
final studentCityControllers = TextEditingController();
final neighborControllers = TextEditingController();
final studentUniversityControllers = TextEditingController();
final studentProgramControllers = TextEditingController();

//Login
final loginEmailController = TextEditingController();
final loginPasswordController = TextEditingController();

//Event
final titleEventController = TextEditingController();
final redirectUrlEventController = TextEditingController();

final startdateEventController = TextEditingController();
final eventDateController = TextEditingController();
final enddateEventController = TextEditingController();
final startTimeEventController = TextEditingController();
final endTimedateEventController = TextEditingController();

final eventLocation = TextEditingController();
final eventDescriptioncController = TextEditingController();
final paymentController = TextEditingController();
final moneyController = TextEditingController();
final minAgeController = TextEditingController();
final maxAgeController = TextEditingController();
final eventneighborControllers = TextEditingController();
final eventstudentUniversityControllers = TextEditingController();
final minEntranceController = TextEditingController();
final maxEntranceController = TextEditingController();
final category = TextEditingController();
final publicController = TextEditingController();
final eventNamenControllerReportAAcc = TextEditingController();
final nameControllerReportAAcc = TextEditingController();
//Ticket
final ticketTitleController = TextEditingController();
final ticketDescriptionController = TextEditingController();
final ticketQuantityController = TextEditingController();
final paidticketTitleController = TextEditingController();
final paidticketDescriptionController = TextEditingController();
final ticketPriceController = TextEditingController();
final paidticketQuantityController = TextEditingController();
final selectedQuantityController = TextEditingController();

//Edit Profile
final editLastNameController = TextEditingController();
final editFirstNameController = TextEditingController();
final editProfilePasswordController = TextEditingController();
final editProfileEmailController = TextEditingController();
final editProfileUserNameController = TextEditingController();
final editDescriptioncController = TextEditingController();
final editProfilePhoneController = TextEditingController();

//Chat
final chatController = TextEditingController();

//Create Account
final createpassword = TextEditingController();
final emailCreateControllers = TextEditingController();
final usernameCreateControllers = TextEditingController();

//Booking Info
List<Tickets>? selectedTickets = getEventDetailsModel.data!.tickets!;

//CardPaymentfees
final cardName = TextEditingController();
final cardNumber = TextEditingController();
final cardDate = TextEditingController();
final cvv = TextEditingController();

//EventNearByYour
final eventbyyouSearch = TextEditingController();
final followerSearch = TextEditingController();

//ContactUs
final contactText = TextEditingController();
final description = TextEditingController();

//Password forgot
final passController = TextEditingController();
final forgotemailCOntroller = TextEditingController();
final forgotpassCOntroller = TextEditingController();
final newPassword = TextEditingController();
final confirmPassword = TextEditingController();

//Edit Profile
File? editImage, editBackgrondImage;
String? base64Imageedit1, base64Imageedit;

//Loader For Api Calls
bool loader = false;

MyFollowingList myFollowingList = MyFollowingList();
AccountFollowingList myFollowingList1 = AccountFollowingList();
List<DataFollowing>? getFollowingListSearch = [];
List<DataAccountFollowing>? getAccFollowingListSearch = [];

MyFollowingList myFollowersList = MyFollowingList();
MyFollowingList myFollowersList1 = MyFollowingList();
List<DataFollowing>? getFollowerListSearch = [];

GetEventDetails getEventDetailsModel = GetEventDetails();
GetEventWithFilters getEventsWithFiltersModel = GetEventWithFilters();
List<DataOfEventsFilter>? getEventsWithFiltersModelAfterSearch = [];
LoginResponse loginResponseModel = LoginResponse();
GetCategories getCategories = GetCategories();
List<DataOfGetCategories>? getCtaegoriesDataAfterSearch = [];
final eventsFilterSearch = TextEditingController();
GetCountriesFromAPI getCountriesFromAPI = GetCountriesFromAPI();
UserProfileDetails userProfileDetails = UserProfileDetails();
UsersListModel userslist = UsersListModel();
List<Users>? getUserListSearch = [];
List<Users>? getFreindListSearch = [];
List<Users>? getAsocListSearch = [];
List<Users>? getBusnissListSearch = [];

GetEventsOfCurrentWeek getEventsOfCurrentWeek = GetEventsOfCurrentWeek();
GetEventsOfCurrentWeek allFutureEventsList = GetEventsOfCurrentWeek();
GetEventsOfCurrentWeek eventsNearByMeOnly = GetEventsOfCurrentWeek();
ListOfUniversities listOfUniversitiesModel = ListOfUniversities();
Position? userLocation;
HostedEventsOfUser hostedEventsOfUser = HostedEventsOfUser();
HostedEventsOfUser hostedEventsOfotherUser = HostedEventsOfUser();
MessagesResponseModel chatInbox = MessagesResponseModel();
MessagesResponseModel chatAccountInbox = MessagesResponseModel();
List<DataThreads>? getFilterThreads = [];
List<DataThreads>? getAccountFilterThreads = [];
ChatMessagesModels chatMessages = ChatMessagesModels();


// GetHostedEvents getHostedEventss = GetHostedEvents();
