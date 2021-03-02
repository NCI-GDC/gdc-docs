from setuptools import setup, find_packages

setup(name='gdc-docs',
      version='0.1',
      description='GDC docs site',
      license='Apache-2.0',
      packages=find_packages(),
      install_requires=[
        "mkdocs>=0.15.1,<1",
        "mkdocs-bootstrap>=0.1.1,<1",
        "mkdocs-bootswatch>=0.4,<1",
        "BSCodeTabs>=1",
        "Markdown<3",
        "MarkupSafe>=1.0",
      ]
)
