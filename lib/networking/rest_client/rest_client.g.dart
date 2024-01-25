// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestClient implements RestClient {
  _RestClient(this._dio) {
    baseUrl ??= 'http://piptestnet.com/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<RegistrationModel> postData(
    username,
    firstName,
    lastName,
    bio,
    email,
    password,
    userType,
    age,
    countryId,
    stateId,
    universityId,
    programId,
    associationName,
    businessName,
    businessAddress,
    city,
    postalCode,
    deviceToken,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'bio': bio,
      'email': email,
      'password': password,
      'user_type': userType,
      'age': age,
      'country_id': countryId,
      'state_id': stateId,
      'university_id': universityId,
      'program_id': programId,
      'association_name': associationName,
      'business_name': businessName,
      'business_address': businessAddress,
      'city': city,
      'postal_code': postalCode,
      'device_token': deviceToken,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<RegistrationModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              'register',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));

    log("_result.data!${_result.data!}");
    final value = RegistrationModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginResponseModel> attemptToLogIn(
    email,
    password,
    deviceToken,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'email': email,
      'password': password,
      'device_token': deviceToken,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<LoginResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              'login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LogoutResponseModel> attemptToLogOut(bearerToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': bearerToken};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LogoutResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              'logout',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LogoutResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CountriesModel> getListOfCountries() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CountriesModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'countries',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CountriesModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CategoriesModel> getListOfCategories() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CategoriesModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'categories',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CategoriesModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UniversitiesModel> getListOfUniversities() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UniversitiesModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'universities',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UniversitiesModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StateListModel> getStatesListByCountryId(countryId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'country_id': countryId};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<StateListModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'states',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StateListModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProgramsModel> getListOfPrograms() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ProgramsModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'programs',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProgramsModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MessageResponseModel> getMessages(
    bearerToken,
    conversationId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': bearerToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = {'conversation_id': conversationId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MessageResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'get-messages',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MessageResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EventResponseModel> postEvent(
      bearerToken,
      categoryId,
      userId,
      countryId,
      universityId,
      programId,
      title,
      description,
      image,
      startDate,
      endDate,
      startTime,
      endTime,
      price,
      ageMin,
      ageMax,
      limitEntrance,
      minEntrance,
      maxEntrance,
      city,
      location,
      latitude,
      longitude,
      publicEvent,
      forFollowers,
      freeTitle,
      freeDescription,
      freeQuantity,
      paidTitle,
      paidDescription,
      paidQuantity,
      tickets,
      is_redirected,
      ticketing_link) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Authorization': bearerToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'category_id': categoryId,
      'country_id': countryId,
      'user_id': userId,
      'university_id': universityId,
      'program_id': programId,
      'title': title,
      'description': description,
      'image': image,
      'start_date': startDate,
      'end_date': endDate,
      'start_time': startTime,
      'end_time': endTime,
      'price': price,
      'min_age': ageMin,
      'max_age': ageMax,
      'limit_entrance': limitEntrance,
      'min_entrance': minEntrance,
      'max_entrance': maxEntrance,
      'city': city,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'public_event': publicEvent,
      'for_followers': forFollowers,
      'ft_title': freeTitle,
      'ft_description': freeDescription,
      'ft_quantity': freeQuantity,
      'pt_title': paidTitle,
      'pt_description': paidDescription,
      'pt_quantity': paidQuantity,
      'tickets': tickets,
      'is_redirected': is_redirected,
      'ticketing_link': ticketing_link,
    };
    _data.removeWhere((k, v) => v == null);
    log("_headers$_headers");
    log("_extra$_extra");
    log("queryParameters$queryParameters");
    log("_data$_data");

    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<EventResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'events/store',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EventResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PaymentResponse> performCheckout(
    bearerToken,
    cardNumber,
    monthExpire,
    yearExpire,
    cvv,
    amount,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': bearerToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'card_number': cardNumber,
      'exp_month': monthExpire,
      'exp_year': yearExpire,
      'cvv': cvv,
      'amount': amount,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<PaymentResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'stripe-checkout',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PaymentResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  @override
  Future<PaymentResponse> performBooking(
    bearerToken,
    eventid,
    selectedTickets,
    ticketId,
    ticketTitle,
    quantity,
    customerid,
    bookingdate,
    bookingendDdate,
    startTime,
    endTime,
    cardName,
    cardNumber,
    monthExpire,
    yearExpire,
    cvv,
    amount,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': bearerToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'event_id': eventid,
      'booking_date': bookingdate,
      'booking_end_date': bookingdate,
      'start_time': startTime,
      'end_time': endTime,
      'card_name': cardName,
      'card_number': cardNumber,
      'exp_month': monthExpire,
      'exp_year': yearExpire,
      'cvv': cvv,
      'customer_id': customerid,
      'tickets': jsonDecode(jsonEncode(selectedTickets)),
      'ticket_id': ticketId,
      'ticket_title': ticketTitle,
      'quantity': quantity,

      /*  'card_number': cardNumber,
      'exp_month': monthExpire,
      'exp_year': yearExpire,
      'cvv': cvv,
      'amount': amount, */
    };
    log("_headers$_headers");
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<PaymentResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'book_tickets',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    log("_result.data!${_result.data}");
    final value = PaymentResponse.fromJson(_result.data!);
    return value;
  }
}
