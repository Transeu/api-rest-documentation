---
title: Orders API Endpoints Reference
is_specification: true
side_menu:
  - title: Companies API Endpoints Reference
    url: /api-specification/companies-api-endpoints-reference/
  - title: Exchange Transactions API Endpoints Reference
    url: /api-specification/exchange-transactions-api-endpoints-reference/
  - title: Offers API Endpoints Reference
    url: /api-specification/offers-api-endpoints-reference/
  - title: Orders API Endpoints Reference
    url: /api-specification/orders-api-endpoints-reference/
    active: true
---

# TransOrders API Endpoints Reference
**Version:** 1.0.0  
**Base URL:** `https://orders.system.trans.eu/api/rest/1`

## Resources
### GET
    GET /orders/{order-id} HTTP/1.1

#### Success Response

##### Http status: `200`

##### Response type: `application/hal+json`

##### Resposne data structure
|Property|Type|Description|
|:---|:---|:---|
|id|String|Unique order id|
|number|String|Assigned order number (unique in scope of company)|
|route|Object ([Route](#GET.route))|Route details|
|payment|Object ([Payment](#GET.payment))|Payment details|
|carrier|Object ([Contractor](#GET.contractor))|Carrier details|
|shipper|Object ([Contractor](#GET.contractor))|Shipper details|
|loads|Array (of [Load](#GET.load))|Loads details|
|_links|Object|External resources references|

###### <a name="GET.route"></a>`Route` object structure
|Field|Type|Description|
|:---|:---|:---|
|events|Array (of [RouteEvent](#GET.route.event))|Sorted list of route events|

###### <a name="GET.route.event"></a>`RouteEvent` object structure
|Field|Type|Description|
|:---|:---|:---|
|place|Object ([Place](#GET.place))|Details of event place|
|type|Enum|Event type. <br />Possible values: `loading`, `unloading`|

###### <a name="GET.place"></a>`Place` object structure
|Field|Type|Description|
|:---|:---|:---|
|address|Object ([Address](#GET.address))|Address details|

###### <a name="GET.address"></a>`Address` object structure
|Field|Type|Description|
|:---|:---|:---|
|locality|String|City name|
|postal_code|String|Postal code|
|country|String|Country code in format [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) <br /> Example: `PL`|

###### <a name="GET.payment"></a>`Payment` object structure
|Field|Type|Description|
|:---|:---|:---|
|price|Object ([Price](#GET.payment.price))|Price definition|
|interval|String|Payment date interval in days, ISO 8601 formatted (see [PHP DateInterval](http://php.net/manual/pl/dateinterval.construct.php) for more information)|

###### <a name="GET.payment.price"></a>`Price` object structure
|Field|Type|Description|
|:---|:---|:---|
|value|Number|Price value|
|currency|String|Price currency ([ISO 4217](https://en.wikipedia.org/wiki/ISO_4217)) <br />Supported currencies: `BAM`, `BGN`, `BYR`, `CHF`, `CZK`, `DKK`, `EUR`, `GBP`, `HRK`, `HUF`, `ISK`, `KZT`, `MDL`, `MKD`, `NOK`, `PLN`, `RON`, `RSD`, `RUB`, `SEK`, `TRY`, `UAH`, `USD`|

###### <a name="GET.contractor"></a>`Contractor` object structure
|Field|Type|Description|
|:---|:---|:---|
|company|Object ([Company](#GET.company))|Contractor company details|
|contact_person|Object ([ContactPerson](#GET.contact_person))|Contact person details|

###### <a name="GET.company"></a>`Company` object structure
|Field|Type|Description|
|:---|:---|:---|
|name|String|Company name|
|vat_id|String|Company VAT id|
|address|Object ([Address](#GET.address))|Company address details|

###### <a name="GET.contact_person"></a>`ContactPerson` object structure
|Field|Type|Description|
|:---|:---|:---|
|family_name|String|Person's last name|
|given_name|String|Person's given name|
|email|String|E-mail address|
|telephone|String|Telephone number in format: `(XX) XXXXXXXXX`|

###### <a name="GET.load"></a>`Load` object structure
|Field|Type|Description|
|:---|:---|:---|
|weight|Object ([Weight](#GET.load.weight))|Load weight details|

###### <a name="GET.load.weight"></a>`Weight` object structure
|Field|Type|Description|
|:---|:---|:---|
|value|Number|Weight value|
|unit|String|Weight unit <br />Possible values: `T` (tons), `KG` (kilograms)|

###### Example call and response:
```
GET /api/rest/v1/orders/123456 HTTP/1.1
Host: orders.system.trans.eu
Accept: application/hal+json
Authorization: Bearer {access_token}
```
```
HTTP/1.1 200 OK
Content-Type: application/hal+json

{
    "id": "123456",
    "number": "PL/2016/05/05/1234",
    "route": {
        "events": [
            {
                "place": {
                    "address": {
                        "locality": "Wrocław",
                        "postal_code": "12-345",
                        "country": "PL"
                    }
                },
                "type": "loading"
            },
            {
                "place": {
                    "address": {
                        "locality": "Warszawa",
                        "postal_code": "54-321",
                        "country": "PL"
                    }
                },
                "type": "unloading"
            }
        ]
    },
    "payment": {
        "price": {
            "value": 50,
            "currency": "PLN"
        },
        "interval": "P10D"
    },
    "carrier": {
        "company" : {
            "id": 1,
            "name": "Carrier Trans.eu",
            "vat_id": "00011114444",
            "address": {
                "locality": "Paris",
                "postal_code": "333",
                "country": "FR"
            }
        },
        "contact_person": {
            "family_name": "John",
            "given_name": "Doo",
            "email": "johtn.doo@rst.com",
            "telephone": "1001000100"
        }
    },
    "shipper": {
        "company" : {
            "name": "Trans.eu",
            "vat_id": "000111122222",
            "address": {
                "locality": "London",
                "postal_code": "L333",
                "country": "GB"
            }
        },
        "contact_person": {
            "family_name": "Test",
            "given_name": "Test",
            "email": "test@rst.com.pl",
            "telephone": "1001000100"
        }
    },
    "loads" : [
        {
            "weight" : {
                "value" : 23,
                "unit" : "T"
            }
        },
        {
            "weight" : {
                "value" : 4,
                "unit" : "T"
            }
        }
    ],
    "_links": {
        "self": {
            "href": "http://orders.system.trans.eu/api/rest/v1/orders/123e4567-e89b-12d3-a456-426655440000"
        }
    }
}
```
#### Error Responses
|Http status|Description|
|:---|:---|
|400|Bad request|
|401|Unauthorized|
|403|Forbidden|
|404|Not found|
|500|Internal Server Error|

---
### POST
	POST /shipping-orders HTTP/1.1

#### Query params
|Param|Type|Description|Required|
|:---|:---|:---|:---|
|payment|Object|Payment details|yes|
|number|String|Unique order number|yes|
|shipper|Object|Shipper details|no|
|carrier|Object|Carrier details|no|
|route|Object|Route details|yes|
|loads|Array|Loads details|no|
|body_type|String|Body type name|no|

###### {payment} object structure
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|price|Object|Price details|yes|
|interval|String|Payment date interval in days, ISO 8601 formatted (see [PHP DateInterval](http://php.net/manual/pl/dateinterval.construct.php) for more information)|yes|

###### {payment.price} object structure
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|value|Number|Price value|yes|
|currency|String|Price currency|yes|

##### {shipper} object structure
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|company|Object|Shipper company details|no|
|contact_person|Object|Shipper contact person details|no|

##### {shipper.company} object structure
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|name|String|Shipper company name|yes|
|vat_id|String|Shipper company VAT id|no|
|address|Object|Shipper company address details|no|

###### {shipper.company.address} object structure
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|locality|String|Shipper company city name|no|
|postal_code|String|Shipper company postal code|no|
|country|String|Shipper company country code (ie. 'PL')|no|

###### {shipper.contact_person} object structure
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|family_name|String|Shipper contact person last name|yes|
|given_name|String|Shipper contact person given name|yes|
|email|String|Shipper contact person email address|yes|
|telephone|String|Shipper contact person telephone|no|

###### {carrier} object structure
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|company|Object|Carrier company details|no|
|contact_person|Object|Carrier contact details|no|

###### {carrier.company} object structure
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|name|String|Carrier company name|yes|
|vat_id||String|Carrier company VAT id|no|
|address|Object|Carrier company address details|no|

###### {carrier.company.address} object structure
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|locality|String|Carrier company city name|yes|
|postal_code|String|Carrier company postal code|yes|
|country|String|Carrier company country code (ie. 'PL')|yes|

###### {carrier.contact_person} object structure
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|family_name|String|Carrier contact person last name|yes|
|given_name|String|Carrier contact person given name|yes|
|email|String|Carrier contact person email address|yes|
|telephon|String|Carrier contact person telephone|no|

###### {route} object structure
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|events|Array|Array with loading/unloading events|yes|

###### {route.events} array single item structure
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|place|Object|Loading/unloading place details|yes|
|type|String|Event type ('loading' or 'unloading')|yes|

###### {route.events[i].place} object structure
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|address|Object|Address details|yes|

###### {route.events[i].place.address} object structure
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|locality|String|City name|yes|
|postal_code|String|Postal code|yes|
|country|String|Country code (ie. 'PL')|yes|

###### {loads[i]} array item structure
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|weight|Object|Load weight details|yes|

###### {loads[i].weight} array item structure
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|value|Integer|Weight value|yes|
|unit|String|Weight unit ("T" or "KG")|yes|

###### Example call and response:

```
POST /api/rest/v1/orders HTTP/1.1 
Host: orders.system.trans.eu
Accept: application/hal+json
Content-Type: application/json
Authorization: Bearer {access_token}

{
    "number": "DE/3455/4460",
    "route" : {
        "events": [
            {
                "place": {
                    "address": {
                        "locality": "Berlin",
                        "postal_code": "3456",
                        "country": "DE"
                    }
                },
                "type": "loading"
            },
            {
                "place": {
                    "address": {
                        "locality": "Wysoka",
                        "postal_code": "12345",
                        "country": "PL"
                    }
                },
                "type": "unloading"
            }
        ]
    },
    "payment": {
        "price": {
            "value": 34,
            "currency": "PLN"
        },
        "interval": "P10D"
    }
}
```
```
HTTP/1.1 201 Created
Content-Type: application/hal+json

{
	id: '123456',
    ...
}
```

#### Error Responses
|Http status|Description|
|:---|:---|
|400|Bad request|
|401|Unauthorized|
|403|Forbidden|
|404|Not found|
|500|Internal Server Error|
