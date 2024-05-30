# Aliquot Ensemble Somatic Variant Merging and Masking

## Description ##

Aliquot Ensemble Somatic Variant Merging and Masking is a somatic variant calling pipeline used in GDC whole exome sequencing (WXS) and targeted sequencing harmonization.

## Overview ##

The Aliquot Ensemble Somatic Variant Merging and Masking workflow in the GDC harmonizes whole exome sequencing (WXS) and targeted sequencing data by identifying and merging somatic variants. This workflow consists of Somatic Aggregation and Masked Somatic Aggregation, which respectively generate comprehensive mutation annotation files (MAFs) and produce filtered, public-access MAFs by removing potentially identifiable germline mutation information.

### Input

* Tumor MAF - WXS or Targeted Sequencing
* Normal MAF - WXS or Targeted Sequencing

(?) question about input data formats: on the portal I see only MAF input files, in [docs](/Data/Bioinformatics_Pipelines/DNA_Seq_Variant_Calling_Pipeline/#somatic-aggregation-workflow) I see VCF for Somatic Aggregation Workflow

### Output

* MAF (Data Type: Masked Somatic Mutation, Aggregated Somatic Mutation)

## References ##

1. [DNA Seq Processing at the GDC](/Data/Bioinformatics_Pipelines/DNA_Seq_Variant_Calling_Pipeline/)
1. [Somatic Aggregation Workflow](/Data/Bioinformatics_Pipelines/DNA_Seq_Variant_Calling_Pipeline/#somatic-aggregation-workflow)
1. [Masked Somatic Aggregation Workflow ](/Data/Bioinformatics_Pipelines/DNA_Seq_Variant_Calling_Pipeline/#masked-somatic-aggregation-workflow)

## External Links ##

* [GDC Data Portal](https://portal.gdc.cancer.gov)

Categories: Workflow Type