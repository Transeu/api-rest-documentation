---
title:  Exchange Transactions API Endpoints Reference
is_specification: true
side_menu:
  - title: Companies API Endpoints Reference
    url: /api-specification/companies-api-endpoints-reference/
  - title: Exchange Transactions API Endpoints Reference
    url: /api-specification/exchange-transactions-api-endpoints-reference/
    active: true
  - title: Offers API Endpoints Reference
    url: /api-specification/offers-api-endpoints-reference/
  - title: Orders API Endpoints Reference
    url: /api-specification/orders-api-endpoints-reference/
---

**Version:** 1

**Base URL:** `https://exchange-transactions.system.trans.eu/api/rest/v1`

## Resources

### Load transactions

#### Get company transactions originated from load offer, where company is in a role of offerer

**Scopes**:

* exchange-transactions.load-transactions.company-offerer.read

**Endpoint**

```
GET /load-transactions/@company-offerer
```

**Query parameters**

| Query parameter | Type | Required | Value |
|---|---|---|---|
| filter | json | no | Filter values |
| page | integer | no | Result page number |

**Filter parameters**

| Field | Type | Required |
|---|---|---|
| offer | object | no |

**Response**

| Http status | Description |
|---|---|
| 200 | Return collection of transaction entities. |

**Example**

```http
GET /api/rest/v1/load-transactions/@company-offerer?filter={"offer":{"id":123}} HTTP/1.1
Host: exchange-transactions.system.trans.eu
Accept: application/hal+json
Authorization: Bearer {access_token}
```
```http
HTTP/1.1 200 OK
Content-Type: application/hal+json

{
  "_links": {
    "self": {
      "href": "https://exchange-transactions.system.trans.eu/api/rest/v1/load-transactions/@company-contractor"
    }
  },
  "_embedded": {
    "load_transactions": [
       {
         "id": "a83749c4-ae49-50e3-a2d9-c0b048ae2c8e",
         "creation_date": "2016-02-23T15:20:59+01:00",
         "_embedded": {
           "load_offer": {
             "id": 198218751,
             "creation_date": "2016-02-23T14:20:39+0000",
             "publication_date": null,
             "finish_date": "2016-02-24T21:00:00+0000",
             "loading_place": {
               "address": {
                 "country": "PL",
                 "postal_code": "36-200",
                 "locality": "Brzozów"
               },
               "geo": {
                 "latitude": 49.695,
                 "longitude": 22.0193
               }
             },
             "loading_date": "2016-02-23T15:00:00+0000",
             "unloading_place": {
               "address": {
                 "country": "PL",
                 "postal_code": "36-016",
                 "locality": "Chmielnik"
               },
               "geo": {
                 "latitude": 49.9739,
                 "longitude": 22.1454
               }
             },
             "unloading_date": "2016-02-24T21:00:00+0000",
             "price": 4,
             "price_currency": "PLN",
             "price_in_euro": 1,
             "description": "",
             "type": "public",
             "load_length": {
               "value": null,
               "unit_code": null
             },
             "load_height": {
               "value": null,
               "unit_code": null
             },
             "load_volume": {
               "value": null,
               "unit_code": null
             },
             "load_weight": {
               "value": 4,
               "unit_code": "TNE"
             },
             "pallets": null,
             "is_ltl": false,
             "is_lift_required": false,
             "is_truck_crane_required": false,
             "is_tir_cable_required": false,
             "is_tracking_system_required": false,
             "is_for_clearance": false,
             "required_ways_of_loading": null,
             "required_adr_classes": null,
             "_links": {
               "offerer": {
                 "id": 12345,
                 "href": "http://companies.system.trans.eu/api/rest/v1/employees/12345"
               },
               "company": {
                 "id": 123456,
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456"
               },
               "contact_persons": {
                 "ids": [
                   12345
                 ],
                 "href": "http://companies.system.trans.eu/api/rest/v1/employees?filter=%7B%22id%22:%5B12345%5D%7D"
               },
               "required_truck_body": {
                 "id": "curtainsider",
                 "href": "http://offers.system.trans.eu/api/rest/v1/truck-bodies/curtainsider"
               }
             }
           },
           "offerer_company": {
             "id": 123456,
             "legal_name": "Luke",
             "short_name": "Levic corp",
             "native_name": null,
             "short_native_name": null,
             "email": "testy-alfa@test.com",
             "address": {
               "postal_code": "koddd",
               "locality": "Wrocław",
               "street_address": "ulicaaaahhaq",
               "country": "PL"
             },
             "vat_id": "PL8282828282",
             "telephone": "(48) 12312312312",
             "additional_telephones": null,
             "url": null,
             "registration_date": "2010-04-14T08:03:34+00:00",
             "fax_number": null,
             "company_number": null,
             "registration_number": null,
             "establishment_date": "-001-11-29T23:00:00+00:00",
             "_links": {
               "self": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456"
               },
               "certificates": {
                 "id": "123456",
                 "href": "http://company-certificates.system.trans.eu/api/rest/v1/companies/123456/certifications"
               },
               "stats": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456/stats"
               },
               "ratings": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456/ratings"
               },
               "trans-risk": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456/trans-risk"
               },
               "structure": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456/structure"
               },
               "legal-forms": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456/legal-forms"
               },
               "services": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456/services"
               },
               "employees": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456/employees"
               }
             }
           },
           "offerer_employee": {
             "id": 123456,
             "given_name": "Luke",
             "family_name": "Test",
             "trans_id": "123456-1",
             "email": "test@test.com",
             "language": "PL",
             "telephone": "(48) 1234556789",
             "mobile_telephone": "(48) 987654321",
             "additional_telephones": null,
             "registration_date": "2010-04-14T08:03:35+00:00",
             "last_login_date": "2016-03-17T12:31:33+00:00",
             "entitled": true,
             "hidden": false,
             "is_driver": false,
             "is_moderator": false,
             "_links": {
               "self": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/employees/123456"
               },
               "company": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456"
               }
             }
           },
           "contractor_company": {
             "id": 123456,
             "legal_name": "Test Sp. z o. o. Sp. k.",
             "short_name": "Test",
             "native_name": null,
             "short_native_name": null,
             "email": "test@test.com",
             "address": {
               "postal_code": "53-5341",
               "locality": "Wrocław",
               "street_address": "Testowa 1234",
               "country": "PL"
             },
             "vat_id": "PL112233445566",
             "telephone": "(48) 12345671",
             "additional_telephones": null,
             "url": "http://www.onet.pl",
             "registration_date": "2009-05-12T14:08:13+00:00",
             "fax_number": "1123",
             "company_number": null,
             "registration_number": null,
             "establishment_date": "2009-05-12T14:08:13+00:00",
             "_links": {
               "self": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456"
               },
               "certificates": {
                 "id": "123456",
                 "href": "http://company-certificates.system.trans.eu/api/rest/v1/companies/123456/certifications"
               },
               "stats": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456/stats"
               },
               "ratings": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456/ratings"
               },
               "trans-risk": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456/trans-risk"
               },
               "structure": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456/structure"
               },
               "legal-forms": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456/legal-forms"
               },
               "services": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456/services"
               },
               "employees": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456/employees"
               }
             }
           },
           "contractor_employee": {
             "id": 12345,
             "given_name": "John",
             "family_name": "Doe",
             "trans_id": "123456-1",
             "email": "john.doe@test.com",
             "language": "PL",
             "telephone": null,
             "mobile_telephone": null,
             "additional_telephones": null,
             "registration_date": "2009-05-12T14:08:13+00:00",
             "last_login_date": "2016-02-23T14:16:19+00:00",
             "entitled": true,
             "hidden": true,
             "is_driver": false,
             "is_moderator": false,
             "_links": {
               "self": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/employees/12345"
               },
               "company": {
                 "href": "http://companies.system.trans.eu/api/rest/v1/companies/123456"
               }
             }
           }
         },
         "_links": {
           "self": {
             "href": "http://exchange-transactions.system.trans.eu/api/rest/v1/load-transactions/a83749c4-ae49-50e3-a2d9-c0b048ae2c8e"
           }
         }
       }
     ]
  },
  "page_count": 1,
  "page_size": 10,
  "total_items": 1,
  "page": 1
}
```

#### Get company transactions originated from load offer, where company is in a role of contractor

**Scopes**:

* exchange-transactions.load-transactions.company-contractor.read

**Endpoint**

```
GET /load-transactions/@company-contractor
```

**Query parameters**

| Query parameter | Type | Required | Value |
|---|---|---|---|
| filter | json | no | Filter values |
| page | integer | no | Result page number |

**Filter parameters**

| Field | Type | Required |
|---|---|---|
| offer | object | no |

**Response**

| Http status | Description |
|---|---|
| 200 | Return collection of transaction entities. |

**Example**

See example usage of `/load-transactions/@company-offerer` endpoint.

### Vehicle transactions

#### Get company transactions originated from vehicle offer, where company is in a role of offerer

**Scopes**:

* exchange-transactions.vehicle-transactions.company-offerer.read

**Endpoint**

```
GET /vehicle-transactions/@company-offerer
```

**Query parameters**

| Query parameter | Type | Required | Value |
|---|---|---|---|
| filter | json | no | Filter values |
| page | integer | no | Result page number |

**Filter parameters**

| Field | Type | Required |
|---|---|---|
| offer | object | no |

**Response**

| Http status | Description |
|---|---|
| 200 | Return collection of transaction entities. |

**Example**
```http
GET /api/rest/v1/vehicle-transactions/@company-offerer?filter={"offer":{"id":123}} HTTP/1.1
Host: exchange-transactions.system.trans.eu
Accept: application/hal+json
Authorization: Bearer {access_token}
```
```http
HTTP/1.1 200 OK
Content-Type: application/hal+json

{
  "_links": {
    "self": {
      "href": "https://exchange-transactions.system.trans.eu/api/rest/v1/vehicle-transactions/@company-contractor"
    }
  },
  "_embedded": {
    "load_transactions": [
        ... //transactions data (same as above)
    ]
  },
  "page_count": 0,
  "page_size": 10,
  "total_items": 0,
  "page": 0
}
```

#### Get collection of company transactions originated from vehicle offer, where company is in a role of contractor

**Scopes**:

* exchange-transactions.vehicle-transactions.company-contractor.read

**Endpoint**

```
GET /vehicle-transactions/@company-contractor
```

**Query parameters**

| Query parameter | Type | Required | Value |
|---|---|---|---|
| filter | json | no | Filter values |
| page | integer | no | Result page number |

**Filter parameters**

| Field | Type | Required |
|---|---|---|
| offer | object | no |

**Response**

| Http status | Description |
|---|---|
| 200 | Return collection of transaction entities. |

**Example**

See example usage of `/vehicle-transactions/@company-offerer` endpoint.
