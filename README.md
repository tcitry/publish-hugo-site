# publish hugo site

This action will use your master branch by default.

## what the action do

```
./hugo
git submodule update --init --recursive
rm -rf .git
cd public
git init
git add .
git commit -m 'Auto Published From Action'
git push --force TARGET_REPO master:<Pages branch>
```

## ENV

* HUGO_VERSION default "0.54.0"
* TARGET_REPO default is your hugo source repo
* CNAME default is xxx.github.io
* args default is "master"

## main.workflow example

```
workflow "Push to master" {
  on = "push"
  resolves = [
    "publish-hugo-site",
  ]
}

action "hugo branch" {
  uses = "actions/bin/filter@master"
  args = "branch hugo"
}

action "publish-hugo-site" {
  needs = "hugo branch"
  uses = "tcitry/publish-hugo-site@v1.0"
  env = {
    TARGET_REPO = "tcitry/tcitry.github.io"
    CNAME = "yindongliang.com"
  }
  secrets = ["TOKEN"]
  args = "<Pages branch>"
}
```

## NOTE

**NOTE: If `Pages branch` is empty will push to master!**

The action need your `GITHUB_TOKEN`, or you can custom a secrets ENV `TOKEN` to fill with your token.