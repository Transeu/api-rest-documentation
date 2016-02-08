---
title: FAQ
is_faq: true
table_of_content:
  - title: How can I integrate OAuth2 with desktop application?
    url: /faq/#how_can_i_integrate_oauth2_with_desktop_application
  - title: Can I accept offer using REST API?
    url: /faq/#can_i_accept_offer_using_rest_api
  - title: What is `client_sercret` and `client_id`?
    url: /faq/#what_is_client_secret_and_client_id
  - title: How do I secure `client_secret` for my web app?
    url: /faq/#how_do_i_secure_client_secret_for_my_web_app
  - title: What is the difference between `EmployeeId`, `CompanyId` and `TransId`?
    url: /faq/#what_is_the_difference_between_employeeid_companyid_and_transid
  - title: When requesting authorization token using code I am receiving `400 Bad Request` response, What am I doing wrong?
    url: /faq/#when_requesting_authorization_token_using_code_i_am_receiving_400_bad_request_response
  - title: When I request offers data, I am not receiving all available fields. What’s happening?
    url: /faq/#when_i_request_offers_data_i_am_not_receiving_all_available_fields
  - title: When I am posting new offer I get response “You are not authorized to do...” what’s the problem?
    url: /faq/#when_i_am_posting_new_offer_i_get_response_you_are_not_authorized_to_do
  - title: I don’t have TransId to test my application, how can I get it?
    url: /faq/#i_dont_have_transid_to_test_my_application_how_can_i_get_it
  - title: Are dictionary entries translated?
    url: /faq/#are_dictionary_entries_translated
  - title: I am getting response `415 Unsupported Media Type` what is wrong?
    url: /faq/#i_am_getting_response_415_unsupported_media_type_what_is_wrong
  - title: AND & OR in filters - how does it work?
    url: /faq/#and_or_in_filters_how_does_it_work
  - title: 403 forbidden on authorizatoin request
    url: /faq/#403_forbidden_on_authorization_request
---

<a class="anchor" name="how_can_i_integrate_oauth2_with_desktop_application"></a>

### How can I integrate OAuth2 with desktop application?

Tags: `oauth`

#### Answer:

The [OAuth wiki](http://wiki.oauth.net/w/page/27249271/OAuth%202%20for%20Native%20Apps) lists numerous options you can use. This question was also asked on stackoverflow: [OAuth 2.0 for desktop and mobile applications](http://stackoverflow.com/questions/13753969/oauth-2-0-for-desktop-and-mobile-applications)

---
<a class="anchor" name="can_i_accept_offer_using_rest_api"></a>

### Can I accept offer using REST API?

Tags: `api usage`, `available features`

#### Answer:

It's not possible to accept offer using REST API.

However it's possible to accept offer after calling offer details modal window of Trans.eu and starting conversation about offer.


---
<a class="anchor" name="what_is_client_secret_and_client_id"></a>

### What is `client_sercret` and `client_id`?

Tags: `oauth`

#### Answer:

*`client_id`* and *`client_sercret`* are client credentials used to authenticate the identity of your application. As specified in [RFC6749](https://tools.ietf.org/html/rfc6749#section-2.3.1)

---
<a class="anchor" name="how_do_i_secure_client_secret_for_my_web_app"></a>

### How do I secure `client_secret` for my web app?

Tags:  `oauth`

#### Answer:

*`client_secret`* is used to authenticate the identity of your application to the service API. Don't send *`client_secret`* via HTTP allways use TLS encryption. Transmit *`client_secret`* only in the request-body and do not include it in the request URI. For more information see [RFC6749](https://tools.ietf.org/html/rfc6749#section-2.3.1)

---
<a class="anchor" name="what_is_the_difference_between_employeeid_companyid_and_transid"></a>

### What is the difference between `EmployeeId`, `CompanyId` and `TransId`?

Tags: `api usage`

#### Answer:

*`TransId`* is composed of *`CompanyId`* and *`EmployeeId`* separated by a hypen sign.

Example: *`TransId = 12-1234`*, so *`CompanyId = 12 and EmployeeId = 1234`*.

---
<a class="anchor" name="when_requesting_authorization_token_using_code_i_am_receiving_400_bad_request_response"></a>

### When requesting authorization token using code I am receiving `400 Bad Request` response, What am I doing wrong?

Tags: `oauth`

#### Answer:

* Verify in documentation, if you are sending all required fields in proper format.
* Make sure you are properly sending data using [application/x-www-form-urlencoded](http://www.w3.org/TR/html401/interact/forms.html#h-17.13.4.1) form content type.

---
<a class="anchor" name="when_i_request_offers_data_i_am_not_receiving_all_available_fields"></a>

### When I request offers data, I am not receiving all available fields. What’s happening?

Tags: `api usage`, `available features`

#### Answer:

Upon subscription expiry access to the fields is limited to subset of available fields of an offer.

---
<a class="anchor" name="when_i_am_posting_new_offer_i_get_response_you_are_not_authorized_to_do"></a>

### When I am posting new offer I get response “You are not authorized to [...]” what’s the problem?

Tags: `api usage`, `available features`

#### Answer:

Your company is not authorized to add offers. Make sure your company is authorized in Trans.eu platform and your subscription is active.

---
<a class="anchor" name="i_dont_have_transid_to_test_my_application_how_can_i_get_it"></a>

### I don’t have TransId to test my application, how can I get it?

Tags: `api usage`, `available features`

#### Answer:

To obtain TransId please contact Grzegorz Patynek [gpatynek@trans.eu](mailto:gpatynek@trans.eu).

---
<a class="anchor" name="are_dictionary_entries_translated"></a>

### Are dictionary entries translated?

Tags: `api usage`

#### Answer:

In TransAPI dictionary entries are not being translated. If you need translations for dictionary entries, consider translating them on your application side.

---
<a class="anchor" name="i_am_getting_response_415_unsupported_media_type_what_is_wrong"></a>

### I am getting response `415 Unsupported Media Type` what is wrong?

Tags: `api usage`

#### Answer:

You have to properly specify HTTP headers. Make sure you are sending headers `Content-Type` set to `application/json` and `Accept` set to `application/hal+json`.

---
<a class="anchor" name="and_or_in_filters_how_does_it_work"></a>

### AND & OR in filters - how does it work?

Tags: `api usage`

#### Answer:

All filters in TransAPI are using MongoDB filters syntax. Logical operators allow you to combine filters in API request.

Examples:
```
$or: [ { quantity: { $lt: 20 } }, { price: 10 } ]
$and: [ { price: { $ne: 1.99 } }, { price: { $exists: true } }
```

For more information checkout [Logical Query Operations](http://docs.mongodb.org/manual/reference/operator/query-logical/) section of MongoDB reference.

---
<a class="anchor" name="403_forbidden_on_authorization_request"></a>

### When sending authorization request instead of `302 Found` response I am getting `403 Forbidden` what's wrong?

Tags: `api usage`

#### Answer:

Make sure you are using `https` protocol not `http`.