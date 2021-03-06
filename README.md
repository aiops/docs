# Logsight.ai docs

## Install docsify locally

### Linux
```bash
sudo apt install npm
sudo npm i docsify-cli -g
```

### MacOS
```bash
brew install node
sudo npm i docsify-cli -g
```


## Clone and serve

```bash
git clone git@github.com:aiops/docs.git
cd docs
docsify serve docs
```

## Instructions

If you want to write the docs for the API, specifically Sending Logs API, to preserve the structure we need to:

1. Create a folder inside /docs named /API (or whatever name suits) which will be the heading for the navigation bar.
2. Create a file inside the folder named sending_logs_api.md
3. Populate that file with content.
4. Edit the /_sidebar.md file to include your file into the sidebar menu.
5. Push the docs to Github

```bash
git status
git add <modified files>
git commit -m "chg: updated README"
git push
```

## Testing 

Use, e.g., https://error404.atomseo.com, to test that all the links are working 

+ https://error404.atomseo.com/SeoCheck/Report/docs.logsight.ai/2022-07-30/free?from=
