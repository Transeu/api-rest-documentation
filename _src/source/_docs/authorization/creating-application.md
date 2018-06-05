---
title: Registering an application
is_documentation: true
side_menu:
  - title: Authorization overview
    url: /authorization/authorization-overview/
  - title: Registering an application
    url: /authorization/registering-an-application/
    active: true
  - title: Multi language support
    url: /authorization/multi-language-support/
  - title: Authorization Code Grant (external users)
    url: /authorization/authorization-code-grant/
  - title: Refreshing an Access Token
    url: /authorization/refreshing-an-access-token/
  - title: Resource Owner Password Credentials Grant (internal users)
    url: /authorization/resource-owner-password-credentials-grant/
---

Before authorizing user and accessing TransApi resources, you need to register an application.

Every registered application has it's own unique `client_id` and `client_secret`.

Process of registering application is handled by Logintrans.

To initiate this process please contact Paweł Dżumaga with email address [pdzumaga@trans.eu](mailto:pdzumaga@trans.eu?subject=Prośba%20o%20rejestrację%20aplikacji%20w%20Trans.eu).

## Required application data

In order to register new application in Authorization Server you need to provide following data:

| Parameter | Description | Mandatory |
| --- | --- | --- |
| application name | Name for your application that will be used and displayed across TransAPI systems | yes |
| authorization method | Describe where will end-user credentials come from. Possibilities are that either directly from end user, or your application will provide it without redirecting to Authorization Server login page | yes |
| redirect URIs | Whitelisted URI addresses you will be able to use as `redirect_uri` parameter value your users after processing authorization request. In case URI used will not be registered, authentication request will be rejected | yes |
| Terms Of Use URI | Full URI leading to Terms of Use of your application. Will be displayed on Authorization Server login page | no |
| Privacy Policy URI | Full URI leading to Privacy Policy of your application. Will be displayed on Authorization Server login page | no |
| Special requirements | This information is important your application requires custom access permissions, as those need to be granted manually per each application | no |

Any created application will have ability to request access to public scopes during login process.

Please also be aware that `client_secret` value you will receive in feedback is security sensitive value.

You should keep this value safe at all times and avoid exposing it.

For further `client_secret` informations please see [specification document](http://tools.ietf.org/html/rfc6749#section-2.3.1).
