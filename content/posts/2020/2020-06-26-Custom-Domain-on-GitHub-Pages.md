---
title: 'Custom Domain on GitHub Pages'
date: 2020-06-26T18:00:00+02:00
publishdate: 2020-06-26T18:00:00+02:00
tags: ["github-pages"]
---

### Introduction

Using Github pages we can use own domain - more about that you can find in [documentation][github-pages-documentation].

#### Here is steps to configure custom domain

1. First we need repository. Repository for root domain should be named `{user_name}.github.io` or `{organization_name}.github.io`. 
In my case this is [pelicandev.github.io][pelicandev.github.io] repository.

2. Now go to repository settings and set your domain in `GitHub Pages` section.
    ![setting custon domain address on GitHub Pages][set-custom-domain-on-github-pages]

3. Go to your DNS provider and create records for you site. Here is my records:
    ```txt
    | Name | Type  | Value                 |
    |------|-------|-----------------------|
    | @    | A     | 185.199.108.153       |
    | @    | A     | 185.199.109.153       |
    | @    | A     | 185.199.110.153       |
    | @    | A     | 185.199.111.153       |
    | www  | CNAME | pelicandev.github.io. |
    ```
    IPs adresses in A records could be vary, so it is worth checking the [documetation][github-pages-ip] to see if they are up to date.
    Value in CNAME records is my Github Pages address.

Now everything is set up correctly. It may take a while for the page to be accessible by our custom domain - this time depends on DNS propagation.


[github-pages-documentation]: https://help.github.com/en/github/working-with-github-pages/configuring-a-custom-domain-for-your-github-pages-site
[github-pages-ip]: https://help.github.com/en/github/working-with-github-pages/managing-a-custom-domain-for-your-github-pages-site
[pelicandev.github.io]: https://github.com/pelicandev/pelicandev.github.io

[set-custom-domain-on-github-pages]: https://pelicandev.io/images/2020/06/26/set-custom-domain-on-github-pages.jpg