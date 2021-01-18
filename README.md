# hugo-deploy

Deploy your Hugo site to GitHub Pages, via GitHub Actions, with Arch Linux.

## Prerequisites

- Git your Hugo site

## Usage

1. Generate SSH public/private key pair

   ```sh
   ssh-keygen -t rsa -b 4096 -C "username@users.noreply.github.com"
   ```

2. Add deploy key to GitHub Pages repository

   Copy the generated `id_rsa.pub` to your clipboard, then add it to your *GitHub Pages* repository.

   **Note that** the "Allow write access" *must* be checked.
   
   See https://docs.github.com/en/developers/overview/managing-deploy-keys#setup-2

3. Add secret key to the source code repository

   Copy the generated `id_rsa` to your clipboard, then add it to the *source code* repository.
   
   **Note that** the `Name` *must* be `DEPLOY_KEY`.

   See https://docs.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets#creating-encrypted-secrets-for-a-repository

4. Add workflow

   Refer to the example workflow below.

5. Commit and push changes

## Example workflow

```yml
# .github/workflows/build.yml

name: build

on:
  push:
    branches:
    - master

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: 'Building...'
      uses: reuixiy/hugo-deploy@v1
      env:
        DEPLOY_REPO: username/username.github.io
        DEPLOY_BRANCH: build
        DEPLOY_KEY: ${{ secrets.DEPLOY_KEY }}
        # https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
        TZ: Asia/Shanghai
```

## Additional Notes

- With Arch Linux, hugo-deploy will always use the latest extended version of Hugo, [check it here](https://www.archlinux.org/packages/community/x86_64/hugo/).
- In order to ensure the cleanliness of the GitHub Pages repository, hugo-deploy won't keep the commits history of `DEPLOY_BRANCH`, which means there is always only one commit in that branch.
- Example badge: `[![GitHub Actions](https://github.com/reuixiy/io-oi.me/workflows/build/badge.svg)](https://github.com/reuixiy/io-oi.me/actions)`
- If the source code is on GitHub Pages repository, then the step 2 and step 3 are in the same repository.
- If the `DEPLOY_BRANCH` is `build`, you may need to [choose a publishing source](https://docs.github.com/en/github/working-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site#choosing-a-publishing-source) for your GitHub Pages *after* the first build.
- If you want to [add a custom domain for your GitHub Pages site](https://docs.github.com/en/github/working-with-github-pages/managing-a-custom-domain-for-your-github-pages-site#configuring-an-apex-domain), you may need to add a `static/CNAME` file to your Hugo site, with your domain name in it.
- [Enforcing HTTPS for your GitHub Pages site](https://docs.github.com/en/github/working-with-github-pages/securing-your-github-pages-site-with-https#enforcing-https-for-your-github-pages-site).

## Acknowledgements

<https://github.com/Xuanwo/blog/blob/35504e96a1/.github/actions/hugo/entrypoint.sh>
