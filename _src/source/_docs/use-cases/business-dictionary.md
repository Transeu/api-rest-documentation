---
title: TransAPI Business dictionary
is_use_case: true
side_menu:
  - title: Authorization use cases
    url: /use-cases/authorization-use-cases/
  - title: TransAPI Business use cases
    url: /use-cases/transapi-business-use-cases/
  - title: TransAPI Business dictionary
    url: /use-cases/transapi-business-dictionary/
    active: true

---

## Offer types ##

* **Public** - offer is visible and available for all Trans.eu platform users immediately. Regardless of whether they are employees of the same company, corporation, or whether they belong to a common cluster.
* **Private** - offer is visible and available only for the employees of the same company as the oferrer.
* **Cluster** - offer is visible and available to employees of companies that are members of the cluster. The offer becomes visible in cluster right after being added.
**Note:** a company can be a member of many clusters, and each of them has a separate identifier to be specified during offer adding. 
For ex.
 
```
"type":  "cluster",
"clusters" : [
    { "id": 123}
],
```