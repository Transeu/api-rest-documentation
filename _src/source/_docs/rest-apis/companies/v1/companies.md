---
title: Companies API Endpoints Reference
is_specification: true
side_menu:
  - title: Companies API Endpoints Reference
    url: /api-specification/companies-api-endpoints-reference/
    active: true
  - title: Exchange Transactions API Endpoints Reference
    url: /api-specification/exchange-transactions-api-endpoints-reference/
  - title: Offers API Endpoints Reference
    url: /api-specification/offers-api-endpoints-reference/
  - title: Orders API Endpoints Reference
    url: /api-specification/orders-api-endpoints-reference/
---

**Version:** 1

**Base URL:** `https://companies.system.trans.eu/api/rest/v1`

## Resources

>**Important**: The user in resources with identifier `@me` is determined by access token.

### Companies

#### Get user's company

**Scopes**:

* companies.companies.me.read

**Endpoint**

```
GET /companies/@me
```

**Response**

| Http status | Description |
|---|---|
| 200 | Return Company entity |
| 404 | Company not found because user is not an employee in any company |

**Example**

```http
GET /api/rest/v1/companies/@me HTTP/1.1
Host: companies.system.trans.eu
Accept: application/hal+json
Authorization: Bearer {access_token}
```
```http
HTTP/1.1 200 OK
Content-Type: application/hal+json

{
 "id": 123456789,
 "legal_name": "Example Company Sp. z o.o.",
 "short_name": "ExampleCompany",
 "native_name": null,
 "short_native_name": null,
 "email": "office@example-company.com.pl",
 "address": {
   "postal_code": "50-457",
   "locality": "Wrocław",
   "street_address": "Rynek 12",
   "country": "PL"
 },
 "vat_id": "PL945608304",
 "telephone": "(88) 123123123",
 "url": "http://example-company.com.pl",
 "registration_date": "2006-07-11T12:18:36+00:00",
 "fax_number": "444555666",
 "company_number": "012345678",
 "registration_number": "0000123456",
 "establishment_date": "1999-05-09T00:00:00+00:00",
 "_links": {
   "self": {
     "href": "https://companies.system.trans.eu/api/rest/v1/companies/123456789"
   },
   "employees": {
     "href": "https://companies.system.trans.eu/api/rest/v1/companies/123456789/employees"
   }
 }
}
```

#### Get user's company employees

**Scopes**:

* companies.companies.employees.me.read

**Endpoint**
```
GET /companies/@me/employees
```

**Query parameters**

| Query parameter | Type | Required | Value |
|---|---|---|---|
| page | integer | no | Result page number |

**Response**

| Http status | Description |
|---|---|
| 200 | Return collection of Employee entities |

**Example**

```http
GET /api/rest/v1/companies/@me/employees HTTP/1.1
Host: companies.system.trans.eu
Accept: application/hal+json
Authorization: Bearer {access_token}
```
```http
HTTP/1.1 200 OK
Content-Type: application/hal+json

{
  "_links": {
    "self": {
      "href": "https://companies.system.trans.eu/api/rest/v1/companies/123456789/employees?page=1"
    },
    "first": {
      "href": "https://companies.system.trans.eu/api/rest/v1/companies/123456789/employees"
    },
    "last": {
      "href": "https://companies.system.trans.eu/api/rest/v1/companies/123456789/employees?page=4"
    },
    "next": {
      "href": "https://companies.system.trans.eu/api/rest/v1/companies/123456789/employees?page=2"
    }
  },
  "_embedded": {
    "companies_employees": [
      ...  
    ]
  },
  "page_count": 4,
  "page_size": 25,
  "total_items": 96
}
```

### Employees

#### Get user's employee data

**Scopes**:

* companies.employees.me.read

**Endpoint**
```
GET /employees/@me
```

**Response**

| Http status | Description |
|---|---|
| 200 | Return Employee entity |
| 404 | Employee not found because user is not an employee |

**Example**

```http
GET /api/rest/v1/employees/@me HTTP/1.1
Host: companies.system.trans.eu
Accept: application/hal+json
Authorization: Bearer {access_token}
```
```http
HTTP/1.1 200 OK
Content-Type: application/hal+json

{
  "id": 987654321,
  "given_name": "Jan",
  "family_name": "Kowalski",
  "trans_id": "123456789-1",
  "email": "jan.kowalski@example-comapny.com",
  "telephone": null,
  "registration_date": "2006-07-11T12:37:44+00:00",
  "last_login_date": "2015-10-08T10:50:28+00:00",
  "entitled": true,
  "hidden": false,
  "is_driver": false,
  "is_moderator": false,
  "_links": {
    "self": {
      "href": "https://companies.system.trans.eu/api/rest/v1/employees/987654321"
    },
    "company": {
      "href": "https://companies.system.trans.eu/api/rest/v1/companies/123456789"
    }
  }
}
```

## Enities

### Company entity

| Field | Value Type | Value Description |
|---|---|---|
| id | integer | Unique identifier for a company. |
| legal_name | string | Company full name. |
| short_name | string | Company name short form. |
| native_name | string | Company name in the native language of the company. |
| short_native_name | string | Company name in the native language of the company, shortened.|
| email | string | Official company e-mail address. |
| address.postal_code | string | Postal code of the location of the company. |
| address.locality | string | Name of city company is located in. |
| address.street_address | string | Street name of company location. |
| address.country | string | The company country code (ISO 3166-1 alpha-2). |
| vat_id | string | Fiscal identifier of the company. |
| telephone | string | Official company phone number including area code. |
| url | string | Company website URL. |
| registration_date | string | Company registration date and time (ISO 8601) in Trans.eu system. |
| establishment_date | string | Date and time (ISO 8601) of company starting operation. |

**Links**

| Link | Value Type | Value Description |
|---|---|---|
| employees.href | string | Contains URL to company employees entities collection. |

### Employee entity

| Key | Value Type | Value Description |
|---|---|---|
| id | integer| Unique identifier for a employee. |
| given_name | string | Employee given name. |
| family_name | string | Employee family name. |
| trans_id | string | Employee TransId. |
| email | string | Employee email address. |
| telephone | string | Employee telephone number. |
| registration_date | string | Employee account creation date and time (ISO 8601). |
| last_login_date | string | Employee last login date and time (ISO 8601). |
| entitled | boolean | Is employee entitled. |
| hidden | boolean | Is employee hidden. |
| is_driver | boolean | Is employee a driver. |
| is_moderator | boolean | Is employee a moderator. |

**Links**

| Link | Value Type | Value Description |
|---|---|---|
| company.href | string | Contain URL to company entity. |
