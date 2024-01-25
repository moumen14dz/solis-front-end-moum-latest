import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:newproject/common/constant.dart';
import 'package:newproject/model/categories_model.dart';
import 'package:newproject/model/countries_model.dart';
import 'package:newproject/model/log_in_model.dart';
import 'package:newproject/model/logout_model.dart';
import 'package:newproject/model/messages_model.dart';
import 'package:newproject/model/payment_response_model.dart';
import 'package:newproject/model/programs_model.dart';
import 'package:newproject/model/registration_model.dart';
import 'package:newproject/model/state_list_model.dart';
import 'package:newproject/model/universities_model.dart';
import 'package:retrofit/http.dart';

import '../../model/eventcreationModel.dart';
import '../../model/getEventDetails.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: universalBaseUrl)
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @POST("register")
  @FormUrlEncoded()
  Future<RegistrationModel> postData(
    @Field("username") String username,
    @Field("first_name") String firstName,
    @Field("last_name") String lastName,
    @Field("bio") String bio,
    @Field("email") String email,
    @Field("password") String password,
    @Field("user_type") String userType,
    @Field("age") String age,
    @Field("country_id") String countryId,
    @Field("state_id") String stateId,
    @Field("university_id") String universityId,
    @Field("program_id") String programId,
    @Field("association_name") String associationName,
    @Field("business_name") String businessName,
    @Field("business_address") String businessAddress,
    @Field("city") String city,
    @Field("postal_code") String postalCode,
    @Field("device_token") String? deviceToken,
  );

  @POST("login")
  @FormUrlEncoded()
  Future<LoginResponseModel> attemptToLogIn(
    @Field("email") String email,
    @Field("password") String password,
    @Field("device_token") String? deviceToken,
  );

  @POST("logout")
  @FormUrlEncoded()
  Future<LogoutResponseModel> attemptToLogOut(
    @Header("Authorization") String bearerToken,
  );

  @GET("countries")
  Future<CountriesModel> getListOfCountries();

  @GET("categories")
  Future<CategoriesModel> getListOfCategories();

  @GET("universities")
  Future<UniversitiesModel> getListOfUniversities();

  @GET("states")
  Future<StateListModel> getStatesListByCountryId(
      @Query("country_id") int countryId);

  @GET("programs")
  Future<ProgramsModel> getListOfPrograms();

  @POST("get-messages")
  Future<MessageResponseModel> getMessages(
    @Header("Authorization") String bearerToken,
    @Field("conversation_id") String conversationId,
  );

  @POST("events/store")
  @FormUrlEncoded()
  Future<EventResponseModel> postEvent(
    @Header("Authorization") String bearerToken,
    @Field("category_id") int? categoryId,
    @Field("user_id") int? userId,
    @Field("countryId") int? countryId,
    // @Field("neighborhood_id")int? neighborhoodId,
    @Field("university_id") int? universityId,
    @Field("program_id") int? programId,
    @Field("title") String title,
    @Field("description") String description,
    @Field("image") String image,
    @Field("start_date") String startDate,
    @Field("end_date") String endDate,
    @Field("start_time") String startTime,
    @Field("end_time") String endTime,
    @Field("price") String price,
    @Field("min_age") String ageMin,
    @Field("max_age") String ageMax,
    @Field("limit_entrance") bool limitEntrance,
    @Field("min_entrance") String minEntrance,
    @Field("max_entrance") String maxEntrance,
    // @Field("accountFollow") dynamic accountFollow,
    @Field("city") int city,
    @Field("location") String location,
    @Field("latitude") String latitude,
    @Field("longitude") String longitude,
    @Field("public_event") bool publicEvent,
    @Field("for_followers") bool forFollowers,
    @Field("ft_title") String freeTitle,
    @Field("ft_description") String freeDescription,
    @Field("ft_quantity") String freeQuantity,
    @Field("pt_title") String paidTitle,
    @Field("pt_description") String paidDescription,
    @Field("pt_quantity") String paidQuantity,
    // @Field("featured") int featured,
    // @Field("status") String status,
    @Field("tickets") List<Map<String, dynamic>> tickets,
    @Field("is_redirected") String is_redirected,
    @Field("ticketing_link") String ticketing_link,
  );

  // Future<EventResponseModel> postEvent(
  //     @Header("Authorization")String bearerToken,
//     @Field("title")String title,
//     @Field("description")String description,
//     @Field("event_date")String startDate,
//     @Field("category_id")int categoryId,
//     @Field("location")String location,
//     @Field("latitude")String latitude,
//     @Field("longitude")String longitude,
//     @Field("price")String price,
//     @Field("image")String image,
//     @Field("limit_entrance")bool limitEntrance,
//     @Field("min_entrance") String minEntrance,
//     @Field("max_entrance") String maxEntrance,
//     @Field("public_event")bool publicEvent,
//     @Field("for_followers")bool forFollowers,
//     @Field("university_id")int universityId,
//     @Field("age_min")String ageMin,
//     @Field("age_max")String ageMax,
//     @Field("country_id")int countryId,
//     );
  @POST("stripe-checkout")
  Future<PaymentResponse> performCheckout(
    @Header("Authorization") String bearerToken,
    @Field("card_number") String cardNumber,
    @Field("exp_month") String monthExpire,
    @Field("exp_year") String yearExpire,
    @Field("cvv") String cvv,
    @Field("amount") String amount,
  );

  @POST("book_tickets")
  Future<PaymentResponse> performBooking(
    @Header("Authorization") String bearerToken,
    @Field("event_id") String eventId,
    @Field("tickets") List<Tickets> tickets,
    @Field("ticket_id") List ticketId,
    @Field("ticket_title") List ticketTitle,
    @Field("quantity") List quantity,
    @Field("customer_id") String customerId,
    @Field("booking_date") String bookingDate,
    @Field("booking_end_date") String bookingEndDate,
    @Field("start_time") String startTime,
    @Field("end_time") String endTime,
    @Field("card_name") String cardName,
    @Field("card_number") String cardNumber,
    @Field("exp_month") String monthExpire,
    @Field("exp_year") String yearExpire,
    @Field("cvv") String cvv,
    @Field("amount") String amount,
  );
}
