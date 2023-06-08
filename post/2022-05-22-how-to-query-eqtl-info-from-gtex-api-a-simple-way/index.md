---
title: How to query eqtl info from GTEx API (a simple way)
author: Charles Zhou
date: '2022-05-22'
slug: how-to-query-eqtl-info-from-gtex-api-a-simple-way
categories:
  - how to
tags: []
---

## Query some information about eqtl from GTEx API
This is a simple and convenient way to get some information about certain eqtls from [GTEx API](https://gtexportal.org/home/api-docs/index.html). But it may not be a good way to do big query because it's not so fast.

### Open a python notebook and load some packages

```
import requests
import json
import pandas as pd 
import time # if you want to measure the query speed

```

### Get gene/tissue/variant info

```

gencode = "ENSG00000116127.17"
gene_name = "ALMS1"
tissue = "Heart_Left_Ventricle" # provide an exmple

```

### Query the portal and get the result 

```
gene_eqtls = requests.get('https://gtexportal.org/rest/v1/association/singleTissueEqtl', params = {"gencodeId" : gencode,"tissueSiteDetailId" : tissue, "datasetId" : "gtex_v8", "variantId" : 'chr2_73325414_G_A_b38'})

data = json.loads(gene_eqtls.text)
data
```

The result should be like:
```
{'singleTissueEqtl': [{'chromosome': 'chr2',
   'datasetId': 'gtex_v8',
   'gencodeId': 'ENSG00000116127.17',
   'geneSymbol': 'ALMS1',
   'geneSymbolUpper': 'ALMS1',
   'nes': 0.18502,
   'pValue': 1.1244e-05,
   'pos': 73325414,
   'snpId': 'rs7573275',
   'tissueSiteDetailId': 'Heart_Left_Ventricle',
   'variantId': 'chr2_73325414_G_A_b38'}]}
```



For some datasets like `singleTissueEqtl` with URL [https://gtexportal.org/rest/v1/association/singleTissueEqtl](https://gtexportal.org/rest/v1/association/singleTissueEqtl), we can ask multiple variants with a single query. For example, we want effect sizes of two variants in a certain tissue.


```
gencode = "ENSG00000227232.5"
tissue = "Lung"
variantId = ("chr1_665098_G_A_b38","chr1_88794_T_A_b38")

test = requests.get('https://gtexportal.org/rest/v1/association/singleTissueEqtl', 
                   params = {"gencodeId" : gencode,"tissueSiteDetailId" : tissue, "datasetId" : "gtex_v8", "variantId" : variantId})

data_test = json.loads(test.text)

for i in range(len(data_test['singleTissueEqtl'])):
             print(data_test['singleTissueEqtl'][i]['nes'])
```


The result:


```
0.376198
1.07028
```

For some other dataset like `dyneqtl` with the URL [https://gtexportal.org/rest/v1/association/dyneqtl](https://gtexportal.org/rest/v1/association/dyneqtl), we can't ask multiple variants/genes/tissues with a single query.