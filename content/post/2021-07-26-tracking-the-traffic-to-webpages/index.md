---
title: Tracking the traffic to webpages
author: Haky Im
date: '2021-07-26'
slug: tracking-the-traffic-to-webpages
categories:
  - how_to
tags: []
---

To keep track of traffic to blogdown (hugo-based) webpages in google analytics, follow the steps below

See Google's instructions [here](https://analytics.google.com/analytics/web/#/report-home/a61894206w113816209p118905410). Briefly

1. Sign in to [your Analytics account](https://analytics.google.com/).
2. Click **[Admin](https://support.google.com/analytics/answer/6132368)**.
3. Select an account from the menu in the *ACCOUNT* column.
4. Select a property from the menu in the *PROPERTY* column.
5. Under *PROPERTY*, click **Tracking Info > Tracking Code**.Your **[Tracking ID](https://support.google.com/analytics/answer/7372977)** is displayed at the top of the page.

Copy the global site tag, which is several lines of code that you need to paste into each webpage you want to measure. Below is the code for tracking predictdb.org

```
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-61894206-2"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-61894206-2');
</script>

```

1. Copy the code above to the site's layout head_custom.html file. For example for predictdb website, the file is found in `https://github.com/hakyimlab/web-predictdb/blob/main/layouts/partials/head_custom.html`.
2. Paste it immediately after the `<head>` tag on each page of your site.