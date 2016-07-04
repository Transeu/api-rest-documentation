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
  - title: TFS API Endpoints Reference
    url: /api-specification/tfs-api-endpoints-reference/
---

**Version:** 1

**Base URL:** `https://orders.system.trans.eu/api/rest/v1`

## Resources

### Orders

#### Get order

**Scopes**

* orders.orders.basic.read

**Endpoint**
```http
GET /orders/{order-id}
```

**Query parameters**

|Param|Type|Description|Required|
|:---|:---|:---|:---|
|order-id|String|Order identifier received with [POST response](#ShippingOrders.POST.response) in `id` field|yes|

**<a name="Orders.GET.response"></a>Responses**

|Http status|Description|
|:---|:---|
|200|Returned the order entity|
|400|Bad request|
|401|Unauthorized|
|403|Forbidden _(i.e. wrong or missing access token)_|
|404|Order not found|
|500|Internal Server Error|

**Response data structure**

|Property|Type|Description|
|:---|:---|:---|
|id|String|Unique order id _(as UUID)_|
|number|String|Assigned order number (unique in scope of company)|
|route|Object ([Route](#Orders.GET.route))|Route details|
|payment|Object ([Payment](#Orders.GET.payment))|Payment details|
|carrier|Object ([Contractor](#Orders.GET.contractor))|Carrier details|
|shipper|Object ([Contractor](#Orders.GET.contractor))|Shipper details|
|loads|Array (of [Load](#Orders.GET.load))|Loads details|
|_links|Object|External resources references|

***<a name="Orders.GET.route"></a>`Route` object structure***
|Field|Type|Description|
|:---|:---|:---|
|events|Array (of [RouteEvent](#Orders.GET.route.event))|Sorted list of route events|

***<a name="Orders.GET.route.event"></a>`RouteEvent` object structure***
|Field|Type|Description|
|:---|:---|:---|
|place|Object ([Place](#Orders.GET.place))|Details of event place|
|type|Enum|Event type. <br />Possible values: `loading`, `unloading`|

***<a name="Orders.GET.place"></a>`Place` object structure***
|Field|Type|Description|
|:---|:---|:---|
|address|Object ([Address](#Orders.GET.address))|Address details|

***<a name="Orders.GET.address"></a>`Address` object structure***
|Field|Type|Description|
|:---|:---|:---|
|locality|String|City name|
|postal_code|String|Postal code|
|country|String|Country code in format [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)|

***<a name="Orders.GET.payment"></a>`Payment` object structure***
|Field|Type|Description|
|:---|:---|:---|
|price|Object ([Price](#Orders.GET.payment.price))|Price definition|
|interval_of_days|String|Payment date interval in days, ISO 8601 formatted (see [PHP DateInterval](http://php.net/manual/pl/dateinterval.construct.php) for more information)|

***<a name="Orders.GET.payment.price"></a>`Price` object structure***
|Field|Type|Description|
|:---|:---|:---|
|value|Number|Price value|
|currency|String|Price currency ([ISO 4217](https://en.wikipedia.org/wiki/ISO_4217))|

***<a name="Orders.GET.contractor"></a>`Contractor` object structure***
|Field|Type|Description|
|:---|:---|:---|
|company|Object ([Company](#Orders.GET.company))|Contractor company details|
|contact_person|Object ([ContactPerson](#Orders.GET.contact_person))|Contact person details|

***<a name="Orders.GET.company"></a>`Company` object structure***
|Field|Type|Description|
|:---|:---|:---|
|name|String|Company name|
|vat_id|String|Company VAT id|
|address|Object ([Address](#Orders.GET.address))|Company address details|

***<a name="Orders.GET.contact_person"></a>`ContactPerson` object structure***
|Field|Type|Description|
|:---|:---|:---|
|given_name|String|Person's given name|
|family_name|String|Person's last name|
|email|String|E-mail address|
|telephone|String|Telephone number in format: `(XX) XXXXXXXXX`|

***<a name="Orders.GET.load"></a>`Load` object structure***
|Field|Type|Description|
|:---|:---|:---|
|weight|Object ([Weight](#Orders.GET.load.weight))|Load weight details|

***<a name="Orders.GET.load.weight"></a>`Weight` object structure***
|Field|Type|Description|
|:---|:---|:---|
|value|Number|Weight value|
|unit_code|String|Weight unit code <br />Possible values: `TNE` (tons)|

**Example**
```
GET /api/rest/v1/orders/123e4567-e89b-12d3-a456-426655440000 HTTP/1.1
Host: orders.system.trans.eu
Accept: application/hal+json
Authorization: Bearer {access_token}
```
```
HTTP/1.1 200 OK
Content-Type: application/hal+json

{
    "id": "123e4567-e89b-12d3-a456-426655440000",
    "number": "PL/2016/05/05/1234",
    "status": "pending",
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
        "interval_of_days": "P10D"
    },
    "carrier": {
        "company" : {
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
            "email": "john.doo@email.com",
            "telephone": "(48) 1001000100"
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
            "family_name": "Miss",
            "given_name": "Foo",
            "email": "miss.foo@email.com",
            "telephone": "(48) 1001000100"
        }
    },
    "loads" : [
        {
            "weight" : {
                "value" : 23,
                "unit_code" : "T"
            }
        },
        {
            "weight" : {
                "value" : 4,
                "unit_code" : "T"
            }
        }
    ],
    "_links": {
        "self": {
            "href": "https://orders.system.trans.eu/api/rest/v1/orders/123e4567-e89b-12d3-a456-426655440000"
        }
    }
}
```

---

### Shipping Orders

#### Add shipping order

**Scopes**

* orders.shipping-orders.basic.create

**Endpoint**
```http
POST /shipping-orders
```

**Request body data**

|Param|Type|Description|Required|
|:---|:---|:---|:---|
|number|String|Order number _(unique in scope of your company)_|yes|
|payment|Object ([Payment](#ShippingOrders.POST.payment))|Payment details|yes|
|route|Object ([Route](#ShippingOrders.POST.route))|Route details|yes|
|carrier|Object ([Contractor](#ShippingOrders.POST.contractor))|Carrier details|no|
|loads|Array (of [Load](#ShippingOrders.POST.load))|Loads details|no|

***<a name="ShippingOrders.POST.payment"></a>`Payment` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|price|Object ([Price](#ShippingOrders.POST.payment.price))|Price definition|yes|
|interval_of_days|String|Payment date interval _(in days, ISO 8601 formatted - see [PHP DateInterval](http://php.net/manual/pl/dateinterval.construct.php) for more information)_|yes|

***<a name="ShippingOrders.POST.payment.price"></a>`Price` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|value|Number|Price value _(positive number)_|yes|
|currency|String ([Currency](#ShippingOrders.POST.payment.currency))|Price currency ([ISO 4217](https://en.wikipedia.org/wiki/ISO_4217))|yes|

***<a name="ShippingOrders.POST.contractor"></a>`Contractor` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|company|Object ([Company](#ShippingOrders.POST.company))|Contractor company details|no|
|contact_person|Object ([ContactPerson](#ShippingOrders.POST.contact_person))|Contractor contact person details|no|

***<a name="ShippingOrders.POST.company"></a>`Company` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|name|String|Company name|yes|
|vat_id|String|Company VAT id|no|
|address|Object ([Address](#ShippingOrders.POST.address))|Company address details|no|

***<a name="ShippingOrders.POST.address"></a>`Address` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|locality|String|City name|yes|
|postal_code|String|Postal code|yes|
|country|String|Country code in format [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) <br /> Example: `PL`|yes|

***<a name="ShippingOrders.POST.contact_person"></a>`ContactPerson` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|given_name|String|Person's first name|yes|
|family_name|String|Person's last name|yes|
|email|String|E-mail address|yes|
|telephone|String|Phone number in format: `(XX) XXXXXXXXX`|no|

***<a name="ShippingOrders.POST.route"></a>`Route` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|events|Array (of [RouteEvent](#ShippingOrders.POST.route.event))|Array with route events|yes|

***<a name="ShippingOrders.POST.route.event"></a>`RouteEvent` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|place|Object ([Place](#ShippingOrders.POST.place))|Details of event place|yes|
|type|String|Event type. <br />Possible values: `loading`, `unloading`|yes|

***<a name="ShippingOrders.POST.place"></a>`Place` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|address|Object ([Address](#ShippingOrders.POST.address))|Address details|yes|

***<a name="ShippingOrders.POST.load"></a>`Load` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|weight|Object ([Weight](#ShippingOrders.POST.load.weight))|Load weight details|yes|

***<a name="ShippingOrders.POST.load.weight"></a>`Weight` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|value|Number|Weight value|yes|
|unit_code|String|Weight unit code<br />Possible values: `TNE` (tons)|yes|

***<a name="ShippingOrders.POST.payment.currency"></a> Supported `Currency` list***
|Value (code)|Currency name|
|:---|:---|
|`BAM`|Bosnia and Herzegovina Convertible Mark|
|`BGN`|Bulgarian Lev|
|`BYR`|Belarussan Ruble|
|`CHF`|Swiss Franc|
|`CZK`|Czech Koruna|
|`DKK`|Danish Krone|
|`EUR`|European Euro|
|`GBP`|Pound Sterling|
|`HRK`|Croatian Kuna|
|`HUF`|Hungarian Forint|
|`ISK`|Icelandic Krona|
|`KZT`|Kazakhstani Tenge|
|`MDL`|Moldovan Leu|
|`MKD`|Macedonian Denar|
|`NOK`|Norwegian Krone|
|`PLN`|Polish Zloty|
|`RON`|Romanian Leu|
|`RSD`|Serbian Dinar|
|`RUB`|Russian Ruble|
|`SEK`|Swedish Krone|
|`TRY`|Turkish Lira|
|`UAH`|Ukrainian Hryvnia|
|`USD`|US Dollars|

**<a name="ShippingOrders.POST.response"></a>Responses**

|Http status|Description|
|:---|:---|
|201|Created and returned the order entity|
|400|Bad request|
|401|Unauthorized|
|403|Forbidden _(i.e. wrong or missing access token)_|
|409|Conflict _(i.e. order number already exists)_|
|422|Unprocessable entity _(i.e. invalid or missing request parameter)_|
|500|Internal Server Error|

**Example**

```http
POST /api/rest/v1/orders HTTP/1.1
Host: orders.system.trans.eu
Accept: application/hal+json
Content-Type: application/json
Authorization: Bearer {access_token}

{
    "number": "DE/3455/4460",
    "payment": {
        "price": {
            "value": 34,
            "currency": "PLN"
        },
        "interval_of_days": "P10D"
    },
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
    }
}
```
```http
HTTP/1.1 201 Created
Content-Type: application/hal+json

{
	"id": "56acf700-1774-11e6-8ab6-0002a5d5c51b",
    ...
}
```
POST response data structure is identical to [GET response structure](#Orders.GET.response).

