# Frequently Asked Questions

### *How can I integrate OAuth2 with desktop application?*

Tags: `oauth`

**Answer:**
The [OAuth wiki](http://wiki.oauth.net/w/page/27249271/OAuth%202%20for%20Native%20Apps) lists numerous options you can use. This question was also asked on stackoverflow: [OAuth 2.0 for desktop and mobile applications](http://stackoverflow.com/questions/13753969/oauth-2-0-for-desktop-and-mobile-applications)

---

### *Can I accept offer using REST API?*

Tags: `api usage`, `available features`

**Answer:**
It's not possible to accept offer using REST API.

---

### *What is `client_sercret` and `client_id`?*

Tags: `oauth`

**Answer:**
*`client_id`* and *`client_sercret`* are client credentials used to authenticate the identity of your application. As specified in [RFC6749](https://tools.ietf.org/html/rfc6749#section-2.3.1)

---

### *How do I secure `cient_secret` for my web app?*

Tags:  `oauth`

**Answer:**
*`cient_secret`* is used to authenticate the identity of your application to the service API. Don't send *`cient_secret`* via HTTP allways use TLS encryption. Transmit *`cient_secret`* only in the request-body and do not include it in the request URI. For more information see [RFC6749](https://tools.ietf.org/html/rfc6749#section-2.3.1)

---

### *What is the difference between `EmployeeId`, `CompanyId` and `TransId`?*

Tags: `api usage`

**Answer:**
*`TransId`* is composed of *`CompanyId`* and *`EmployeeId`* separated by a hypen sign.

Example: *`TransId = 12-1234`*, so `CompanyId` = 12 and `EmployeeId` = 1234.

---

### *When requesting authorization token using code I am receiving `400 Bad Request` response, What am I doing wrong?*

Tags: `oauth`

**Answer:**
* Verify in documentation, if you are sending all required fields in proper format.
* Make sure you are properly sending data using [application/x-www-form-urlencoded](http://www.w3.org/TR/html401/interact/forms.html#h-17.13.4.1) form content type.

---

### *When I request offers data, I am not receiving all available fields. What’s happening?*  

Tags: `api usage`, `available features`

**Answer:**
Upon subscription expiry access to the fields is limited to subset of available fields of an offer.

---

### *When I am posting new offer I get response “You are not authorized to do...” what’s the problem?*

Tags: `api usage`, `available features`

**Answer:**
Your company is not authorized to add offers. Make sure your company is authorized in Trans.eu platform and your subscription is active.

---

### *I don’t have TransId to test my application, how can I get it?*

Tags: `api usage`, `available features`

**Answer:**
To obtain TransId please contact Grzegorz Kowal [gkowal@trans.eu](mailto:gkowal@trans.eu).

---

### *Are dictionary entries translated?*

Tags: `api usage`

**Answer:**
In TransAPI dictionary entries are not being translated. If you need translations for dictionary entries, consider translating them on your application side.

---

### I am getting response `415 Unsupported Media Type` what is wrong?

Tags: `api usage`

**Answer:**
You have to properly specify HTTP headers. Make sure you are sending headers `Content-Type` set to `application/json` and `Accept` set to `application/hal+json`.

---

### *AND & OR in filters - how does it work?*

Tags: `api usage`

**Answer:**
All filters in TransAPI are using MongoDB filters syntax. Logical operators allow you to combine filters in API request.

Examples:
```
$or: [ { quantity: { $lt: 20 } }, { price: 10 } ]
$and: [ { price: { $ne: 1.99 } }, { price: { $exists: true } }
```

For more information checkout [Logical Query Operations](http://docs.mongodb.org/manual/reference/operator/query-logical/) section of MongoDB reference.
