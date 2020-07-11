---
title: 'Hosting Hugo Static Website on GitHub Pages'
date: 2020-06-20T17:00:00+02:00
publishdate: 2020-06-20T17:00:00+02:00
tags: ["hugo", "github-pages"]
aliases: 
    - "/2020/06/20/hosting-hugo-static-website-on-github-pages/"
---

### Intoduction

* **GitHub Pages** allow to host static content directly from repository on GitHub. More about GitHub Pages you can find in [documentation][github-pages]

* **Hugo** is a static website generetor written in Go. More about Hugo you can find in [documentation][hugo]

### Preparation

To host Hugo webpage on GitHub Pages I prepared 3 repositories:
* **[blog][pelicandev/blog]** - project containing all files necessary to generate static site by Hugo
* **[pelicandev.github.io][pelicandev/pelicandev.github.io]** - repository contain static site files used by GitHub Pages
* **[hugo-theme-m10c][pelicandev/hugo-theme-m10c]** - blog theme for Hugo forked from [m10c theme repository][m10c repo]

Here was my steps:

#### 1. Create empty Hugo site in **blog** folder.
```bash
cd blog
hugo new site . --force
```

#### 2. Add theme repository as submodule
```bash
GITHUB_PROFILE="pelicandev"
git submodule add https://github.com/$GITHUB_PROFILE/hugo-theme-m10c.git themes/m10c
```
I use submodule, because I can make changes in theme and have history of that in my repository.

#### 3. Add theme reference
Open `config.toml` and add this line
```bash
theme = "m10c"
```

#### 4. Run local site server
```bash
hugo server
```
Now site is empty and need some configuration.

#### 5. Site configuration
* add profile image to `./static/images/`
* update `config.toml` file according to [official documentation][hugo configuration documentation] and [theme documetation][m10c repo]

Here is my `config.toml` file after configuration:
```toml
baseURL = "https://pelicandev.github.io/"
languageCode = "en-us"
title = "Bartosz Pelikan"
theme = "m10c"

[params]
  author = "Bartosz Pelikan"
  description = "Cloud Technology Enthusiast | .NET developer"
  avatar = "/images/img.jpg"

[[params.social]]
  name = "github"
  url = "https://github.com/bpelikan"

[[params.social]]
  name = "twitter"
  url = "https://twitter.com/bartoszpelikan"

[[params.social]]
  name = "linkedin"
  url = "https://www.linkedin.com/in/bartoszpelikan/"

[[params.social]]
  name = "mysite"
  url = "https://www.bartoszpelikan.pl/"
```

#### 6. Add first post
Add file `2020-06-20-Hello-World.md` to `/content/posts/2020`.

```md
---
title: 'Hello World!'
date: '2020-06-20'
---

First post
```

#### 7. Publish site
Now it's time to publish site to GitHub Pages. GitHub doesn't support Hugo site generator, just Jekyll, but fortunately it's possible to achieve this by sending static files.
```bash
hugo
```
This command will generate static files in `/publish` folder. 

But before run above command let's create in `/publish` folder submodule that will be GitHub repository hosting our site.
```bash
YOUR_GITHUB_PROFILE="pelicandev"
YOUR_GITHUB_REPO="pelicandev.github.io"
git submodule add https://github.com/$YOUR_GITHUB_PROFILE/$YOUR_GITHUB_REPO.git public
```

I created script `publish.sh` that will help me to publish site:
```bash
find public -type f -not -name 'CNAME' -not -name 'README.md' -not -name '.git' -delete
hugo
cd public
git status
git add .
git commit -m "Publish site $(date +"%Y-%m-%d %H:%M:%S")"
git push origin master
```

All what I need to do now is run sript:
```bash
sh publish.sh
```


<!-- Official documentation -->
[github-pages]: https://help.github.com/en/github/working-with-github-pages/about-github-pages
[hugo]: https://gohugo.io/about/what-is-hugo/
[hugo configuration documentation]: https://gohugo.io/getting-started/configuration/

<!-- Official repo -->
[m10c repo]: https://github.com/vaga/hugo-theme-m10c

<!-- Repo -->
[pelicandev/blog]: https://github.com/pelicandev/blog
[pelicandev/pelicandev.github.io]: https://github.com/pelicandev/pelicandev.github.io
[pelicandev/hugo-theme-m10c]: https://github.com/pelicandev/hugo-theme-m10c
