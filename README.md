# docs


## Install docsify locally

```bash
sudo apt install npm
sudo npm i docsify-cli -g
```

```bash
docsify serve docs
```

## Instructions

If you want to write the docs for the API, specifically Sending Logs API, to preserve the structure we need to:

1. Create a folder inside /docs named /API (or whatever name suits) which will be the heading for the navigation bar.
2. Create a file inside the folder named sending_logs_api.md
3. Populate that file with content.
4. Edit the /_sidebar.md file to include your file into the sidebar menu.
