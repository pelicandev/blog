---
title: 'Custom Subdomain on GitHub Pages'
date: 2020-07-04T18:00:00+02:00
publishdate: 2020-07-04T18:00:00+02:00
tags: ["github-pages"]
aliases: 
    - "/2020/07/04/custom-subdomain-on-github-pages/"
---

### Introduction

Continuation of previous post about seting [Custom Domain on GitHub Pages][prev-post]. Today I seting custom subdomain on GitHub Pages.

#### Steps to configure custom subdomain

1. First we need repository. I've created [subdomain][subdomain-repo] repository for this purpose.

2. Now go to repository settings and set subdomain in `GitHub Pages -> Custom domain` section.
    ![setting custon domain address on GitHub Pages][set-custom-domain-on-github-pages]

3. Go to your DNS provider and update records. Here is my records:
    ```txt
    | Name      | Type  | Value                 |
    |-----------|-------|-----------------------|
    | subdomain | A     | 185.199.108.153       |
    | subdomain | A     | 185.199.109.153       |
    | subdomain | A     | 185.199.110.153       |
    | subdomain | A     | 185.199.111.153       |
    ```
    IPs adresses in A records could be vary, so it is worth checking the [documentation][github-pages-ip] to see if they are up to date.

Now everything is set up correctly and my [subdomain][subdomain-url] is working. It may take a while for the page to be accessible by our custom subdomain - this time depends on DNS propagation.


[prev-post]: /2020/06/26/custom-domain-on-github-pages/
[github-pages-ip]: https://help.github.com/en/github/working-with-github-pages/managing-a-custom-domain-for-your-github-pages-site

[subdomain-repo]: https://github.com/pelicandev/subdomain
[subdomain-url]: https://subdomain.pelicandev.io/

[set-custom-domain-on-github-pages]: https://pelicandev.io/images/2020/07/04/set-custom-subdomain-on-github-pages.jpg.jpg