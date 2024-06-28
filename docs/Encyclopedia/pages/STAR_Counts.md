# STAR - Counts

## Description ##

STAR - Counts is an RNA expression pipeline used in GDC RNA-Seq harmonization.

## Overview ##

STAR - Counts is a pipeline used for to quantify RNA gene and exon expression from unharmonized or GDC harmonized data. Quantification is performed with STAR - Counts using tumor and normal alignments and generates transcriptome profiling data.

### Input

* Tumor BAM - RNA-Seq
* Normal BAM - RNA-Seq

### Output

* TSV (Data Type: Gene Expression Quantification, Splice Junction Quantification)

[![STAR Pipeline Diagram](https://docs.gdc.cancer.gov/Data/Bioinformatics_Pipelines/images/RNA-Seq-DR32_Image.png)](https://docs.gdc.cancer.gov/Data/Bioinformatics_Pipelines/images/RNA-Seq-DR32_Image.png "Click to see the full image.")

## References ##

1. [mRNA Analysis Pipeline](/Data/Bioinformatics_Pipelines/Expression_mRNA_Pipeline/)
1. [mRNA Expression Workflow](/Data/Bioinformatics_Pipelines/Expression_mRNA_Pipeline/#mrna-expression-workflow)
1. [mRNA Quantification Command Line Parameters](/Data/Bioinformatics_Pipelines/Expression_mRNA_Pipeline/#mrna-quantification-command-line-parameters)

## External Links ##

* [STAR](https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf)
* [GDC Data Portal](https://portal.gdc.cancer.gov)

Categories: Workflow Type