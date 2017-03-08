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
  - title: Orders repository API Endpoints Reference
    url: /api-specification/orders-repository-api-endpoints-reference/
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
|order-id|String|Order identifier received with [POST response](#Orders.POST.response) in `id` field|yes|

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
|loads|Array (of [Load](#Orders.GET.load))|Loads details|
|carrier|Object ([Contractor](#Orders.GET.contractor))|Carrier details|
|payer|Object ([Contractor](#Orders.GET.contractor))|Payer details|
|payment|Object ([Payment](#Orders.GET.payment))|Payment details|
|vehicle|Object ([Vehicle](#Orders.GET.Vehicle))|Vehicle details|
|driver|Object ([Driver](#Orders.GET.Driver))|Driver details|
|requirements|Object ([Requirements](#Orders.GET.Requirements))|Requirements|
|_links|Object|External resources references|

***<a name="Orders.GET.route"></a>`Route` object structure***
|Field|Type|Description|
|:---|:---|:---|
|events|Array (of [RouteEvent](#Orders.GET.route.event))|Sorted list of route events|

***<a name="Orders.GET.route.event"></a>`RouteEvent` object structure***
|Field|Type|Description|
|:---|:---|:---|
|place|Object ([Place](#Orders.GET.place))|Details of event place|
|time_frame|Object ([TimeFrame](#Orders.GET.TimeFrame))|Details of loads TimeFrame|
|type|Enum|Single value can be choose. Event type. <br />Possible values: `loading`, `unloading`|

***<a name="Orders.GET.place"></a>`Place` object structure***
|Field|Type|Description|
|:---|:---|:---|
|address|Object ([Address](#Orders.GET.address))|Address details|

***<a name="Orders.GET.TimeFrame"></a>`TimeFrame` object structure***
|Field|Type|Description|
|:---|:---|:---|
|day|Date|`[YYYY-MM-DD]`|
|time_from|Date|`[hh]:[mm]:[ss]Z` ie. `11:20:00+01:00`|
|time_to|Date|`[hh]:[mm]:[ss]Z` ie. `11:20:00+01:00`|

***<a name="Orders.GET.address"></a>`Address` object structure***
|Field|Type|Description|
|:---|:---|:---|
|street|String|Street name|
|number|String|Street number|
|locality|String|City name|
|postal_code|String|Postal code|
|country|String|Country code in format [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)|

***<a name="Orders.GET.payment"></a>`Payment` object structure***
|Field|Type|Description|
|:---|:---|:---|
|price|Object ([Price](#Orders.GET.payment.price))|Price definition|
|interval_of_days|String|Payment date interval in days, ISO 8601 formatted (see [PHP DateInterval](https://php.net/manual/pl/dateinterval.construct.php) for more information)|

***<a name="Orders.GET.payment.price"></a>`Price` object structure***
|Field|Type|Description|
|:---|:---|:---|
|value|Number|Price value|
|currency|String|Price currency ([ISO 4217](https://en.wikipedia.org/wiki/ISO_4217))|

***<a name="Orders.GET.contractor"></a>`Contractor` object structure***
|Field|Type|Description|
|:---|:---|:---|
|name|String|Company name|
|vat_id|String|Company VAT id|
|address|Object ([Address](#Orders.GET.address))|Company address details|
|contact_person|Object ([ContactPerson](#Orders.GET.contact_person))|Contact person details|


***<a name="Orders.GET.contact_person"></a>`ContactPerson` object structure***
|Field|Type|Description|
|:---|:---|:---|
|contact_id|String|Person's contact id|
|employee_id|String|Employee id from Companies API|
|trans_id|String|Person's TransID|
|given_name|String|Person's given name|
|family_name|String|Person's last name|
|email|String|E-mail address|
|telephone|String|Telephone number in format: `(XX) XXXXXXXXX`|

***<a name="Orders.GET.load"></a>`Load` object structure***
|Field|Type|Description|
|:---|:---|:---|
|name|String|Load name|
|type_of_load|Enum|Possible values: [`adr`,`bags`,`unit`,`logs`,`envelope`,`box`,`barrel`,`pallet`,`other`]|
|weight|Object ([Weight](#Orders.GET.load.Weight))|Load weight details|
|volume|Object ([Volume](#Orders.GET.load.Volume))|Load weight details|
|height|Object ([Dimension](#Orders.GET.load.Dimension))|Load height Dimension|
|width|Object ([Dimension](#Orders.GET.load.Dimension))|Load width Dimension|
|length|Object ([Dimension](#Orders.GET.load.Dimension))|Load length Dimension|
|amount|Number|Amount of loads|

***<a name="Orders.GET.load.Weight"></a>`Weight` object structure***
|Field|Type|Description|
|:---|:---|:---|
|value|Number|Weight value|
|unit_code|String|Weight unit code <br />Possible values: `TNE` (tons)|

***<a name="Orders.GET.load.Volume"></a>`Volume` object structure***
|Field|Type|Description|
|:---|:---|:---|
|value|Number|Volume value|
|unit_code|String|Volume unit code <br />Possible values: `M3` (cubic meter)|

***<a name="Orders.GET.load.Dimension"></a>`Dimension` object structure***
|Field|Type|Description|
|:---|:---|:---|
|value|Number|Dimension value|
|unit_code|String|Dimension unit code <br />Possible values: `M` (meter)|

***<a name="Orders.GET.load.Vehicle"></a>`Vehicle` object structure***
|Field|Type|Description|
|:---|:---|:---|
|registration_plate_number|String|Vehicle's registration plate number|
|semi_trailer|Object([SemiTrailer](#Orders.GET.load.SemiTrailer))|SemiTrailer data|

***<a name="Orders.GET.load.SemiTrailer"></a>`SemiTrailer` object structure***
|Field|Type|Description|
|:---|:---|:---|
|registration_plate_number|String|Trailer's registration plate number|

***<a name="Orders.GET.load.Driver"></a>`Driver` object structure***
|Field|Type|Description|
|:---|:---|:---|
|employee_id|Number|Employee ID from Companies API|
|family_name|String|Person's last name|
|given_name|String|Person's given name|
|identity_document_number|String|Driver's ID document number|
|telephone|String|Telephone number in format: `(XX) XXXXXXXXX`|

***<a name="Orders.GET.load.Requirements"></a>`Requirements` object structure***
|Field|Type|Description|
|:---|:---|:---|
|is_ftl|Boolean|Is full track load flag|
|is_tracking_system_required|Boolean|Tracking system requirement flag|
|is_truck_crane_required|Boolean|Truck crane requirement flag|
|is_lift_required|Boolean|Lift requirement flag|
|is_tir_cable_required|Boolean|Tir cable requirement flag|
|shipping_remarks|String|Remarks to the shipping|
|required_ways_of_loading|Enum|Multiple value can be selected. Possible values: [`side`,`top`,`back`]|
|required_truck_bodies|Enum|Multiple value can be selected. Possible values: [`tent`, `isotherm`, `box-truck`, `spacious`, `other`, `car-transporter`, `double-trailer`, `van`, `mega`, `coilmulde`, `walking-floor`, `low-suspension`, `flatbed`, `chemical-tanker`, `food-tanker`, `petroleum-tanker`, `gas-tanker`, `log-trailer`, `oversized-cargo`, `hook-lift`, `container-20-40`, `dump-truck`, `koffer`, `swap-body-system`, `jumbo`, `cooler`, `curtainsider`, `tanker`, `silos`, `removal-truck`]|
|required_adr_classes|Enum|Multiple value can be selected. Possible values: [`1`, `2`, `3`, `4.1`, `4.2`, `4.3`, `5.1`, `5.2`, `6.1`, `6.2`, `7`, `8`, `9`]|

**Example**
```
GET /api/rest/v1/orders/e674e0a3-847c-4f75-bdff-cedaf6986c7c HTTP/1.1
Host: orders.system.trans.eu
Accept: application/hal+json
Authorization: Bearer {access_token}
```
```
HTTP/1.1 200 OK
Content-Type: application/hal+json

{
  "id": "e674e0a3-847c-4f75-bdff-cedaf6986c7c",
  "number": "EN/15022021/10",
  "route": {
    "events": [
      {
        "place": {
          "address": {
            "locality": "Berlin",
            "postal_code": "3456",
            "country": "DE",
            "street": "Erste strasse",
            "number": "12"
          },
          "coordinates": {
            "latitude": 23.256789,
            "longitude": 90
          }
        },
        "time_frame": {
          "day": "2017-02-20",
          "time_from": "09:09:09+00:00",
          "time_to": "16:59:59+00:00"
        },
        "type": "loading"
      },
      {
        "place": {
          "address": {
            "locality": "Berlin",
            "postal_code": "3456",
            "country": "DE",
            "street": "Some Avenue",
            "number": "32"
          },
          "coordinates": {
            "latitude": 23.256789,
            "longitude": 42.000001
          }
        },
        "time_frame": {
          "day": "2017-02-22",
          "time_from": "18:00:00+00:00",
          "time_to": "20:00:00+00:00"
        },
        "type": "unloading"
      }
    ]
  },
  "loads": [
    {
      "name": "Test load",
      "weight": {
        "value": 1,
        "unit_code": "TNE"
      },
      "length": {
        "value": 4,
        "unit_code": "M"
      },
      "width": {
        "value": 3,
        "unit_code": "M"
      },
      "height": {
        "value": 2,
        "unit_code": "M"
      },
      "volume": {
        "value": 5,
        "unit_code": "M3"
      },
      "type_of_load": "barrel",
      "amount": 2
    }
  ],
  "shipper": {
    "name": "Shipping imperium",
    "vat_id": "5379420247",
    "address": {
      "locality": "London",
      "postal_code": "50-001",
      "country": "PL",
      "street": "Kings street",
      "number": "1"
    },
    "contact_person": {
      "family_name": "John",
      "given_name": "Doe",
      "email": "john.doe@trans.eu",
      "telephone": "",
      "employee_id": 823436,
      "trans_id": "1008544-1",
      "contact_id": null
    }
  },
  "carrier": {
    "name": "Carrying company",
    "vat_id": "PL6470094616",
    "address": {
      "locality": "London",
      "postal_code": "58-100",
      "country": "PL",
      "street": "Some street",
      "number": "22/11"
    },
    "contact_person": {
      "family_name": "Paul",
      "given_name": "Doe",
      "email": "paul.doe@trans.eu",
      "telephone": "",
      "employee_id": 823439,
      "trans_id": "1008547-1",
      "contact_id": null
    }
  },
  "payer": {
    "name": "Carrier Trans.eu",
    "vat_id": "0001111444455",
    "address": {
      "locality": "Parisss",
      "postal_code": "3334",
      "country": "FR",
      "street": "Some street",
      "number": "4/2"
    },
    "contact_person": {
      "family_name": "Johan",
      "given_name": "Sebastian",
      "email": "test@trans.eu",
      "telephone": "(48) 1001000100",
      "employee_id": null,
      "trans_id": null,
      "contact_id": 123155
    }
  },
  "payment": {
    "price": {
      "value": 34,
      "currency": "PLN"
    },
    "interval_of_days": "P10D"
  },
  "driver": {
    "given_name": "Joe",
    "family_name": "Doe",
    "telephone": "(48) 3003000303",
    "identity_document_number": "AFA180815",
    "employee_id": null
  },
  "vehicle": {
    "registration_plate_number": "SPS 212",
    "semi_trailer": {
      "registration_plate_number": "SPS 313"
    }
  },
  "requirements": {
    "is_ftl": true,
    "is_tracking_system_required": true,
    "is_truck_crane_required": true,
    "is_lift_required": true,
    "is_tir_cable_required": true,
    "required_ways_of_loading": [
      "side",
      "top",
      "back"
    ],
    "required_truck_bodies": [
      "tent",
      "isotherm",
      "box-truck",
      "spacious",
      "other",
      "car-transporter",
      "double-trailer",
      "van",
      "mega",
      "coilmulde",
      "walking-floor",
      "low-suspension",
      "flatbed",
      "chemical-tanker",
      "food-tanker",
      "petroleum-tanker",
      "gas-tanker",
      "log-trailer",
      "oversized-cargo",
      "hook-lift",
      "container-20-40",
      "dump-truck",
      "koffer",
      "swap-body-system",
      "jumbo",
      "cooler",
      "curtainsider",
      "tanker",
      "silos",
      "removal-truck"
    ],
    "required_adr_classes": [
      "1",
      "2",
      "3",
      "4.1",
      "4.2",
      "4.3",
      "5.1",
      "5.2",
      "6.1",
      "6.2",
      "7",
      "8",
      "9"
    ],
    "shipping_remarks": "Test remark"
  },
  "_links": {
    "self": {
      "href": "https://0.0.0.0:8080/api/rest/v1/orders/e674e0a3-847c-4f75-bdff-cedaf6986c7c"
    },
    "carrier_company": {
      "id": 1008547,
      "href": "https://companies.system.trans.eu/api/rest/v1/companies/1008547"
    },
    "carrier_contact_person": {
      "employee_id": 823439,
      "href": "https://companies.system.trans.eu/api/rest/v1/employees/823439"
    },
    "shipper_company": {
      "id": 1008544,
      "href": "https://companies.system.trans.eu/api/rest/v1/companies/1008544"
    },
    "shipper_contact_person": {
      "employee_id": 823436,
      "href": "https://companies.system.trans.eu/api/rest/v1/employees/823436"
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
|route|Object ([Route](#Orders.POST.route))|Route details|yes|
|loads|Array (of [Load](#Orders.POST.load))|Loads details|no|
|carrier|Object ([Contractor](#Orders.POST.contractor))|Carrier details|no|
|payer|Object ([Contractor](#Orders.POST.contractor))|Payer details|no|
|payment|Object ([Payment](#Orders.POST.payment))|Payment details|no|
|vehicle|Object ([Vehicle](#Orders.POST.Vehicle))|Vehicle details|
|driver|Object ([Driver](#Orders.POST.Driver))|Driver details|
|requirements|Object ([Requirements](#Orders.POST.Requirements))|Requirements|

***<a name="Orders.POST.contractor"></a>`Contractor` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|name|String|Company name|yes|
|vat_id|String|Company VAT id|no|
|address|Object ([Address](#Orders.POST.address))|Company address details|no|
|contact_person|Object ([ContactPerson](#Orders.POST.contact_person))|Contractor contact person details|no|

***<a name="Orders.POST.address"></a>`Address` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|street|String|Street name|no|
|number|String|Street number|no|
|locality|String|City name|yes|
|postal_code|String|Postal code|yes|
|country|String|Country code in format [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) <br /> Example: `PL`|yes|

***<a name="Orders.POST.contact_person"></a>`ContactPerson` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|contact_id|String|Person's contact id|no|
|employee_id|String|Employee id from Companies API|no|
|trans_id|String|Person's TransID|no|
|given_name|String|Person's first name|yes|
|family_name|String|Person's last name|yes|
|email|String|E-mail address|yes|
|telephone|String|Phone number in format: `(XX) XXXXXXXXX`|no|

***<a name="Orders.POST.route"></a>`Route` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|events|Array (of [RouteEvent](#Orders.POST.route.event))|Array with route events|yes|

***<a name="Orders.POST.route.event"></a>`RouteEvent` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|place|Object ([Place](#Orders.POST.place))|Details of event place|yes|
|time_frame|Object ([TimeFrame](#Orders.POST.TimeFrame))|Time frame when load is expected|yes|
|type|String|Event type. <br />Possible values: `loading`, `unloading`|yes|

***<a name="Orders.POST.place"></a>`Place` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|address|Object ([Address](#Orders.POST.address))|Address details|yes|

***<a name="Orders.POST.TimeFrame"></a>`TimeFrame` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|day|Date|`[YYYY-MM-DD]`|no|
|time_from|Date|`[hh]:[mm]:[ss]Z` ie. `11:20:00+01:00`|no|
|time_to|Date|`[hh]:[mm]:[ss]Z` ie. `11:20:00+01:00`|no|

***<a name="Orders.POST.load"></a>`Load` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|name|String|Load name|no|
|type_of_load|Enum|Possible values: [`adr`,`bags`,`unit`,`logs`,`envelope`,`box`,`barrel`,`pallet`,`other`]|no|
|weight|Object ([Weight](#Orders.POST.load.weight))|Load weight details|yes|
|volume|Object ([Volume](#Orders.POST.load.Volume))|Load weight details|no|
|height|Object ([Dimension](#Orders.POST.load.Dimension))|Load height Dimension|no|
|width|Object ([Dimension](#Orders.POST.load.Dimension))|Load width Dimension|no|
|length|Object ([Dimension](#Orders.POST.load.Dimension))|Load length Dimension|no|
|amount|Number|Amount of loads|no|

***<a name="Orders.POST.load.weight"></a>`Weight` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|value|Number|Weight value|yes|
|unit_code|String|Weight unit code<br />Possible values: `TNE` (tons)|yes|

***<a name="Orders.POST.load.Volume"></a>`Volume` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|value|Number|Volume value|yes|
|unit_code|String|Weight unit code<br />Possible values: `M3` (cubic meter)|yes|

***<a name="Orders.POST.load.Dimension"></a>`Dimension` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|value|Number|Dimension value|yes|
|unit_code|String|Weight unit code<br />Possible values: `M` (meter)|yes|

***<a name="Orders.POST.payment"></a>`Payment` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|price|Object ([Price](#Orders.POST.payment.price))|Price definition|yes|
|interval_of_days|String|Payment date interval _(in days, ISO 8601 formatted - see [PHP DateInterval](https://php.net/manual/pl/dateinterval.construct.php) for more information)_|yes|

***<a name="Orders.POST.payment.price"></a>`Price` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|value|Number|Price value _(positive number)_|yes|
|currency|String ([Currency](#Orders.POST.payment.currency))|Price currency ([ISO 4217](https://en.wikipedia.org/wiki/ISO_4217))|yes|

***<a name="Orders.POST.payment.currency"></a> Supported `Currency` list***
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

***<a name="Orders.POST.Vehicle"></a>`Vehicle` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|registration_plate_number|String|Vehicle's registration plate number|no|
|semi_trailer|Object([SemiTrailer](#Orders.POST.SemiTrailer))|SemiTrailer data|no|

***<a name="Orders.POST.SemiTrailer"></a>`SemiTrailer` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|registration_plate_number|String|SemiTrailer's registration plate number|no|

***<a name="Orders.POST.Driver"></a>`Driver` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|employee_id|Number|Employee ID from Companies API|no|
|family_name|String|Person's last name|no|
|given_name|String|Person's given name|no|
|identity_document_number|String|Driver's ID document number|no|
|telephone|String|Telephone number in format: `(XX) XXXXXXXXX`|no|

***<a name="Orders.POST.Requirements"></a>`Requirements` object structure***
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|is_ftl|Boolean|Is full track load flag|no|
|is_tracking_system_required|Boolean|Tracking system requirement flag|no|
|is_truck_crane_required|Boolean|Truck crane requirement flag|no|
|is_lift_required|Boolean|Lift requirement flag|no|
|is_tir_cable_required|Boolean|Tir cable requirement flag|no|
|shipping_remarks|String|Remarks to the shipping|no|
|required_ways_of_loading|Enum|Multiple value can be selected. Possible values: [`side`,`top`,`back`]|no|
|required_truck_bodies|Enum|Multiple value can be selected. Possible values: [`tent`, `isotherm`, `box-truck`, `spacious`, `other`, `car-transporter`, `double-trailer`, `van`, `mega`, `coilmulde`, `walking-floor`, `low-suspension`, `flatbed`, `chemical-tanker`, `food-tanker`, `petroleum-tanker`, `gas-tanker`, `log-trailer`, `oversized-cargo`, `hook-lift`, `container-20-40`, `dump-truck`, `koffer`, `swap-body-system`, `jumbo`, `cooler`, `curtainsider`, `tanker`, `silos`, `removal-truck`]|no|
|required_adr_classes|Enum|Multiple value can be selected. Possible values: [`1`, `2`, `3`, `4.1`, `4.2`, `4.3`, `5.1`, `5.2`, `6.1`, `6.2`, `7`, `8`, `9`]|no|

**<a name="Orders.POST.response"></a>Responses**

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
POST /api/rest/v1/shipping-orders HTTP/1.1
Host: orders.system.trans.eu
Accept: application/hal+json
Content-Type: application/json
Authorization: Bearer {access_token}
```
```
{
  "number": "EN/15022021/10",
  "route": {
    "events": [
      {
        "place": {
          "address": {
            "locality": "Berlin",
            "postal_code": "3456",
            "country": "DE",
            "street": "Some Avenue",
            "number": "12"
          },
          "coordinates": {
            "latitude": 23.256789,
            "longitude": 90.000000
          }
        },
        "time_frame": {
          "day": "2017-02-20",
          "time_from": "09:09:09+00:00",
          "time_to": "16:59:59+00:00"
        },
        "type": "loading"
      },
      {
        "place": {
          "address": {
            "locality": "Berlin",
            "postal_code": "3456",
            "country": "DE",
            "street": "Some Avenue",
            "number": "32"
          },
          "coordinates": {
            "latitude": 23.256789,
            "longitude": 42.000001
          }
        },
        "time_frame": {
          "day": "2017-02-22",
          "time_from": "18:00:00+00:00",
          "time_to": "20:00:00+00:00"
        },
        "type": "unloading"
      }
    ]
  },
  "loads": [
    {
      "name": "Test load",
      "type_of_load": "barrel",
      "weight": {
        "value": 1,
        "unit_code": "TNE"
      },
      "height": {
        "value": 2,
        "unit_code": "M"
      },
      "width": {
        "value": 3,
        "unit_code": "M"
      },
      "length": {
        "value": 4,
        "unit_code": "M"
      },
      "volume": {
        "value": 5,
        "unit_code": "M3"
      },
      "amount": 2
    }
  ],
  "payer": {
    "name": "Carrier Trans.eu",
    "vat_id": "0001111444455",
    "language": "PL",
    "address": {
      "locality": "Parisss",
      "postal_code": "3334",
      "country": "FR",
      "street": "Ulica Fabrycznego",
      "number": "4/2"
    },
    "contact_person": {
      "contact_id": 123155,
      "family_name": "Testowski",
      "given_name": "Tescik jr",
      "email": "test@trans.eu",
      "telephone": "(48) 1001000100",
      "fax": "(48) 2002000200"
    }
  },
  "driver": {
    "employee_id": 110519,
    "family_name": "Doe",
    "given_name": "Joe",
    "identity_document_number": "AFA180815",
    "telephone": "(48) 3003000303"
  },
  "requirements": {
    "is_ftl": true,
    "is_tracking_system_required": true,
    "shipping_remarks": "Test remark",
    "required_ways_of_loading": [
      "side"
    ],
    "required_truck_bodies": [
      "tent"
    ],
    "is_truck_crane_required": true,
    "is_lift_required": true,
    "is_tir_cable_required": true,
    "required_adr_classes": [
      "9"
    ]
  }
}
```
```http
HTTP/1.1 201 Created
Content-Type: application/hal+json

{
	"id": "56acf700-1774-11e6-8ab6-0002a5d5c51b",
    // ...
}
```
POST response data structure is identical to [GET response structure](#Orders.GET.response).

