---
title: Multi language support
is_documentation: true
side_menu:
  - title: Authorization overview
    url: /authorization/authorization-overview/
  - title: Registering an application
    url: /authorization/registering-an-application/
  - title: Multi language support
    url: /authorization/multi-language-support/
    active: true
  - title: Authorization Code Grant (external users)
    url: /authorization/authorization-code-grant/
  - title: Refreshing an Access Token
    url: /authorization/refreshing-an-access-token/
  - title: Resource Owner Password Credentials Grant (internal users)
    url: /authorization/resource-owner-password-credentials-grant/
---

Trans Authorization Server authentication page and access grant page can be displayed in different languages.
To change displayed language you can use `locale` query param.

```http
https://auth.system.trans.eu/oauth2/login?locale=pl-PL
```

If `locale` parameter is not set, browser language is detected (by Accept-Languages header), finally if it can not be detected, `en-GB` is set as default.

## Supported Locales

* en-GB (English)
* pl-PL (Polski)