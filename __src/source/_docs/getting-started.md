---
title: TransAPI getting started guide
is_homepage: true
---

[Trans.eu Platform](http://www.trans.eu/) interconnects applications and
people across the transport and logistics industry.

TransAPI is based on [REST](https://en.wikipedia.org/wiki/Representational_state_transfer) architecture and [JSON](https://en.wikipedia.org/wiki/JSON) data format.

## TransAPI authorization

Standard used for requests authorization is [OAuth](/api-rest-documentation/authorization/authorization-overview).
Currently two flows are supported

* 3 legged for applications where users can come from outside of the application,
* 2 legged flow for applications, that are only used by users from within their application and company.

It is also possibile to use Trans Authorization Server to log users into your application.

For more information on this topic please read [Authorization Use Cases](/api-rest-documentation/use-cases/authorization-use-cases/).

## REST APIs

TransAPI consists of several interconnected REST APIs.

Those APIs provide access to operations in [Trans.eu Platform](http://www.trans.eu/).

### Offers API

Offers API gives you access to offers in [Trans.eu Platform](http://www.trans.eu/).

### Companies API

Companies API provides data about companies in [Trans.eu Platform](http://www.trans.eu/).

## [FAQ section](/api-rest-documentation/faq)

## RPC APIs (deprecated)

Link: [http://manual.api.trans.eu](http://manual.api.trans.eu/)
