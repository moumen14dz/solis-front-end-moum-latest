class PaymentResponse {
  final String message;
  final PaymentIntent paymentIntent;

  PaymentResponse({required this.message, required this.paymentIntent});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      message: json['message'],
      paymentIntent: json['message'],
      //PaymentIntent.fromJson(json['paymentIntent']),
    );
  }
}

class PaymentIntent {
  final String id;
  final String object;
  final int amount;
  final int amountCaptured;
  final int amountRefunded;
  final String balanceTransaction;
  final BillingDetails billingDetails;
  final String calculatedStatementDescriptor;
  final bool captured;
  final int created;
  final String currency;
  final String description;
  final bool disputed;
  final List<dynamic> fraudDetails;
  final bool livemode;
  final List<dynamic> metadata;
  final Outcome outcome;
  final bool paid;
  final String paymentMethod;
  final PaymentMethodDetails paymentMethodDetails;
  final String receiptUrl;
  final bool refunded;
  final Source source;
  final String status;

  PaymentIntent({
    required this.id,
    required this.object,
    required this.amount,
    required this.amountCaptured,
    required this.amountRefunded,
    required this.balanceTransaction,
    required this.billingDetails,
    required this.calculatedStatementDescriptor,
    required this.captured,
    required this.created,
    required this.currency,
    required this.description,
    required this.disputed,
    required this.fraudDetails,
    required this.livemode,
    required this.metadata,
    required this.outcome,
    required this.paid,
    required this.paymentMethod,
    required this.paymentMethodDetails,
    required this.receiptUrl,
    required this.refunded,
    required this.source,
    required this.status,
  });

  factory PaymentIntent.fromJson(Map<String, dynamic> json) {
    return PaymentIntent(
      id: json['id'],
      object: json['object'],
      amount: json['amount'],
      amountCaptured: json['amount_captured'],
      amountRefunded: json['amount_refunded'],
      balanceTransaction: json['balance_transaction'],
      billingDetails: BillingDetails.fromJson(json['billing_details']),
      calculatedStatementDescriptor: json['calculated_statement_descriptor'],
      captured: json['captured'],
      created: json['created'],
      currency: json['currency'],
      description: json['description'],
      disputed: json['disputed'],
      fraudDetails: json['fraud_details'].cast<dynamic>(),
      livemode: json['livemode'],
      metadata: json['metadata'].cast<dynamic>(),
      outcome: Outcome.fromJson(json['outcome']),
      paid: json['paid'],
      paymentMethod: json['payment_method'],
      paymentMethodDetails:
          PaymentMethodDetails.fromJson(json['payment_method_details']),
      receiptUrl: json['receipt_url'],
      refunded: json['refunded'],
      source: Source.fromJson(json['source']),
      status: json['status'],
    );
  }
}

class BillingDetails {
  final Address address;
  final String? email;
  final String? name;
  final String? phone;

  BillingDetails({required this.address, this.email, this.name, this.phone});

  factory BillingDetails.fromJson(Map<String, dynamic> json) {
    return BillingDetails(
      address: Address.fromJson(json['address']),
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
    );
  }
}

class Address {
  final String? city;
  final String? country;
  final String? line1;
  final String? line2;
  final String? postalCode;
  final String? state;

  Address(
      {this.city,
      this.country,
      this.line1,
      this.line2,
      this.postalCode,
      this.state});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      country: json['country'],
      line1: json['line1'],
      line2: json['line2'],
      postalCode: json['postal_code'],
      state: json['state'],
    );
  }
}

class Outcome {
  final String networkStatus;
  final String? reason;
  final String riskLevel;
  final int riskScore;
  final String sellerMessage;
  final String type;

  Outcome({
    required this.networkStatus,
    this.reason,
    required this.riskLevel,
    required this.riskScore,
    required this.sellerMessage,
    required this.type,
  });

  factory Outcome.fromJson(Map<String, dynamic> json) {
    return Outcome(
      networkStatus: json['network_status'],
      reason: json['reason'],
      riskLevel: json['risk_level'],
      riskScore: json['risk_score'],
      sellerMessage: json['seller_message'],
      type: json['type'],
    );
  }
}

class PaymentMethodDetails {
  final CardDetails card;
  final String type;

  PaymentMethodDetails({
    required this.card,
    required this.type,
  });

  factory PaymentMethodDetails.fromJson(Map<String, dynamic> json) {
    return PaymentMethodDetails(
      card: CardDetails.fromJson(json['card']),
      type: json['type'],
    );
  }
}

class CardDetails {
  final int amountAuthorized;
  final String brand;
  final Checks checks;
  final String country;
  final int expMonth;
  final int expYear;
  final String fingerprint;
  final String funding;
  final String last4;
  final String network;
  final NetworkToken networkToken;
  final Overcapture overcapture;

  CardDetails({
    required this.amountAuthorized,
    required this.brand,
    required this.checks,
    required this.country,
    required this.expMonth,
    required this.expYear,
    required this.fingerprint,
    required this.funding,
    required this.last4,
    required this.network,
    required this.networkToken,
    required this.overcapture,
  });

  factory CardDetails.fromJson(Map<String, dynamic> json) {
    return CardDetails(
      amountAuthorized: json['amount_authorized'],
      brand: json['brand'],
      checks: Checks.fromJson(json['checks']),
      country: json['country'],
      expMonth: json['exp_month'],
      expYear: json['exp_year'],
      fingerprint: json['fingerprint'],
      funding: json['funding'],
      last4: json['last4'],
      network: json['network'],
      networkToken: NetworkToken.fromJson(json['network_token']),
      overcapture: Overcapture.fromJson(json['overcapture']),
    );
  }
}

class Checks {
  final String? addressLine1Check;
  final String? addressPostalCodeCheck;
  final String cvcCheck;

  Checks({
    this.addressLine1Check,
    this.addressPostalCodeCheck,
    required this.cvcCheck,
  });

  factory Checks.fromJson(Map<String, dynamic> json) {
    return Checks(
      addressLine1Check: json['address_line1_check'],
      addressPostalCodeCheck: json['address_postal_code_check'],
      cvcCheck: json['cvc_check'],
    );
  }
}

class NetworkToken {
  final bool used;

  NetworkToken({required this.used});

  factory NetworkToken.fromJson(Map<String, dynamic> json) {
    return NetworkToken(
      used: json['used'],
    );
  }
}

class Overcapture {
  final int maximumAmountCapturable;
  final String status;

  Overcapture({
    required this.maximumAmountCapturable,
    required this.status,
  });

  factory Overcapture.fromJson(Map<String, dynamic> json) {
    return Overcapture(
      maximumAmountCapturable: json['maximum_amount_capturable'],
      status: json['status'],
    );
  }
}

class Source {
  final String id;
  final String object;
  final String brand;
  final String country;
  final String cvcCheck;
  final int expMonth;
  final int expYear;
  final String fingerprint;
  final String funding;
  final String last4;

  Source({
    required this.id,
    required this.object,
    required this.brand,
    required this.country,
    required this.cvcCheck,
    required this.expMonth,
    required this.expYear,
    required this.fingerprint,
    required this.funding,
    required this.last4,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      object: json['object'],
      brand: json['brand'],
      country: json['country'],
      cvcCheck: json['cvc_check'],
      expMonth: json['exp_month'],
      expYear: json['exp_year'],
      fingerprint: json['fingerprint'],
      funding: json['funding'],
      last4: json['last4'],
    );
  }
}
