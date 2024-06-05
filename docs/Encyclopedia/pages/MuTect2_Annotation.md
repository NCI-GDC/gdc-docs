# MuTect2 Annotation

## Description ##

MuTect2 Annotation is a somatic mutation annotation pipeline in GDC whole exome sequencing (WXS) and targeted sequencing harmonization. 

used to annotate the mutations called in the GDC DNA-Seq pipelines.

## Overview ##

MuTect2 Annotation is a workflow in the GDC that annotates somatic variants identified by the MuTect2 variant calling pipeline. Somatic mutation annotation is performed with MuTect2 Annotation using tumor and normal alignments and generates simple nucleotide variation (SNV) data.

### Input

* Tumor VCF - WXS or Targeted Sequencing
* Normal VCF - WXS or Targeted Sequencing

### Output

* MAF (Data Type: Annotated Somatic Mutation)
* VCF (Data Type: Annotated Somatic Mutation) 

## References ##

1. [DNA-Seq Analysis Pipeline](/Data/Bioinformatics_Pipelines/DNA_Seq_Variant_Calling_Pipeline/)

## External Links ##

* [GDC Data Portal](https://portal.gdc.cancer.gov)

Categories: Workflow Type