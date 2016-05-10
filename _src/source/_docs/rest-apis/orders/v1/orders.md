# TransOrders API Endpoints Reference
**Version:** 1.0.0  
**Base URL:** `https://orders.system.trans.eu/api/rest/1`

## Resources
### GET
    GET /orders/{order-id} HTTP/1.1

#### Success Response

##### Http status: `200`

##### Resposne data structure
|Property|Type|Description|
|:---|:---|:---|
|id|String|Unique order id|
|number|String|Unique order number|
|route|Object|Route details|
|payment|Object|Payment details|
|carrier|Object|Carrier details|
|shipper|Object|Shipper details|
|loads|Array|Loads array|
|_links|Object|External resources references|   

###### {route} object structure
|Field|Type|Description|
|:---|:---|:---|
|events|Array|Array with loading/unloading events|

###### {route.events} array single item structure
|Field|Type|Description|
|:---|:---|:---|
|place|Object|Loading/unloading place details|
|type|String|Event type ('loading' or 'unloading')|

###### {route.events[i].place} object structure
|Field|Type|Description|
|:---|:---|:---|
|address|Object|Address details|

###### {route.events[i].place.address} object structure
|Field|Type|Description|
|:---|:---|:---|
|locality|String|City name|
|postal_code|String|Postal code|
|country|String|Country code (ie. 'PL')|

###### {payment} object structure
|Field|Type|Description|
|:---|:---|:---|
|price|Object|Price details|
|interval|String|Payment interval (see http://php.net/manual/pl/dateinterval.construct.php for more information)|

###### {payment.price} object structure
|Field|Type|Description|
|:---|:---|:---|
|value|Integer|Price value|
|currency|String|Price currency|

###### {carrier} object structure
|Field|Type|Description|
|:---|:---|:---|
|company|Object|Carrier company details|
|contact_person|Object|Contact person details|

###### {carrier.company} object structure
|Field|Type|Description|
|:---|:---|:---|
|id|Integer|Carrier company unique id|
|name|String|Carrier company name|
|vat_id||String|Carrier company VAT id|
|address|Object|Carrier company address details|

###### {carrier.company.address} object structure
|Field|Type|Description|
|:---|:---|:---|
|locality|String|Carrier company city name|
|postal_code|String|Carrier company postal code|
|country|String|Carrier company country code (ie. 'PL')|

###### {carrier.contact_person} object structure
|Field|Type|Description|
|:---|:---|:---|
|family_name|String|Carrier contact person last name|
|given_name|String|Carrier contact person given name|
|email|String|Carrier contact person email address|
|telephon|String|Carrier contact person telephone|

###### {shipper} object structure
|Field|Type|Description|
|:---|:---|:---|
|company|Object|Shipper details|
|contact_person|Object|Shipper contact person|

###### {shipper.company} object structure
|Field|Type|Description|
|:---|:---|:---|
|name|String|Shipper company name|
|vat_id||String|Shipper company VAT id|
|address|Object|Shipper company address details|

###### {shipper.company.address} object structure
|Field|Type|Description|
|:---|:---|:---|
|locality|String|Shipper company city name|
|postal_code|String|Shipper company postal code|
|country|String|Shipper company country code (ie. 'PL')|

###### {shipper.contact_person} object structure
|Field|Type|Description|
|:---|:---|:---|
|family_name|String|Shipper contact person last name|
|given_name|String|Shipper contact person given name|
|email|String|Shipper contact person email address|
|telephon|String|Shipper contact person telephone|

###### {loads[i]} array item structure
|Field|Type|Description|
|:---|:---|:---|
|weight|Object|Load weight details|

###### {loads[i].weight} array item structure
|Field|Type|Description|
|:---|:---|:---|
|value|Integer|Weight value|
|unit|String|Weight unit|

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
|interval|String|Payment interval (see http://php.net/manual/pl/dateinterval.construct.php for more information)|yes|

###### {payment.price} object structure
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|value|Integer|Price value|yes|
|currency|String|Price currency|yes|

##### {shipper} object structur
|Field|Type|Description|Required|
|:---|:---|:---|:---|
|company|Object|Description|Shipper company details|no|
|contact_person|Object|Shipper contact person details|no|

##### {shipper.company} object structur
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
|telephon|String|Shipper contact person telephone|no|

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
|unit|String|Weight unit|yes|

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
