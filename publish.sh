find public -type f -not -name 'CNAME' -not -name 'README.md' -not -name '.git' -delete
hugo
cd public
git status
git add .
git commit -m "Publish site $(date +"%Y-%m-%d %H:%M:%S")"
git push origin master
