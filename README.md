![](https://gdc.cancer.gov/sites/all/themes/gdc_bootstrap/logo.png)

# GDC Open Source code

=======
GDC is Open Source, Github Repositories containing source code of GDC Applications can be found on [GDC GitHub Organization page](https://github.com/NCI-GDC/).

- GDC Data Portal: https://github.com/NCI-GDC/portal-ui
- GDC Legacy Archive: https://github.com/NCI-GDC/portal-ui-legacy
- GDC Data Transfer Tool: https://github.com/NCI-GDC/gdc-client
- GDC Data Dictionary: https://github.com/NCI-GDC/gdcdictionary
- GDC Data Model: https://github.com/NCI-GDC/gdcdatamodel
- GDC Psqlgraph: https://github.com/NCI-GDC/psqlgraph 

# Support

Please direct technical questions to [GDC Support](https://gdc.cancer.gov/support).

# GDC Documentation Site

### Technology

 - Python 2.6, 2.7, 3.3, 3.4 and 3.5.
 - [mkdocs](http://www.mkdocs.org/)
 - [BSCodeTabs for mkdocs](https://github.com/mikecules/MarkdownBSCodeTabs#for-use-in-mkdocs)

### Install & Run

(Optional) Set up virtualenv:

- [Install virtualenv](https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/)
- `python -m virtualenv venv`
- `source venv/bin/activate`
- Run the installation commands below
- To leave the virtual environment: `deactivate`

Install GDC-docs:

 - `pip install -r requirements.txt`
 - `mkdocs serve` (optionally set port `--dev-addr=0.0.0.0:<PORT>`)

### Build

 - `mkdocs build --clean`

### Repository Conventions

- All Shared content in the "Commons" directory
- One Directory per GDC product (API, Data_Portal, Data_Submission_Portal, Data_Transfer_Tool)
- Each GDC product have a Users_Guide and Release_Notes directory

### Linking

To another documentation page
```
[Authentication and Authorization](../../Commons/Authentication.md)
```

Inside another documentation page

```
[Authentication and Authorization](../../Commons/Authentication.md#internal-section)
```

### Adding icons and PDFs
The convention for this, when updating mkdocs.yml is the following:
- <font-awesome-icon> <content> <url ending in .pdf>: 'index.md'
example:
- fa-file-pdf-o Download PDF /API/PDF/API_UG.pdf: 'index.md'

### Documentation Conventions

A detailed list of all conventions is available on [GDC Website](https://gdc.cancer.gov/conventions-page)


### Build PDF

Install mkdocs2pandoc, following instructions available here:
```
https://github.com/jgrassler/mkdocs-pandoc
```

Prepare a yml file dedicated to your Userguide, using Data_Portal_UG.yml as an example.

Run the following commands to:
* Convert the User Guide to Pandoc:
* Tweak the pandoc file
* Build a PDF

```
mkdocs2pandoc -f Data_Portal_UG.yml -o docs/Data_Portal/PDF/Data_portal_UG.pd
sed -i -e 's/# / /g' docs/Data_Portal/PDF/Data_portal_UG.pd
sed -i -e 's/### /## /g' docs/Data_Portal/PDF/Data_portal_UG.pd
sed -i -e 's/\/site\//\/docs\//g' docs/Data_Portal/PDF/Data_portal_UG.pd
pandoc --toc -V documentclass=report -V geometry:"top=2cm, bottom=1.5cm, left=1cm, right=1cm" -f markdown+grid_tables+table_captions -o docs/Data_Portal/PDF/Data_portal_UG.pdf docs/Data_Portal/PDF/Data_portal_UG.pd
```

## Material Port

Note for a port to the Material theme for mkdocs.

### Resource

[Material for MkDocs documentation](https://squidfunk.github.io/mkdocs-material/getting-started/)

### Python Version

Use Python 3.8 or greater. For development, this branch is using Python 3.12.

### Installation

Pre-req: Make sure `pip-tools` is installed

```bash
pip install pip-tools
```

Install MkDocs and dependencies

```bash
pip-sync requirements.txt
```

### Run Locally

For development, start a mkdocs server locally with

```bash
mkdocs serve
```

In a browser, open `http://127.0.0.1:8000/`

### Generate Site

To build the site, run

```bash
mkdocs build
```

### Known Issues

- Dict search app does not work
- Dict viewer app does not work
- Code blocks not displaying for multiple languages
- PDF generation needs to be added
  
### Build Logs

The build logs give us many warnings that could be investigated and fixed. Categories of messages:

- The following pages exist in the docs directory, but are not included in the "nav" configuration
- "there is no such anchor on this page"
- "contains an absolute link"
- "not found among documentation files."
- "contains an unrecognized relative link"
- "does not contain an anchor"
  