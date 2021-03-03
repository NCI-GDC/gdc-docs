from setuptools import setup, find_packages

setup(name='gdc-docs',
      version='0.1',
      description='GDC docs site',
      license='Apache-2.0',
      packages=find_packages(),
      install_requires=[
        "mkdocs>=0.15.1,<1",
        "BSCodeTabs>=1",
      ]
)
