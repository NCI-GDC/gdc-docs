# Birdseed

## Description ##

Birdseed is a genotyping algorithm used for the detection of single nucleotide polymorphisms (SNPs) in GDC genotyping array data harmonization.

## Overview ##

Birdseed is utilized for genotyping SNPs from microarray data. This pipeline processes raw array data, identifies SNPs, and generates genotype calls. It is specifically designed for genotyping arrays such as the Affymetrix SNP 6.0 array, providing accurate SNP detection across different sample types.

(?) needs double check as docs don't have that much info about the Birdseed

### Input

* Tumor CEL - Genotyping Array
* Normal CEL - Genotyping Array

### Output

* TSV (Data Type: Simple Germline Variation)

## References ##

1. [Copy Number Variation Analysis Pipeline](/Data/Bioinformatics_Pipelines/CNV_Pipeline/)
1. [SNP Array-Based Data](/Encyclopedia/pages/SNP_Array-Based_Data/#data-formats)

## External Links ##

* [Overview of GDC Harmonization Workflows](https://github.com/NCI-GDC/gdc-workflow-overview)
* [GDC Data Portal](https://portal.gdc.cancer.gov)

Categories: Workflow Type