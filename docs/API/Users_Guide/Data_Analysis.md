# Data Analysis

The GDC data analysis endpoints allow API users to programmatically explore data in the GDC using advanced filters at a gene and mutation level. Survival analysis data is also available.  

## Endpoints

The following data analysis endpoints are available from the GDC API:

|__Node__| __Endpoint__ | __Description__ |
|---|---|---|
|__Genes__| __/genes__ | Allows users to access summary information about each gene using its Ensembl ID. |
|__Gene Expression__|__/gene_expression/availability__|Allows users to retrieve the availability of gene expression data for specific cases and/or genes.|
||__/gene_expression/values__|Get gene expression values for specified cases and genes.|
||__/gene_expression/gene_selection__|Select the most variably expressed genes for a collection of cases and genes.|
|__SSMS__| __/ssms__ | Allows users to access information about each somatic mutation. For example, a `ssm` would represent the transition of C to T at position 52000 of chromosome 1. |
||__/ssms/`<ssm_id>`__|Get information about a specific ssm using a `<ssm_id>`, often supplemented with the `expand` option to show fields of interest. |
|| __/ssm_occurrences__ | A `ssm` entity as applied to a single instance (case). An example of a `ssm occurrence` would be that the transition of C to T at position 52000 of chromosome 1 occurred in patient TCGA-XX-XXXX. |
||__/ssm_occurrences/`<ssm_occurrences_id>`__|Get information about a specific ssm occurrence using a `<ssm_occurrences_id>`, often supplemented with the `expand` option to show fields of interest. |
|__CNVS__|__/cnvs__|Allows users to access data about copy number variations (cnvs). This data will be specifc to cnvs and not a specific case. |
||__/cnvs/`<cnv_id>`__|Get information about a specific copy number variation using a `<cnv_id>`, often supplemented with the `expand` option to show fields of interest. |
||__/cnvs/ids__|This endpoint will retrieve nodes that contain the queried cnv_id. This is accomplished by adding the query parameter: /cnvs/ids?query=`<cnv_id>`.|
||__/cnv_occurrences__|A `cnv` entity as applied to a single case.|
||__/cnv_occurrences/`<cnv_occurrence_id>`__|Get information about a specific copy number variation occurrence using a `<cnv_occurrence_id>`, often supplemented with the `expand` option to show fields of interest. |
||__/cnv_occurrences/ids__|This endpoint will retrieve nodes that contain the queried cnv_occurrence_id. This is accomplished by adding the query parameter: /cnv_occurrences/ids?query=`<cnv_occurrences_id>`|
|__scRNA-Seq Gene Expression__|__/scrna_seq/gene_expression__|Returns scRNA-Seq gene expression data for specific cases or files, with details about gene expression across different cell IDs.|
|__Analysis__|__/analysis/top_cases_counts_by_genes__| Returns the number of cases with a mutation in each gene listed in the gene_ids parameter for each project. Note that this endpoint cannot be used with the `format` or `fields` parameters.|
||__/analysis/top_mutated_genes_by_project__| Returns a list of genes that have the most mutations within a given project. |
||__/analysis/top_mutated_cases_by_gene__| Generates information about the cases that are most affected by mutations in a given number of genes |
||__/analysis/mutated_cases_count_by_project__| Returns counts for the number of cases that have associated `ssm` data in each project. The number of affected cases can be found under "case_with_ssm": {"doc_count": $case_count}.|
||__/analysis/survival__| Survival plots can be generated in the Data Portal for different subsets of data, based upon many query factors such as variants, disease type and projects. This endpoint can be used to programmatically retrieve the raw data to generate these plots and apply different filters to the data. (see Survival Example)|


The methods for retrieving information from these endpoints are very similar to those used for the `cases` and `files` endpoints. These methods are explored in depth in the [API Search and Retrieval](https://docs.gdc.cancer.gov/API/Users_Guide/Search_and_Retrieval/) documentation. The `_mapping` parameter can also be used with each of these endpoints to generate a list of potential fields.  For example:

`https://api.gdc.cancer.gov/ssms/_mapping`

While it is not an endpoint, the `observation` entity is featured in the visualization section of the API. The `observation` entity provides information from the MAF file, such as read depth and normal genotype, that supports the validity of the associated `ssm`. An example is demonstrated below:

=== "Shell"

    ```Shell
    curl "https://api.gdc.cancer.gov/ssms/57bb3f2e-ec05-52c2-ab02-7065b7d24849?expand=occurrence.case.observation.read_depth&pretty=true"
    ```

=== "Response"

    ```json
    {
      "data": {
        "ncbi_build": "GRCh38",
        "occurrence": [
          {
            "case": {
              "observation": [
                {
                  "read_depth": {
                    "t_ref_count": 321,
                    "t_alt_count": 14,
                    "t_depth": 335,
                    "n_depth": 115
                  }
                }
              ]
            }
          }
        ],
        "tumor_allele": "G",
        "mutation_type": "Simple Somatic Mutation",
        "end_position": 14304578,
        "reference_allele": "C",
        "ssm_id": "57bb3f2e-ec05-52c2-ab02-7065b7d24849",
        "start_position": 14304578,
        "mutation_subtype": "Single base substitution",
        "cosmic_id": null,
        "genomic_dna_change": "chr5:g.14304578C>G",
        "gene_aa_change": [
          "TRIO L229V",
          "TRIO L437V",
          "TRIO L447V",
          "TRIO L496V"
        ],
        "chromosome": "chr5"
      },
      "warnings": {}
    }
    ```

## Genes Endpoint Examples

__Example 1:__ A user would like to access information about the gene `ZMPSTE24`, which has an Ensembl gene ID of `ENSG00000084073`.  This would be accomplished by appending `ENSG00000084073` (`gene_id`) to the `genes` endpoint.

=== "Shell"

    ```Shell
    curl "https://api.gdc.cancer.gov/genes/ENSG00000084073?pretty=true"
    ```

=== "Response"

    ```json
    {
      "data": {
        "canonical_transcript_length": 3108,
        "description": "This gene encodes a member of the peptidase M48A family. The encoded protein is a zinc metalloproteinase involved in the two step post-translational proteolytic cleavage of carboxy terminal residues of farnesylated prelamin A to form mature lamin A. Mutations in this gene have been associated with mandibuloacral dysplasia and restrictive dermopathy. [provided by RefSeq, Jul 2008]",
        "cytoband": [
          "1p34.2"
        ],
        "gene_start": 40258107,
        "canonical_transcript_length_genomic": 36078,
        "gene_id": "ENSG00000084073",
        "gene_strand": 1,
        "canonical_transcript_length_cds": 1425,
        "gene_chromosome": "1",
        "synonyms": [
          "FACE-1",
          "HGPS",
          "PRO1",
          "STE24",
          "Ste24p"
        ],
        "is_cancer_gene_census": null,
        "biotype": "protein_coding",
        "gene_end": 40294184,
        "canonical_transcript_id": "ENST00000372759",
        "symbol": "ZMPSTE24",
        "name": "zinc metallopeptidase STE24"
      },
      "warnings": {}
    }
    ```

__Example 2:__ A user wants a subset of elements such as a list of coordinates for all genes on chromosome 7. The query can be filtered for only results from chromosome 7 using a JSON-formatted query that is URL-encoded.

=== "Shell"

    ```Shell
    curl "https://api.gdc.cancer.gov/genes?pretty=true&fields=gene_id,symbol,gene_start,gene_end&format=tsv&size=2000&filters=%7B%0D%0A%22op%22%3A%22in%22%2C%0D%0A%22content%22%3A%7B%0D%0A%22field%22%3A%22gene_chromosome%22%2C%0D%0A%22value%22%3A%5B%0D%0A%227%22%0D%0A%5D%0D%0A%7D%0D%0A%7D"
    ```

=== "Response"

    ```
    gene_start      gene_end        symbol  id
    28995231        29195451        CPVL    ENSG00000106066
    33014114        33062797        NT5C3A  ENSG00000122643
    143052320       143053347       OR6V1   ENSG00000225781
    100400826       100428992       ZCWPW1  ENSG00000078487
    73861159        73865893        WBSCR28 ENSG00000175877
    64862999        64864370        EEF1DP4 ENSG00000213640
    159231435       159233377       PIP5K1P2        ENSG00000229435
    141972631       141973773       TAS2R38 ENSG00000257138
    16646131        16706523        BZW2    ENSG00000136261
    149239651       149255609       ZNF212  ENSG00000170260
    57405025        57405090        MIR3147 ENSG00000266168
    130393771       130442433       CEP41   ENSG00000106477
    150800403       150805120       TMEM176A        ENSG00000002933
    93591573        93911265        GNGT1   ENSG00000127928
    117465784       117715971       CFTR    ENSG00000001626
    5879827 5886362 OCM     ENSG00000122543
    144118461       144119360       OR2A15P ENSG00000239981
    30424527        30478784        NOD1    ENSG00000106100
    137227341       137343865       PTN     ENSG00000105894
    84876554        84876956        HMGN2P11        ENSG00000232605
    107470018       107475659       GPR22   ENSG00000172209
    31330711        31330896        RP11-463M14.1   ENSG00000271027
    78017057        79453574        MAGI2   ENSG00000187391
    55736779        55739605        CICP11  ENSG00000237799
    142111749       142222324       RP11-1220K2.2   ENSG00000257743
    (truncated)
    ```

## Gene Expression Examples

### Gene Expression Availability Endpoint

The purpose of this endpoint is to retrieve the availability of gene expression data for cases, genes, or both. The availability response informs the user if gene expression data exists for each case or gene, which are specified with case and gene IDs. Gene expression data is only available for protein-coding genes.

__Example 1__: A user wants to get the availability of gene expression data for a set of cases and genes.

=== "Filter"

    ```json
    {
      "case_ids": [
        "6d4f38db-a97b-4dc0-8dc5-2ac7f2cc5e38",
        "e3b32485-b204-43a7-93a5-601408fcdf96"
      ],
      "gene_ids": [
        "ENSG00000141510",
        "ENSG00000181143"
      ]
    }
    ```

=== "Shell"

    ```json
    curl -X 'POST' \
      'https://api.gdc.cancer.gov/gene_expression/availability' \
      -H 'accept: application/json' \
      -H 'Content-Type: application/json' \
      -d '{
      "case_ids": [
        "6d4f38db-a97b-4dc0-8dc5-2ac7f2cc5e38",
        "e3b32485-b204-43a7-93a5-601408fcdf96"
      ],
      "gene_ids": [
        "ENSG00000141510",
        "ENSG00000181143"
      ]
    }'
    ```

=== "Response"

    ```json
    {
        "cases": {
            "details": [
                {
                    "case_id": "6d4f38db-a97b-4dc0-8dc5-2ac7f2cc5e38",
                    "has_gene_expression_values": false
                },
                {
                    "case_id": "e3b32485-b204-43a7-93a5-601408fcdf96",
                    "has_gene_expression_values": true
                }
            ],
            "with_gene_expression_count": 1,
            "without_gene_expression_count": 1
        },
        "genes": {
            "details": [
                {
                    "gene_id": "ENSG00000141510",
                    "has_gene_expression_values": true
                },
                {
                    "gene_id": "ENSG00000181143",
                    "has_gene_expression_values": true
                }
            ],
            "with_gene_expression_count": 2,
            "without_gene_expression_count": 0
        }
    }
    ```

### Gene Expression Values Endpoint

The purpose of this endpoint is to retrieve the gene expression values for the given cases and genes. The response is a TSV containing the expression values for genes to cases.
The `tsv_units` of gene expression data must be defined by exactly one of the following:

* `uqfpkm` - FPKM-UQ values. More information on calculations can be found [here](/Data/Bioinformatics_Pipelines/Expression_mRNA_Pipeline/#calculations).
* `median_centered_log2_uqfpkm` - Median-centered log2(FPKM-UQ+1) values.

The `median_centered_log2_uqfpkm` is calculated through the following steps:

1. Calculate the Median: Determine the median of all provided log2(uqfpkm + 1) values.
1. Compute Median-Centered Values: Subtract the median from each log2(uqfpkm + 1) value.
1. Generate the Result Sequence: Create a new sequence with the median-centered values, preserving the original order.

__Example 1__: A user wants to get expression values using case IDs and gene IDs.

=== "Filter"

    ```json
    {
        "case_ids": [
            "6d4f38db-a97b-4dc0-8dc5-2ac7f2cc5e38",
            "e3b32485-b204-43a7-93a5-601408fcdf96",
            "000ead0d-abf5-4606-be04-1ea31b999840",
            "001ab32d-f924-4753-ad67-4366fb845ae6"
        ],
        "gene_ids": [
            "ENSG00000141510",
            "ENSG00000181143"
        ],
        "tsv_units": "median_centered_log2_uqfpkm",
        "format": "tsv"
    }
    ```

=== "Shell"

    ```shell
    curl -X 'POST' \
      'https://api.gdc.cancer.gov/gene_expression/values' \
      -H 'accept: text/tab-separated-values' \
      -H 'Content-Type: application/json' \
      -d '{
        "case_ids": [
            "6d4f38db-a97b-4dc0-8dc5-2ac7f2cc5e38",
            "e3b32485-b204-43a7-93a5-601408fcdf96",
            "000ead0d-abf5-4606-be04-1ea31b999840",
            "001ab32d-f924-4753-ad67-4366fb845ae6"
        ],
        "gene_ids": [
            "ENSG00000141510",
            "ENSG00000181143"
        ],
        "tsv_units": "median_centered_log2_uqfpkm",
        "format": "tsv"
    }'
    ```

=== "Response"

    ```
    gene_id	000ead0d-abf5-4606-be04-1ea31b999840	001ab32d-f924-4753-ad67-4366fb845ae6	e3b32485-b204-43a7-93a5-601408fcdf96
    ENSG00000141510	-0.58248	1.75830	0.00000
    ENSG00000181143	-0.02529	0.00000	3.52293
    ```

### Gene Expression Gene Selection Endpoint

Select the most variably expressed genes for a collection of cases and collection of genes. The request must define a collection of cases, a collection of genes, and a selection size. A minimum expression value may optionally be defined.

A collection of cases must be defined by case IDs.

A collection of genes must be defined by exactly one of the following:

* `gene_ids`
* `gene_type` which has only one value: `protein_coding`.

A selection size (`selection_size`) defines the maximum number of genes to select.

An optional threshold (`min_median_log2_uqfpkm`) defines a minimum value for expression. Defaults to `1`.

__Example 1__: A user wants to get the most variably expressed genes for a list of case UUIDs and a list of Ensembl gene IDs.

=== "Filter"

    ```json
    {
        "case_ids": [
            "000ead0d-abf5-4606-be04-1ea31b999840",
            "001ab32d-f924-4753-ad67-4366fb845ae6",
            "0024c94c-88ff-49d9-8dc4-bf77f832d85e",
            "003f4f85-3244-4132-8c9d-c29f09382269",
            "005d0639-c923-470f-a179-02a4dbb5cdf2",
            "006931bb-f5b1-4aa4-b0a8-af517a912db0",
            "0084e8b6-57fc-48b6-aa77-fec6e45161d2",
            "008d3744-e7f0-41a5-a419-702960cf1ccb",
            "0094e07c-1595-402e-9d38-68b9cac71e7b",
            "00bd58bd-223d-433e-b60a-5bf355f342b1"
        ],
        "gene_ids": [
            "ENSG00000141510",
            "ENSG00000181143"
        ],
        "selection_size": 1
    }
    ```

=== "Shell"

    ```shell
    curl -X 'POST' \
      'https://api.gdc.cancer.gov/gene_expression/gene_selection' \
      -H 'accept: application/json' \
      -H 'Content-Type: application/json' \
      -d '{
        "case_ids": [
            "000ead0d-abf5-4606-be04-1ea31b999840",
            "001ab32d-f924-4753-ad67-4366fb845ae6",
            "0024c94c-88ff-49d9-8dc4-bf77f832d85e",
            "003f4f85-3244-4132-8c9d-c29f09382269",
            "005d0639-c923-470f-a179-02a4dbb5cdf2",
            "006931bb-f5b1-4aa4-b0a8-af517a912db0",
            "0084e8b6-57fc-48b6-aa77-fec6e45161d2",
            "008d3744-e7f0-41a5-a419-702960cf1ccb",
            "0094e07c-1595-402e-9d38-68b9cac71e7b",
            "00bd58bd-223d-433e-b60a-5bf355f342b1"
        ],
        "gene_ids": [
            "ENSG00000141510",
            "ENSG00000181143"
        ],
        "selection_size": 1
    }'
    ```

=== "Response"

    ```json
    {
        "gene_selection": [
            {
                "log2_uqfpkm_stddev": 0.9962971125913709,
                "log2_uqfpkm_median": 2.904457107848132,
                "gene_id": "ENSG00000141510",
                "symbol": "TP53"
            }
        ]
    }
    ```

## Simple Somatic Mutation Endpoint Examples

__Example 1__: Similar to the `/genes` endpoint, a user would like to retrieve information about the mutation based on its COSMIC ID. This would be accomplished by creating a JSON filter, which will then be encoded to URL for the `curl` command.

=== "Filter"

    ```json
     {
       "op":"in",
       "content":{
          "field":"cosmic_id",
          "value":[
             "COSM1135366"
          ]
       }
    }
    ```

=== "Shell"

    ```Shell
    curl 'https://api.gdc.cancer.gov/ssms?pretty=true&filters=%7B%0A%22op%22%3A%22in%22%2C%0A%22content%22%3A%7B%0A%22field%22%3A%22cosmic_id%22%2C%0A%2value%22%3A%5B%0A%22COSM1135366%22%0A%5D%0A%7D%0A%7D%0A'
    ```

=== "Response"

    ```json
    {
      "data": {
        "hits": [
          {
            "id": "edd1ae2c-3ca9-52bd-a124-b09ed304fcc2",
            "start_position": 25245350,
            "gene_aa_change": [
              "KRAS G12D"
            ],
            "reference_allele": "C",
            "ncbi_build": "GRCh38",
            "cosmic_id": [
              "COSM1135366",
              "COSM521"
            ],
            "mutation_subtype": "Single base substitution",
            "mutation_type": "Simple Somatic Mutation",
            "chromosome": "chr12",
            "ssm_id": "edd1ae2c-3ca9-52bd-a124-b09ed304fcc2",
            "genomic_dna_change": "chr12:g.25245350C>T",
            "tumor_allele": "T",
            "end_position": 25245350
          }
        ],
        "pagination": {
          "count": 1,
          "total": 1,
          "size": 10,
          "from": 0,
          "sort": "",
          "page": 1,
          "pages": 1
        }
      },
      "warnings": {}
    }
    ```

__Example 2:__ Based on the previous example's `ssm_id` (`8b3c1a7a-e4e0-5200-9d46-5767c2982145`), a user would like to look at the consequences and the VEP impact due to this ssm.

=== "Shell"

    ```Shell
    curl 'https://api.gdc.cancer.gov/ssms/edd1ae2c-3ca9-52bd-a124-b09ed304fcc2?pretty=true&expand=consequence.transcript&fields=consequence.transcript.annotation.vep_impact'
    ```

=== "JSON"

    ```JSON
    {
      "data": {
        "consequence": [
          {
            "transcript": {
              "annotation": {
                "vep_impact": "MODERATE"
              },
              "transcript_id": "ENST00000557334",
              "aa_end": 12,
              "consequence_type": "missense_variant",
              "aa_start": 12,
              "is_canonical": false,
              "aa_change": "G12D",
              "ref_seq_accession": ""
            }
          },
          {
            "transcript": {
              "annotation": {
                "vep_impact": "MODERATE"
              },
              "transcript_id": "ENST00000256078",
              "aa_end": 12,
              "consequence_type": "missense_variant",
              "aa_start": 12,
              "is_canonical": true,
              "aa_change": "G12D",
              "ref_seq_accession": "NM_001369786.1&NM_033360.4"
            }
          },
          {
            "transcript": {
              "annotation": {
                "vep_impact": "MODERATE"
              },
              "transcript_id": "ENST00000311936",
              "aa_end": 12,
              "consequence_type": "missense_variant",
              "aa_start": 12,
              "is_canonical": false,
              "aa_change": "G12D",
              "ref_seq_accession": "NM_001369787.1&NM_004985.5"
            }
          },
          {
            "transcript": {
              "annotation": {
                "vep_impact": "MODERATE"
              },
              "transcript_id": "ENST00000556131",
              "aa_end": 12,
              "consequence_type": "missense_variant",
              "aa_start": 12,
              "is_canonical": false,
              "aa_change": "G12D",
              "ref_seq_accession": ""
            }
          }
        ]
      },
      "warnings": {}
    }
    ```

## Simple Somatic Mutation Occurrence Endpoint Examples

__Example 1:__ A user wants to determine the chromosome in case `TCGA-DU-6407` that contains the greatest number of `ssms`. As this relates to mutations that are observed in a case, the `ssm_occurrences` endpoint is used.

=== "Filter"

    ```json
    {  
       "op":"in",
       "content":{  
          "field":"case.submitter_id",
          "value":["TCGA-DU-6407"]
       }
    }
    ```

=== "Shell"

    ```Shell
    curl "https://api.gdc.cancer.gov/ssm_occurrences?format=tsv&fields=ssm.chromosome&size=5000&filters=%7B%0D%0A%22op%22%3A%22in%22%2C%0D%0A%22content%22%3A%7B%0D%0A%22field%22%3A%22case.submitter_id%22%2C%0D%0A%22value%22%3A%5B%0D%0A%22TCGA-DU-6407%22%0D%0A%5D%0D%0A%7D%0D%0A%7D"
    ```

=== "Tsv"

    ```tsv
    id	ssm.chromosome
    105e7811-4601-5ccb-ae93-e7107923599e	chr16
    faee73a9-4804-58ea-a91f-18c3d901774f	chr2
    99b3aad4-d368-506d-99d6-047cbe5dff0f	chr2
    2cb06277-993e-5502-b2c5-263037c45d18	chr10
    f08dcc53-eadc-5ceb-bf31-f6b38629e4cb	chr19
    97c5b38b-fc96-57f5-8517-cc702b3aa70a	chr6
    19ca262d-b354-54a0-b582-c4719e37e91d	chrX
    b4822fc9-f0cc-56fd-9d97-f916234e309d	chr2
    22a07c7c-16ba-51df-a9a9-1e41e2a45225	chrX
    0010a89d-9434-5d97-8672-36ee394767d0	chr17
    3a023e72-da92-54f7-aa18-502c1076b2b0	chr5
    391011ff-c1fd-5e2a-a128-652bc660f64c	chr10
    3548ecfe-5186-51e7-8f40-37f4654cd260	chr2
    b67f31b5-0341-518e-8fcc-811cd2e36af1	chr3
    4a93d7a5-988d-5055-80da-999dc3b45d80	chr1
    9dc3f7cd-9efa-530a-8524-30d067e49d54	chr13
    552c09d1-69b1-5c04-b543-524a6feae3eb	chr3
    dbc5eafa-ea26-5f1c-946c-b6974a345b69	chr12
    d25129ad-3ad7-584f-bdeb-fba5c3881d32	chr17
    1378cbc4-af88-55bb-b2e5-185bb4246d7a	chr10
    c44a93a1-5c73-5cff-b40e-98ce7e5fe57b	chr19
    1267330b-ae6d-5e25-b19e-34e98523679e	chr21
    1476a543-2951-5ec4-b165-67551b47d810	chr17
    727c9d57-7b74-556f-aa5b-e1ca1f76d119	chr10
    94abd5fd-d539-5a4a-8719-9615cf7cec5d	chr1
    a76469cb-973c-5d4d-bf82-7cf4e8f6c129	chr17
    ```

__Example 2:__ A user has retrieved a `ssm_occurrence`, and would like to determine if that case also has diagnostic information.

=== "Shell"

    ```Shell
    curl 'https://api.gdc.cancer.gov/ssm_occurrences/6fd8527d-5c40-5604-8fa9-0ce798eec231?pretty=true&expand=case.diagnoses'
    ```

=== "Json"

    ```Json
    {
      "data": {
        "ssm_occurrence_id": "6fd8527d-5c40-5604-8fa9-0ce798eec231",
        "case": {
          "diagnoses": [
            {
              "ajcc_pathologic_t": "T3b",
              "synchronous_malignancy": "No",
              "morphology": "8720/3",
              "ajcc_pathologic_stage": "Stage IIB",
              "ajcc_pathologic_n": "N0",
              "ajcc_pathologic_m": "M0",
              "submitter_id": "TCGA-Z2-A8RT_diagnosis",
              "days_to_diagnosis": 0,
              "last_known_disease_status": "not reported",
              "tissue_or_organ_of_origin": "Skin, NOS",
              "days_to_last_follow_up": 839.0,
              "age_at_diagnosis": 15342,
              "primary_diagnosis": "Malignant melanoma, NOS",
              "classification_of_tumor": "not reported",
              "prior_malignancy": "no",
              "year_of_diagnosis": 2012,
              "diagnosis_id": "1d06a202-c51a-52e2-805f-eeb5f7fac14e",
              "icd_10_code": "C44.6",
              "site_of_resection_or_biopsy": "Skin of upper limb and shoulder",
              "prior_treatment": "No",
              "state": "released",
              "tumor_grade": "Not Reported",
              "progression_or_recurrence": "not reported",
              "ajcc_staging_system_edition": "7th"
            }
          ]
        }
      },
      "warnings": {}
    }
    ```

## Copy Number Variation Endpoint Examples

__Example 1:__ A user is interested in finding the first 30 cnvs found on chromosome 4 that have a cnv loss.

=== "Filter"

    ```json
    {
        "op": "and",
        "content": [
            {
                "op": "in",
                "content": {
                    "field": "chromosome",
                    "value": [
                        "4"
                    ]
                }
            },
            {
                "op": "in",
                "content": {
                    "field": "cnv_change",
                    "value": [
                        "Loss"
                    ]
                }
            }
        ]
    }
    ```

=== "Shell"

    ```Shell
    curl 'https://api.gdc.cancer.gov/cnvs?filters=%7B%0D%0A+++%22op%22%3A+%22and%22%2C%0D%0A++++%22content%22%3A+%5B%0D%0A++++++++%7B%0D%0A++++++++++++%22op%22%3A+%22in%22%2C%0D%0A++++++++++++%22content%22%3A+%7B%0D%0A++++++++++++++++%22field%22%3A+%22chromosome%22%2C%0D%0A++++++++++++++++%22value%22%3A+%5B%0D%0A++++++++++++++++++++%224%22%0D%0A++++++++++++++++%5D%0D%0A++++++++++++%7D%0D%0A++++++++%7D%2C%0D%0A++++++++%7B%0D%0A++++++++++++%22op%22%3A+%22in%22%2C%0D%0A++++++++++++%22content%22%3A+%7B%0D%0A++++++++++++++++%22field%22%3A+%22cnv_change%22%2C%0D%0A++++++++++++++++%22value%22%3A+%5B%0D%0A++++++++++++++++++++%22Loss%22%0D%0A++++++++++++++++%5D%0D%0A++++++++++++%7D%0D%0A++++++++%7D%0D%0A++++%5D%0D%0A%7D&size=30&sort=start_position&format=tsv'
    ```

=== "Tsv"

    ```tsv
    chromosome	cnv_change	cnv_change_5_category	cnv_id	end_position	gene_level_cn	id	ncbi_build	start_position
    4	Loss	Loss	11381600-f064-5c42-90d2-a5c79c8b23e1	88208	True	11381600-f064-5c42-90d2-a5c79c8b23e1	GRCh38	53286
    4	Loss	Homozygous Deletion	8884174a-1a74-5fec-af2a-1abd816c4022	88208	True	8884174a-1a74-5fec-af2a-1abd816c4022	GRCh38	53286
    4	Loss	Homozygous Deletion	1dc3143b-99d8-5d9b-80a4-84a4e8967b37	202303	True	1dc3143b-99d8-5d9b-80a4-84a4e8967b37	GRCh38	124501
    4	Loss	Loss	edef0f2f-c1a7-507c-842f-e1f8a568df9d	202303	True	edef0f2f-c1a7-507c-842f-e1f8a568df9d	GRCh38	124501
    4	Loss	Loss	eba92f9a-b045-54a8-948a-451e439ed418	305474	True	eba92f9a-b045-54a8-948a-451e439ed418	GRCh38	270675
    4	Loss	Homozygous Deletion	1d656e18-64c3-51c1-856f-eba2a2bb4214	305474	True	1d656e18-64c3-51c1-856f-eba2a2bb4214	GRCh38	270675
    4	Loss	Loss	89319453-2a3f-5ebe-be30-8af0426e0343	384868	True	89319453-2a3f-5ebe-be30-8af0426e0343	GRCh38	337814
    4	Loss	Homozygous Deletion	a392d072-2650-5c7f-b3a6-d325680d87fb	384868	True	a392d072-2650-5c7f-b3a6-d325680d87fb	GRCh38	337814
    4	Loss	Homozygous Deletion	653d70d7-07fa-5b5a-8961-ba031060e33a	499156	True	653d70d7-07fa-5b5a-8961-ba031060e33a	GRCh38	425815
    4	Loss	Loss	6567929c-4b6f-582b-aedf-acde2c0ec736	499156	True	6567929c-4b6f-582b-aedf-acde2c0ec736	GRCh38	425815
    4	Loss	Loss	2daff58b-5065-50cd-8239-253180eaee81	540200	True	2daff58b-5065-50cd-8239-253180eaee81	GRCh38	499210
    4	Loss	Homozygous Deletion	a793c3d6-805b-531e-86fc-0b92eb3b8d98	540200	True	a793c3d6-805b-531e-86fc-0b92eb3b8d98	GRCh38	499210
    4	Loss	Loss	2b42c8d4-6d85-5352-96e1-9e52e722c248	576295	True	2b42c8d4-6d85-5352-96e1-9e52e722c248	GRCh38	573880
    4	Loss	Homozygous Deletion	6a7256cb-f674-58e1-8359-13045f0e5abc	576295	True	6a7256cb-f674-58e1-8359-13045f0e5abc	GRCh38	573880
    4	Loss	Homozygous Deletion	a055b2b3-8135-509c-b870-ef7ab693d394	670782	True	a055b2b3-8135-509c-b870-ef7ab693d394	GRCh38	625573
    4	Loss	Loss	2646cdc7-7602-59a4-ae4f-d171352bae88	670782	True	2646cdc7-7602-59a4-ae4f-d171352bae88	GRCh38	625573
    4	Loss	Loss	c11ad392-949f-593f-a3ab-d834b2f82809	674330	True	c11ad392-949f-593f-a3ab-d834b2f82809	GRCh38	672436
    4	Loss	Homozygous Deletion	b98c4b26-6c62-5a89-931a-bba7f882083e	674330	True	b98c4b26-6c62-5a89-931a-bba7f882083e	GRCh38	672436
    4	Loss	Loss	f31be658-4de0-549e-81be-e79759879acf	682033	True	f31be658-4de0-549e-81be-e79759879acf	GRCh38	673580
    4	Loss	Homozygous Deletion	efb72922-c8ee-51bd-9340-b6c24cf0e120	682033	True	efb72922-c8ee-51bd-9340-b6c24cf0e120	GRCh38	673580
    4	Loss	Homozygous Deletion	f7e8f2a0-50ba-57b7-9604-109de3832a0d	689271	True	f7e8f2a0-50ba-57b7-9604-109de3832a0d	GRCh38	681829
    4	Loss	Loss	d72c62f2-fc29-5b83-9839-7f6b03970aff	689271	True	d72c62f2-fc29-5b83-9839-7f6b03970aff	GRCh38	681829
    4	Loss	Loss	45448d47-6e13-5d30-824d-96150a7f55c6	770640	True	45448d47-6e13-5d30-824d-96150a7f55c6	GRCh38	705748
    4	Loss	Homozygous Deletion	8f439ea0-b792-5d31-a457-f01ead7351d4	770640	True	8f439ea0-b792-5d31-a457-f01ead7351d4	GRCh38	705748
    4	Loss	Loss	517e65ea-9084-54c2-abe0-b1b47e9f872c	826129	True	517e65ea-9084-54c2-abe0-b1b47e9f872c	GRCh38	784957
    4	Loss	Homozygous Deletion	c73f54a7-6c75-51c8-b9ee-9a0f9e649eca	826129	True	c73f54a7-6c75-51c8-b9ee-9a0f9e649eca	GRCh38	784957
    4	Loss	Homozygous Deletion	f7fa174c-2c9b-5462-b807-a1f6d18b1320	932373	True	f7fa174c-2c9b-5462-b807-a1f6d18b1320	GRCh38	849276
    4	Loss	Loss	b5a09c9b-d842-5b76-a500-56f18252c29d	932373	True	b5a09c9b-d842-5b76-a500-56f18252c29d	GRCh38	849276
    4	Loss	Homozygous Deletion	3b7a64d1-f4d2-5186-ba74-07483d5f53c1	958656	True	3b7a64d1-f4d2-5186-ba74-07483d5f53c1	GRCh38	932387
    4	Loss	Loss	e3a3b61d-2881-5ad4-90bf-58ef29ae9ecb	958656	True	e3a3b61d-2881-5ad4-90bf-58ef29ae9ecb	GRCh38	932387
    ```

__Example 2:__ A user is interested in finding the first 30 cnvs found on chromosome 4 that have cnv homozygous deletions only.

=== "Filter"

    ```json
    {
        "op": "and",
        "content": [
            {
                "op": "in",
                "content": {
                    "field": "chromosome",
                    "value": [
                        "4"
                    ]
                }
            },
            {
                "op": "in",
                "content": {
                    "field": "cnv_change_5_category",
                    "value": [
                        "Homozygous Deletion"
                    ]
                }
            }
        ]
    }
    ```

=== "Shell"

    ```Shell
    curl 'https://api.gdc.cancer.gov/cnvs?filters=%7B%0A%20%20%20%20%20%20%20%20%22op%22%3A%20%22and%22%2C%0A%20%20%20%20%20%20%20%20%22content%22%3A%20%5B%0A%20%20%20%20%20%20%20%20%20%20%20%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22op%22%3A%20%22in%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22content%22%3A%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22field%22%3A%20%22chromosome%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22value%22%3A%20%5B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%224%22%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%5D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20%20%20%20%20%7D%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22op%22%3A%20%22in%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22content%22%3A%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22field%22%3A%20%22cnv_change_5_category%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22value%22%3A%20%5B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22Homozygous%20Deletion%22%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%5D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20%5D%0A%20%20%20%20%7D&size=30&sort=start_position&format=tsv'
    ```

=== "Tsv"

    ```tsv
    chromosome	cnv_change	cnv_change_5_category	cnv_id	end_position	gene_level_cn	id	ncbi_build	start_position
    4	Loss	Homozygous Deletion	8884174a-1a74-5fec-af2a-1abd816c4022	88208	True	8884174a-1a74-5fec-af2a-1abd816c4022	GRCh38	53286
    4	Loss	Homozygous Deletion	1dc3143b-99d8-5d9b-80a4-84a4e8967b37	202303	True	1dc3143b-99d8-5d9b-80a4-84a4e8967b37	GRCh38	124501
    4	Loss	Homozygous Deletion	1d656e18-64c3-51c1-856f-eba2a2bb4214	305474	True	1d656e18-64c3-51c1-856f-eba2a2bb4214	GRCh38	270675
    4	Loss	Homozygous Deletion	a392d072-2650-5c7f-b3a6-d325680d87fb	384868	True	a392d072-2650-5c7f-b3a6-d325680d87fb	GRCh38	337814
    4	Loss	Homozygous Deletion	653d70d7-07fa-5b5a-8961-ba031060e33a	499156	True	653d70d7-07fa-5b5a-8961-ba031060e33a	GRCh38	425815
    4	Loss	Homozygous Deletion	a793c3d6-805b-531e-86fc-0b92eb3b8d98	540200	True	a793c3d6-805b-531e-86fc-0b92eb3b8d98	GRCh38	499210
    4	Loss	Homozygous Deletion	6a7256cb-f674-58e1-8359-13045f0e5abc	576295	True	6a7256cb-f674-58e1-8359-13045f0e5abc	GRCh38	573880
    4	Loss	Homozygous Deletion	a055b2b3-8135-509c-b870-ef7ab693d394	670782	True	a055b2b3-8135-509c-b870-ef7ab693d394	GRCh38	625573
    4	Loss	Homozygous Deletion	b98c4b26-6c62-5a89-931a-bba7f882083e	674330	True	b98c4b26-6c62-5a89-931a-bba7f882083e	GRCh38	672436
    4	Loss	Homozygous Deletion	efb72922-c8ee-51bd-9340-b6c24cf0e120	682033	True	efb72922-c8ee-51bd-9340-b6c24cf0e120	GRCh38	673580
    4	Loss	Homozygous Deletion	f7e8f2a0-50ba-57b7-9604-109de3832a0d	689271	True	f7e8f2a0-50ba-57b7-9604-109de3832a0d	GRCh38	681829
    4	Loss	Homozygous Deletion	8f439ea0-b792-5d31-a457-f01ead7351d4	770640	True	8f439ea0-b792-5d31-a457-f01ead7351d4	GRCh38	705748
    4	Loss	Homozygous Deletion	c73f54a7-6c75-51c8-b9ee-9a0f9e649eca	826129	True	c73f54a7-6c75-51c8-b9ee-9a0f9e649eca	GRCh38	784957
    4	Loss	Homozygous Deletion	f7fa174c-2c9b-5462-b807-a1f6d18b1320	932373	True	f7fa174c-2c9b-5462-b807-a1f6d18b1320	GRCh38	849276
    4	Loss	Homozygous Deletion	3b7a64d1-f4d2-5186-ba74-07483d5f53c1	958656	True	3b7a64d1-f4d2-5186-ba74-07483d5f53c1	GRCh38	932387
    4	Loss	Homozygous Deletion	a7457adc-31d0-5b5e-9fb2-53ff26f354ce	986895	True	a7457adc-31d0-5b5e-9fb2-53ff26f354ce	GRCh38	958887
    4	Loss	Homozygous Deletion	30d664ec-c0b6-5283-9342-5af09a882a05	993440	True	30d664ec-c0b6-5283-9342-5af09a882a05	GRCh38	979073
    4	Loss	Homozygous Deletion	88373fd0-771d-5ee2-870c-8b38b469b386	1004564	True	88373fd0-771d-5ee2-870c-8b38b469b386	GRCh38	986997
    4	Loss	Homozygous Deletion	282251fd-8556-5b32-b285-c63b58662263	1026898	True	282251fd-8556-5b32-b285-c63b58662263	GRCh38	1009936
    4	Loss	Homozygous Deletion	71480086-ef38-5ddb-a10b-e5165d207846	1113564	True	71480086-ef38-5ddb-a10b-e5165d207846	GRCh38	1056250
    4	Loss	Homozygous Deletion	2a87f0ba-7cda-51e6-914d-acc6ab42e4ce	1208962	True	2a87f0ba-7cda-51e6-914d-acc6ab42e4ce	GRCh38	1166932
    4	Loss	Homozygous Deletion	99897d07-d376-559b-8bf5-5361467a3b11	1249953	True	99897d07-d376-559b-8bf5-5361467a3b11	GRCh38	1211445
    4	Loss	Homozygous Deletion	71980ad9-0561-5b17-8fa8-1c0280940a98	1340147	True	71980ad9-0561-5b17-8fa8-1c0280940a98	GRCh38	1289887
    4	Loss	Homozygous Deletion	dc6f0cde-beb2-5b67-b279-66d993e4072b	1395989	True	dc6f0cde-beb2-5b67-b279-66d993e4072b	GRCh38	1345691
    4	Loss	Homozygous Deletion	3897b742-1fb0-59af-94a3-468f414954bb	1406442	True	3897b742-1fb0-59af-94a3-468f414954bb	GRCh38	1402932
    4	Loss	Homozygous Deletion	35cdeb0b-9fb6-5d5c-9474-e94dc3d95dce	1684261	True	35cdeb0b-9fb6-5d5c-9474-e94dc3d95dce	GRCh38	1617915
    4	Loss	Homozygous Deletion	3237ca12-ab72-5278-a57e-21ebfee6a408	1712344	True	3237ca12-ab72-5278-a57e-21ebfee6a408	GRCh38	1692731
    4	Loss	Homozygous Deletion	60664ffe-8c48-5f2b-bc6f-71408c876794	1745171	True	60664ffe-8c48-5f2b-bc6f-71408c876794	GRCh38	1712891
    4	Loss	Homozygous Deletion	967a8cd6-6b29-5a93-ab4d-7aa7cf696716	1721358	True	967a8cd6-6b29-5a93-ab4d-7aa7cf696716	GRCh38	1715952
    4	Loss	Homozygous Deletion	6846f70b-8327-555a-8486-f7036906465e	1808872	True	6846f70b-8327-555a-8486-f7036906465e	GRCh38	1793293
    ```

__Example 3:__ A user wants to determine the location and identity of the gene affected by the cnv `544c4896-0152-5787-8d77-894a16f0ded0`, and determine whether the gene is found within the Cancer Gene Census.

=== "Shell"

    ```Shell
    curl 'https://api.gdc.cancer.gov/cnvs/544c4896-0152-5787-8d77-894a16f0ded0?pretty=true&expand=consequence.gene'
    ```

=== "Json" 

    ```Json
    {
      "data": {
        "start_position": 27100354,
        "consequence": [
          {
            "gene": {
              "biotype": "protein_coding",
              "symbol": "HOXA2",
              "gene_id": "ENSG00000105996"
            }
          }
        ],
        "gene_level_cn": true,
        "cnv_change": "Gain",
        "ncbi_build": "GRCh38",
        "chromosome": "7",
        "cnv_id": "544c4896-0152-5787-8d77-894a16f0ded0",
        "end_position": 27102686
      },
      "warnings": {}
    }
    ```

## Copy Number Variation Occurrence Endpoint Examples

__Example 1:__ A user is interested in finding cases that have both cnv and ssm data for females diagnosed with Squamous Cell Neoplasms and have a cnv gain change on chromosome 9. It is important to note that for a case like this, where multiple arguments are need for one filtered field, it is easier for the API to have multiple filters for the same field, `case.available_variation_data` in this example, than having one filter with multiple arguments.

=== "Filter"

    ```json
    {
        "op": "and",
        "content": [
            {
                "op": "in",
                "content": {
                    "field": "cnv.cnv_change",
                    "value": [
                        "Gain"
                    ]
                }
            },
            {
                "op": "in",
                "content": {
                    "field": "case.demographic.gender",
                    "value": [
                        "female"
                    ]
                }
            },
            {
                "op": "in",
                "content": {
                    "field": "case.available_variation_data",
                    "value": [
                        "cnv"
                    ]
                }
            },
            {
                "op": "in",
                "content": {
                    "field": "case.available_variation_data",
                    "value": [
                        "ssm"
                    ]
                }
            },
            {
                "op": "in",
                "content": {
                    "field": "cnv.chromosome",
                    "value": [
                        "9"
                    ]
                }
            },
            {
                "op": "in",
                "content": {
                    "field": "case.disease_type",
                    "value": [
                        "Squamous Cell Neoplasms"
                    ]
                }
            }
        ]
    }

    ```
=== "Shell"

    ```shell
    curl 'https://api.gdc.cancer.gov/cnv_occurrences?filters=%7B%0D%0A++++%22op%22%3A+%22and%22%2C%0D%0A++++%22content%22%3A+%5B%0D%0A++++++++%7B%0D%0A++++++++++++%22op%22%3A+%22in%22%2C%0D%0A++++++++++++%22content%22%3A+%7B%0D%0A++++++++++++++++%22field%22%3A+%22cnv.cnv_change%22%2C%0D%0A++++++++++++++++%22value%22%3A+%5B%0D%0A++++++++++++++++++++%22Gain%22%0D%0A++++++++++++++++%5D%0D%0A++++++++++++%7D%0D%0A++++++++%7D%2C%0D%0A++++++++%7B%0D%0A++++++++++++%22op%22%3A+%22in%22%2C%0D%0A++++++++++++%22content%22%3A+%7B%0D%0A++++++++++++++++%22field%22%3A+%22case.demographic.gender%22%2C%0D%0A++++++++++++++++%22value%22%3A+%5B%0D%0A++++++++++++++++++++%22female%22%0D%0A++++++++++++++++%5D%0D%0A++++++++++++%7D%0D%0A++++++++%7D%2C%0D%0A++++++++%7B%0D%0A++++++++++++%22op%22%3A+%22in%22%2C%0D%0A++++++++++++%22content%22%3A+%7B%0D%0A++++++++++++++++%22field%22%3A+%22case.available_variation_data%22%2C%0D%0A++++++++++++++++%22value%22%3A+%5B%0D%0A++++++++++++++++++++%22cnv%22%0D%0A++++++++++++++++%5D%0D%0A++++++++++++%7D%0D%0A++++++++%7D%2C%0D%0A++++++++%7B%0D%0A++++++++++++%22op%22%3A+%22in%22%2C%0D%0A++++++++++++%22content%22%3A+%7B%0D%0A++++++++++++++++%22field%22%3A+%22case.available_variation_data%22%2C%0D%0A++++++++++++++++%22value%22%3A+%5B%0D%0A++++++++++++++++++++%22ssm%22%0D%0A++++++++++++++++%5D%0D%0A++++++++++++%7D%0D%0A++++++++%7D%2C%0D%0A++++++++%7B%0D%0A++++++++++++%22op%22%3A+%22in%22%2C%0D%0A++++++++++++%22content%22%3A+%7B%0D%0A++++++++++++++++%22field%22%3A+%22cnv.chromosome%22%2C%0D%0A++++++++++++++++%22value%22%3A+%5B%0D%0A++++++++++++++++++++%229%22%0D%0A++++++++++++++++%5D%0D%0A++++++++++++%7D%0D%0A++++++++%7D%2C%0D%0A++++++++%7B%0D%0A++++++++++++%22op%22%3A+%22in%22%2C%0D%0A++++++++++++%22content%22%3A+%7B%0D%0A++++++++++++++++%22field%22%3A+%22case.disease_type%22%2C%0D%0A++++++++++++++++%22value%22%3A+%5B%0D%0A++++++++++++++++++++%22Squamous+Cell+Neoplasms%22%0D%0A++++++++++++++++%5D%0D%0A++++++++++++%7D%0D%0A++++++++%7D%0D%0A++++%5D%0D%0A%7D&fields=case.available_variation_data,case.case_id&format=tsv'
    ```

=== "Tsv"

    ```tsv
    case.available_variation_data.0	case.available_variation_data.1	case.case_id	id
    cnv	ssm	da30a845-c4d3-4c78-b8b0-210239224f8f	3caf6e3b-024f-57b6-bdd9-3b67e423cc11
    cnv	ssm	0809ba8b-4ab6-4f43-934c-c1ccbc014a7e	e6afe58e-c99c-5c8d-920e-8ba4daad4d89
    cnv	ssm	8e0e456e-85ee-4de5-8f0b-72393d6acde0	9d983d9c-8320-53f1-9054-e46926c5b834
    cnv	ssm	64a195f6-2212-4e81-bccc-e39c77a10908	8caeaecc-ad68-539d-8b3c-8320b3684763
    cnv	ssm	2f6a0e87-1e6c-41f3-93e0-3e505fa654b0	4862c166-0f37-5e3c-ae4e-a2964de01cea
    cnv	ssm	f0daf315-8909-4cda-886d-a2770b08db94	099ff6cd-bd28-56f4-a181-6b02f3ba7503
    cnv	ssm	ff3808e4-eece-4046-819b-fe1019317f8e	0c936aa2-393e-5463-a431-3613b4510021
    cnv	ssm	9205dc07-93f5-4b5e-924e-8e097616160f	133d27a7-fdc6-5082-a1f3-022b89f4e851
    cnv	ssm	79ae5209-f476-4d65-a6c0-ebc18d7c8942	7a5e6bb1-8af3-5964-a3cc-c53602c8b099
    cnv	ssm	ff7099e1-8ff9-48e4-842d-46e98076e7e6	fb27fa8f-aa31-5e20-84da-8f45bb675405
    ```

__Example 2:__ A user is interested in the first cnv occurrence (`3b9f7ecc-2280-5b89-80f9-ec8d6c5e604e`) from the previous example, and would like to know more about the case exposures and demographics.

=== "Shell"

    ```Shell
    curl 'https://api.gdc.cancer.gov/cnv_occurrences/3b9f7ecc-2280-5b89-80f9-ec8d6c5e604e?pretty=true&expand=cnv,case,case.exposures,case.demographic'
    ```

=== "Json"

    ```Json
    {
      "data": {
        "cnv": {
          "start_position": 68815994,
          "gene_level_cn": true,
          "cnv_change": "Gain",
          "ncbi_build": "GRCh38",
          "chromosome": "4",
          "variant_status": "Tumor Only",
          "cnv_id": "1a889109-30d5-51e3-848f-9f615c69f407",
          "end_position": 68832023
        },
        "cnv_occurrence_id": "3b9f7ecc-2280-5b89-80f9-ec8d6c5e604e",
        "case": {
          "exposures": [
            {
              "cigarettes_per_day": 5.47945205479452,
              "alcohol_history": "Not Reported",
              "exposure_id": "f7b08a8e-d22b-5cb0-be9f-b922c9ca87d2",
              "submitter_id": "TCGA-38-4629_exposure",
              "state": "released",
              "pack_years_smoked": 100.0
            }
          ],
          "primary_site": "Bronchus and lung",
          "disease_type": "Adenomas and Adenocarcinomas",
          "available_variation_data": [
            "cnv",
            "ssm"
          ],
          "case_id": "127bf818-f7e5-46b5-a9de-39f6d96b8b83",
          "submitter_id": "TCGA-38-4629",
          "state": "released",
          "demographic": {
            "demographic_id": "9ea1f795-9510-5acc-a9a5-bf1379e6635a",
            "ethnicity": "not hispanic or latino",
            "gender": "male",
            "race": "white",
            "vital_status": "Dead",
            "age_at_index": 68,
            "submitter_id": "TCGA-38-4629_demographic",
            "days_to_death": 864,
            "days_to_birth": -25104,
            "state": "released",
            "year_of_death": 2005,
            "year_of_birth": 1935
          }
        }
      },
      "warnings": {}
    }
    ```

__Example 3:__ A user is interested in finding cases that have cnv data for males diagnosed with gliomas and have a cnv amplification on chromosome 7.

=== "Filter"

    ```json
    {
        "op": "and",
        "content": [
            {
                "op": "in",
                "content": {
                    "field": "cnv.cnv_change_5_category",
                    "value": [
                        "Amplification"
                    ]
                }
            },
            {
                "op": "in",
                "content": {
                    "field": "case.demographic.gender",
                    "value": [
                        "male"
                    ]
                }
            },
            {
                "op": "in",
                "content": {
                    "field": "case.available_variation_data",
                    "value": [
                        "cnv"
                    ]
                }
            },
            {
                "op": "in",
                "content": {
                    "field": "cnv.chromosome",
                    "value": [
                        "7"
                    ]
                }
            },
            {
                "op": "in",
                "content": {
                    "field": "case.disease_type",
                    "value": [
                        "Gliomas"
                    ]
                }
            }
        ]
    }

    ```
=== "Shell"

    ```shell
    curl 'https://api.gdc.cancer.gov/cnv_occurrences?filters=%7B%0A%20%20%20%20%20%20%20%20%22op%22%3A%20%22and%22%2C%0A%20%20%20%20%20%20%20%20%22content%22%3A%20%5B%0A%20%20%20%20%20%20%20%20%20%20%20%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22op%22%3A%20%22in%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22content%22%3A%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22field%22%3A%20%22cnv.cnv_change_5_category%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22value%22%3A%20%5B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22Amplification%22%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%5D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20%20%20%20%20%7D%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22op%22%3A%20%22in%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22content%22%3A%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22field%22%3A%20%22case.demographic.gender%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22value%22%3A%20%5B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22male%22%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%5D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20%20%20%20%20%7D%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22op%22%3A%20%22in%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22content%22%3A%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22field%22%3A%20%22case.available_variation_data%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22value%22%3A%20%5B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22cnv%22%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%5D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20%20%20%20%20%7D%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22op%22%3A%20%22in%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22content%22%3A%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22field%22%3A%20%22cnv.chromosome%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22value%22%3A%20%5B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%227%22%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%5D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20%20%20%20%20%7D%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22op%22%3A%20%22in%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22content%22%3A%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22field%22%3A%20%22case.disease_type%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22value%22%3A%20%5B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22Gliomas%22%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%5D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20%5D%0A%20%20%20%20%7D&fields=case.available_variation_data,case.case_id&format=tsv'
    ```

=== "Tsv"

    ```tsv
    case.available_variation_data.0	case.available_variation_data.1	case.case_id	id
    cnv	ssm	a1da2f64-5a24-4e6b-abc1-e70aae23082c	15bbf08b-6d6a-5c1d-bd94-1e86710ce29a
    cnv	ssm	2e3b9f32-304e-454b-ac2c-fc72d2ccaa19	c9ff4332-959e-5e68-a305-29ae7f898a67
    cnv		0133e584-111e-450a-b451-77a2799ef529	7d6ca206-7c41-5f3e-89d5-69106d3262cb
    cnv	ssm	50603cc6-42e6-412f-ab07-4805f728e6b6	eccbd36c-93a3-5644-aa30-6b06d66ac35b
    cnv		372a4cc6-8fc9-4157-9cdc-fe020b176249	ea64dfc0-d297-5686-bcfc-3336201e7c01
    cnv	ssm	92f323c8-dae4-4fdc-a108-148ddc238d1a	4b07a619-ad6f-5169-af7f-3360cc2a8845
    cnv	ssm	e349d8aa-bb82-4ce8-b14c-61216289f25b	4ae6c613-92be-5424-a5d6-305deb5b3cac
    cnv	ssm	6c5154d2-af36-492f-b520-d925528824e4	dcf8e315-e868-5dc2-8ca0-5f76d4f7e5ee
    cnv	ssm	fbb0dc0d-6314-40ea-bc43-0cbf3b710dbe	504fd9f6-dc90-55c4-abf0-68ab38e17f61
    cnv	ssm	7cada85b-00b1-41e5-9924-e09eb077ad56	1e6f552a-78ed-5ce7-bef9-a55670c979db
    ```

## scRNA-Seq Gene Expression Endpoints

This endpoint retrieves gene expression data for a specified case or file, returning information about gene expression across various cell IDs. It requires specifying either a `case_id` or `file_id`, but not both, and a list of gene IDs. Only one gene can be queried per request. The data is stored in HDF5 files.

The request must adhere to authorization requirements if accessing protected data, using an authentication token (`X-Auth-Token`) acquired from the user profile after logging in at the [GDC Portal](https://portal.gdc.cancer.gov/). The `X-Auth-Token` header is optional and only needed for accessing restricted datasets.

__Example 1:__ A user wants to retrieve scRNA-Seq gene expression data for a specific case. They want to query the expression levels of the gene identified by `ENSG00000139618` across different cell IDs.

=== "Filter"

    ```json
    {
      "case_id": "00a29522-5eb0-4dbe-ae63-875aba3bf1b1",
      "gene_ids": [
        "ENSG00000139618"
      ]
    }
    ```
=== "Shell"

    ```shell
    curl --location 'https://api.gdc.cancer.gov/scrna_seq/gene_expression' \
    --header 'Content-Type: application/json' \
    --header 'Accept: application/json' \
    --data '{
      "case_id": "00a29522-5eb0-4dbe-ae63-875aba3bf1b1",
      "gene_ids": [
        "ENSG00000139618"
      ]
    }' 
    ```

=== "Response"

    ```json
    {
      "data": [
        {
          "case_id": "00a29522-5eb0-4dbe-ae63-875aba3bf1b1",
          "file_id": "2a095c71-d5ba-4a8a-bacc-2391b52d8328",
          "gene_id": "ENSG00000139618",
          "cells": [
            {
              "cell_id": "AAACCCAAGCAATTAG-1",
              "value": 0
            },
            {
              "cell_id": "AAACCCAAGCCATTCA-1",
              "value": 0
            },
            {
              "cell_id": "AAACCCAAGTGGAAAG-1",
              "value": 3
            },
            {
              "cell_id": "AAACCCACAACGGTAG-1",
              "value": 0
            },
            {
              "cell_id": "AAACCCACATCGCTCT-1",
              "value": 0
            },
            {
              "cell_id": "AAACCCAGTTAGAAAC-1",
              "value": 0
            },
            {
              "cell_id": "AAACCCATCAAGCTGT-1",
              "value": 0
            },
            {
              "cell_id": "AAACCCATCGACACTA-1",
              "value": 0
            },
            {
              "cell_id": "AAACCCATCTCCCATG-1",
              "value": 0
            },
            {
              "cell_id": "AAACGAAAGACTCTAC-1",
              "value": 0
            },
            {
              "cell_id": "AAACGAACACGGTCTG-1",
              "value": 1
            },
            {
              "cell_id": "AAACGAAGTATCCTTT-1",
              "value": 0
            },
            {
              "cell_id": "AAACGAAGTGATTCTG-1",
              "value": 1
            },
            {
              "cell_id": "AAACGAAGTGGACTGA-1",
              "value": 0
            }
          ],
          "errors": []
        }
      ]
    }
    ```

__Example 2:__ A researcher wants to analyze the gene expression data associated with a specific file from a sequencing experiment. To perform this analysis, they query the expression levels of the gene identified by `ENSG00000139618` across different cell IDs using the file ID `c8ea9c15-368d-460c-9775-5037a5f1790a`.

=== "Filter"

    ```json
    {
      "file_id": "c8ea9c15-368d-460c-9775-5037a5f1790a",
      "gene_ids": [
        "ENSG00000139618"
      ]
    }
    ```

=== "Shell"

    ```shell
    curl --location 'https://api.gdc.cancer.gov/scrna_seq/gene_expression' \
    --header 'Content-Type: application/json' \
    --header 'Accept: application/json' \
    --data '{
      "file_id": "c8ea9c15-368d-460c-9775-5037a5f1790a",
      "gene_ids": [
        "ENSG00000139618"
      ]
    }' 
    ```

=== "Response"

    ```json
    {
      "data": [
        {
          "case_id": "aa7502a9-5ffe-48c1-a1a8-3b07e83f78d7",
          "file_id": "c8ea9c15-368d-460c-9775-5037a5f1790a",
          "gene_id": "ENSG00000139618",
          "cells": [
            {
              "cell_id": "AAACCCACAAGGTCAG-1",
              "value": 0
            },
            {
              "cell_id": "AAACCCACACGACGAA-1",
              "value": 0
            },
            {
              "cell_id": "AAACCCACACGGGTAA-1",
              "value": 0
            },
            {
              "cell_id": "AAACCCACAGCGGTCT-1",
              "value": 0
            },
            {
              "cell_id": "AAACCCATCGCGTGCA-1",
              "value": 0
            },
            {
              "cell_id": "AAACGAACAAATCAGA-1",
              "value": 2
            },
            {
              "cell_id": "AAACGAACACTTGTGA-1",
              "value": 0
            },
            {
              "cell_id": "AAACGAACATAACGGG-1",
              "value": 0
            },
            {
              "cell_id": "AAACGAACATCTTAGG-1",
              "value": 0
            },
            {
              "cell_id": "AAACGAAGTATCGATC-1",
              "value": 0
            },
            {
              "cell_id": "AAACGAAGTGTGATGG-1",
              "value": 0
            },
            {
              "cell_id": "AAACGAATCCGTACGG-1",
              "value": 0
            },
            {
              "cell_id": "AAACGAATCCTGGCTT-1",
              "value": 0
            },
            {
              "cell_id": "AAACGAATCTATGTGG-1",
              "value": 0
            },
            {
              "cell_id": "AAACGAATCTCAACGA-1",
              "value": 1
            },
            {
              "cell_id": "AAACGAATCTTGATTC-1",
              "value": 0
            },
            {
              "cell_id": "AAACGCTAGACGACGT-1",
              "value": 0
            },
            {
              "cell_id": "AAACGCTAGCCTTTCC-1",
              "value": 0
            },
            {
              "cell_id": "AAACGCTAGCTGTTAC-1",
              "value": 0
            },
            {
              "cell_id": "AAACGCTAGTATGTAG-1",
              "value": 0
            }
          ],
          "errors": []
        }
      ]
    }
    ```

## Analysis Endpoints

In addition to the `ssms`, `ssm_occurrences`, and `genes` endpoints mentioned previously, several `/analysis` endpoints were designed to quickly retrieve specific datasets used for visualization display.  

__Example 1:__ The `/analysis/top_cases_counts_by_genes` endpoint gives the number of cases with a mutation in each gene listed in the `gene_ids` parameter for each project. Note that this endpoint cannot be used with the `format` or `fields` parameters. In this instance, the query will produce the number of cases in each projects with mutations in the gene `ENSG00000155657`.

```Shell
curl "https://api.gdc.cancer.gov/analysis/top_cases_counts_by_genes?gene_ids=ENSG00000155657&pretty=true"
```


This JSON-formatted output is broken up by project. For an example, see the following text:

```json
$ curl "https://api.gdc.cancer.gov/analysis/top_cases_counts_by_genes?gene_ids=ENSG00000155657&pretty=true"
{
  "took": 6,
  "timed_out": false,
  "_shards": {
    "total": 12,
    "successful": 12,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 5967,
      "relation": "eq"
    },
    "max_score": null,
    "hits": []
  },
  "aggregations": {
    "projects": {
      "doc_count_error_upper_bound": 0,
      "sum_other_doc_count": 0,
      "buckets": [
        {
          "key": "TCGA-BRCA",
          "doc_count": 425,
          "genes": {
            "doc_count": 4031450,
            "my_genes": {
              "doc_count": 425,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 425
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-LUSC",
          "doc_count": 423,
          "genes": {
            "doc_count": 4123089,
            "my_genes": {
              "doc_count": 423,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 423
                  }
                ]
              }
            }
          }
        },
        {
          "key": "CPTAC-3",
          "doc_count": 421,
          "genes": {
            "doc_count": 251552,
            "my_genes": {
              "doc_count": 421,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 421
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-SKCM",
          "doc_count": 391,
          "genes": {
            "doc_count": 3040929,
            "my_genes": {
              "doc_count": 391,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 391
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-LUAD",
          "doc_count": 345,
          "genes": {
            "doc_count": 3188761,
            "my_genes": {
              "doc_count": 345,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 345
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-OV",
          "doc_count": 341,
          "genes": {
            "doc_count": 3728561,
            "my_genes": {
              "doc_count": 341,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 341
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-STAD",
          "doc_count": 300,
          "genes": {
            "doc_count": 2145783,
            "my_genes": {
              "doc_count": 300,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 300
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-UCEC",
          "doc_count": 297,
          "genes": {
            "doc_count": 1637055,
            "my_genes": {
              "doc_count": 297,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 297
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-HNSC",
          "doc_count": 293,
          "genes": {
            "doc_count": 2325617,
            "my_genes": {
              "doc_count": 293,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 293
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-COAD",
          "doc_count": 288,
          "genes": {
            "doc_count": 1695280,
            "my_genes": {
              "doc_count": 288,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 288
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-BLCA",
          "doc_count": 280,
          "genes": {
            "doc_count": 2466835,
            "my_genes": {
              "doc_count": 280,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 280
                  }
                ]
              }
            }
          }
        },
        {
          "key": "MMRF-COMMPASS",
          "doc_count": 181,
          "genes": {
            "doc_count": 45977,
            "my_genes": {
              "doc_count": 181,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 181
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-LIHC",
          "doc_count": 167,
          "genes": {
            "doc_count": 1216775,
            "my_genes": {
              "doc_count": 167,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 167
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-CESC",
          "doc_count": 161,
          "genes": {
            "doc_count": 1103281,
            "my_genes": {
              "doc_count": 161,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 161
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-KIRC",
          "doc_count": 161,
          "genes": {
            "doc_count": 842546,
            "my_genes": {
              "doc_count": 161,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 161
                  }
                ]
              }
            }
          }
        },
        {
          "key": "CPTAC-2",
          "doc_count": 131,
          "genes": {
            "doc_count": 72575,
            "my_genes": {
              "doc_count": 131,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 131
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-GBM",
          "doc_count": 131,
          "genes": {
            "doc_count": 756809,
            "my_genes": {
              "doc_count": 131,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 131
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-ESCA",
          "doc_count": 129,
          "genes": {
            "doc_count": 1210888,
            "my_genes": {
              "doc_count": 129,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 129
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-PRAD",
          "doc_count": 101,
          "genes": {
            "doc_count": 379949,
            "my_genes": {
              "doc_count": 101,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 101
                  }
                ]
              }
            }
          }
        },
        {
          "key": "HCMI-CMDC",
          "doc_count": 99,
          "genes": {
            "doc_count": 54829,
            "my_genes": {
              "doc_count": 99,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 99
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-READ",
          "doc_count": 98,
          "genes": {
            "doc_count": 726313,
            "my_genes": {
              "doc_count": 98,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 98
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-LGG",
          "doc_count": 95,
          "genes": {
            "doc_count": 424689,
            "my_genes": {
              "doc_count": 95,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 95
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-KIRP",
          "doc_count": 93,
          "genes": {
            "doc_count": 521936,
            "my_genes": {
              "doc_count": 93,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 93
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-SARC",
          "doc_count": 93,
          "genes": {
            "doc_count": 903111,
            "my_genes": {
              "doc_count": 93,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 93
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-TGCT",
          "doc_count": 51,
          "genes": {
            "doc_count": 524456,
            "my_genes": {
              "doc_count": 51,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 51
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TARGET-ALL-P2",
          "doc_count": 50,
          "genes": {
            "doc_count": 1882,
            "my_genes": {
              "doc_count": 50,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 50
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-KICH",
          "doc_count": 43,
          "genes": {
            "doc_count": 353674,
            "my_genes": {
              "doc_count": 43,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 43
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-PAAD",
          "doc_count": 43,
          "genes": {
            "doc_count": 300427,
            "my_genes": {
              "doc_count": 43,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 43
                  }
                ]
              }
            }
          }
        },
        {
          "key": "CGCI-HTMCP-CC",
          "doc_count": 37,
          "genes": {
            "doc_count": 3606,
            "my_genes": {
              "doc_count": 37,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 37
                  }
                ]
              }
            }
          }
        },
        {
          "key": "CDDP_EAGLE-1",
          "doc_count": 32,
          "genes": {
            "doc_count": 16980,
            "my_genes": {
              "doc_count": 32,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 32
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-ACC",
          "doc_count": 29,
          "genes": {
            "doc_count": 283969,
            "my_genes": {
              "doc_count": 29,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 29
                  }
                ]
              }
            }
          }
        },
        {
          "key": "CMI-MBC",
          "doc_count": 28,
          "genes": {
            "doc_count": 3581,
            "my_genes": {
              "doc_count": 28,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 28
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-THCA",
          "doc_count": 28,
          "genes": {
            "doc_count": 89120,
            "my_genes": {
              "doc_count": 28,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 28
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-UCS",
          "doc_count": 28,
          "genes": {
            "doc_count": 283673,
            "my_genes": {
              "doc_count": 28,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 28
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-MESO",
          "doc_count": 21,
          "genes": {
            "doc_count": 137002,
            "my_genes": {
              "doc_count": 21,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 21
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-PCPG",
          "doc_count": 19,
          "genes": {
            "doc_count": 99444,
            "my_genes": {
              "doc_count": 19,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 19
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TARGET-NBL",
          "doc_count": 15,
          "genes": {
            "doc_count": 829,
            "my_genes": {
              "doc_count": 15,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 15
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-UVM",
          "doc_count": 12,
          "genes": {
            "doc_count": 68201,
            "my_genes": {
              "doc_count": 12,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 12
                  }
                ]
              }
            }
          }
        },
        {
          "key": "EXCEPTIONAL_RESPONDERS-ER",
          "doc_count": 11,
          "genes": {
            "doc_count": 10617,
            "my_genes": {
              "doc_count": 11,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 11
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-THYM",
          "doc_count": 11,
          "genes": {
            "doc_count": 59647,
            "my_genes": {
              "doc_count": 11,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 11
                  }
                ]
              }
            }
          }
        },
        {
          "key": "BEATAML1.0-COHORT",
          "doc_count": 10,
          "genes": {
            "doc_count": 279,
            "my_genes": {
              "doc_count": 10,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 10
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TARGET-OS",
          "doc_count": 10,
          "genes": {
            "doc_count": 414,
            "my_genes": {
              "doc_count": 10,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 10
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-LAML",
          "doc_count": 10,
          "genes": {
            "doc_count": 10175,
            "my_genes": {
              "doc_count": 10,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 10
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-DLBC",
          "doc_count": 9,
          "genes": {
            "doc_count": 63497,
            "my_genes": {
              "doc_count": 9,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 9
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TCGA-CHOL",
          "doc_count": 8,
          "genes": {
            "doc_count": 52960,
            "my_genes": {
              "doc_count": 8,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 8
                  }
                ]
              }
            }
          }
        },
        {
          "key": "CMI-MPC",
          "doc_count": 7,
          "genes": {
            "doc_count": 365,
            "my_genes": {
              "doc_count": 7,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 7
                  }
                ]
              }
            }
          }
        },
        {
          "key": "CMI-ASC",
          "doc_count": 6,
          "genes": {
            "doc_count": 5745,
            "my_genes": {
              "doc_count": 6,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 6
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TARGET-WT",
          "doc_count": 3,
          "genes": {
            "doc_count": 51,
            "my_genes": {
              "doc_count": 3,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 3
                  }
                ]
              }
            }
          }
        },
        {
          "key": "TARGET-ALL-P3",
          "doc_count": 2,
          "genes": {
            "doc_count": 66,
            "my_genes": {
              "doc_count": 2,
              "gene_id": {
                "doc_count_error_upper_bound": 0,
                "sum_other_doc_count": 0,
                "buckets": [
                  {
                    "key": "ENSG00000155657",
                    "doc_count": 2
                  }
                ]
              }
            }
          }
        }
      ]
    }
  }

```

This portion of the output shows TCGA-GBM including 45 cases that have `ssms` in the gene `ENSG00000155657`.

__Example 2:__ The following demonstrates a use of the `/analysis/top_mutated_genes_by_project` endpoint.  This will output the genes that are mutated in the most cases in "TCGA-DLBC" and will count the mutations that have a `HIGH` or `MODERATE` impact on gene function. Note that the `score` field does not represent the number of mutations in a given gene, but a calculation that is used to determine which genes have the greatest number of unique mutations.  

=== "Json"

    ```json
    {  
       "op":"AND",
       "content":[  
          {  
             "op":"in",
             "content":{  
                "field":"case.project.project_id",
                "value":[  
                   "TCGA-DLBC"
                ]
             }
          },
          {  
             "op":"in",
             "content":{  
                "field":"case.ssm.consequence.transcript.annotation.vep_impact",
                "value":[  
                   "HIGH",
                   "MODERATE"
                ]
             }
          }
       ]
    }
    ```

=== "Shell"

    ```Shell
    curl "https://api.gdc.cancer.gov/analysis/top_mutated_genes_by_project?fields=gene_id,symbol&filters=%7B%20%20%0A%20%20%20%22op%22%3A%22AND%20%20%20%22content%22%3A%5B%20%20%0A%20%20%20%20%20%20%7B%20%20%0A%20%20%20%20%20%20%20%20%20%22op%22%3A%22in%22%2C%0A%20%20%20%20%20%20%20%20%20%22content%22%3A%7B%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%22field%22%3A%22case.project.project_id%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%22value%22%3A%5B%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22TCGA-DLBC%22%0A%20%20%20%20%20%20%20%20%20%20%20%20%5D%0A%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%7D%2C%0A%20%20%20%20%20%20%7B%20%20%0A%20%20%20%20%20%20%20%20%20%22op%22%3A%22in%22%2C%0A%20%20%20%20%20%20%20%20%20%22content%22%3A%7B%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%22field%22%3A%22case.ssm.consequence.transcript.annotation.vep_impact%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%22value%22%3A%5B%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22HIGH%22%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22MODERATE%22%0A%20%20%20%20%20%20%20%20%20%20%20%20%5D%0A%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%7D%0A%20%20%20%5D%0A%7D%0A&pretty=true"
    ```

=== "Response"

    ```json
    {
      "data": {
        "hits": [
          {
            "symbol": "KMT2D",
            "gene_id": "ENSG00000167548",
            "_score": 13.0
          },
          {
            "symbol": "BTG2",
            "gene_id": "ENSG00000159388",
            "_score": 13.0
          },
          {
            "symbol": "B2M",
            "gene_id": "ENSG00000166710",
            "_score": 11.0
          },
          {
            "symbol": "PIM1",
            "gene_id": "ENSG00000137193",
            "_score": 10.0
          },
          {
            "symbol": "IGHG1",
            "gene_id": "ENSG00000211896",
            "_score": 10.0
          },
          {
            "symbol": "CARD11",
            "gene_id": "ENSG00000198286",
            "_score": 10.0
          },
          {
            "symbol": "H1-4",
            "gene_id": "ENSG00000168298",
            "_score": 9.0
          },
          {
            "symbol": "PCLO",
            "gene_id": "ENSG00000186472",
            "_score": 9.0
          },
          {
            "symbol": "IGHG2",
            "gene_id": "ENSG00000211893",
            "_score": 9.0
          },
          {
            "symbol": "FAT4",
            "gene_id": "ENSG00000196159",
            "_score": 8.0
          }
        ],
        "pagination": {
          "count": 10,
          "total": 3500,
          "size": 10,
          "from": 0,
          "sort": "None",
          "page": 1,
          "pages": 350
        }
      },
      "warnings": {}
    }
    ```

__Example 3:__ The `/analysis/top_mutated_cases_by_gene` endpoint will generate information about the cases that are most affected by mutations in a given number of genes. Below, the file count for each category is given for the cases most affected by mutations in these 50 genes.  The size of the output is limited to two cases with the `size=2` parameter, but a higher value can be set by the user.

=== "Shell"

    ```Shell
    curl "https://api.gdc.cancer.gov/analysis/top_mutated_cases_by_gene?fields=diagnoses.age_at_diagnosis,diagnoses.primary_diagnosis,demographic.gender,demographic.race,demographic.ethnicity,case_id,summary.data_categories.file_count,summary.data_categories.data_category&filters=%7B%22op%22%3A%22and%22%2C%22content%22%3A%5B%7B%22op%22%3A%22%3D%22%2C%22content%22%3A%7B%22field%22%3A%22cases.project.project_id%22%2C%22value%22%3A%22TCGA-DLBC%22%7D%7D%2C%7B%22op%22%3A%22in%22%2C%22content%22%3A%7B%22field%22%3A%22genes.gene_id%22%2C%22value%22%3A%5B%22ENSG00000166710%22%2C%22ENSG00000005339%22%2C%22ENSG00000083857%22%2C%22ENSG00000168769%22%2C%22ENSG00000100906%22%2C%22ENSG00000184677%22%2C%22ENSG00000101680%22%2C%22ENSG00000101266%22%2C%22ENSG00000028277%22%2C%22ENSG00000140968%22%2C%22ENSG00000181827%22%2C%22ENSG00000116815%22%2C%22ENSG00000275221%22%2C%22ENSG00000139083%22%2C%22ENSG00000112851%22%2C%22ENSG00000112697%22%2C%22ENSG00000164134%22%2C%22ENSG00000009413%22%2C%22ENSG00000071626%22%2C%22ENSG00000135407%22%2C%22ENSG00000101825%22%2C%22ENSG00000104814%22%2C%22ENSG00000166415%22%2C%22ENSG00000142867%22%2C%22ENSG00000254585%22%2C%22ENSG00000139718%22%2C%22ENSG00000077721%22%2C%22ENSG00000130294%22%2C%22ENSG00000117245%22%2C%22ENSG00000117318%22%2C%22ENSG00000270550%22%2C%22ENSG00000163637%22%2C%22ENSG00000166575%22%2C%22ENSG00000065526%22%2C%22ENSG00000156453%22%2C%22ENSG00000128191%22%2C%22ENSG00000055609%22%2C%22ENSG00000204469%22%2C%22ENSG00000187605%22%2C%22ENSG00000185875%22%2C%22ENSG00000110888%22%2C%22ENSG00000007341%22%2C%22ENSG00000173198%22%2C%22ENSG00000115568%22%2C%22ENSG00000163714%22%2C%22ENSG00000125772%22%2C%22ENSG00000080815%22%2C%22ENSG00000189079%22%2C%22ENSG00000120837%22%2C%22ENSG00000143951%22%5D%7D%7D%2C%7B%22op%22%3A%22in%22%2C%22content%22%3A%7B%22field%22%3A%22ssms.consequence.transcript.annotation.vep_impact%22%2C%22value%22%3A%5B%22HIGH%22%5D%7D%7D%5D%7D&pretty=true&size=2"
    ```

=== "Response"

    ```json
    {
      "data": {
        "hits": [
          {
            "summary": {
              "data_categories": [
                {
                  "file_count": 6,
                  "data_category": "Sequencing Reads"
                },
                {
                  "file_count": 14,
                  "data_category": "Biospecimen"
                },
                {
                  "file_count": 8,
                  "data_category": "Copy Number Variation"
                },
                {
                  "file_count": 16,
                  "data_category": "Simple Nucleotide Variation"
                },
                {
                  "file_count": 4,
                  "data_category": "Transcriptome Profiling"
                },
                {
                  "file_count": 3,
                  "data_category": "DNA Methylation"
                },
                {
                  "file_count": 8,
                  "data_category": "Clinical"
                },
                {
                  "file_count": 4,
                  "data_category": "Structural Variation"
                },
                {
                  "file_count": 1,
                  "data_category": "Proteome Profiling"
                }
              ]
            },
            "case_id": "eda9496e-be80-4a13-bf06-89f0cc9e937f",
            "diagnoses": [
              {
                "age_at_diagnosis": 18691,
                "primary_diagnosis": "Malignant lymphoma, large B-cell, diffuse, NOS"
              }
            ],
            "demographic": {
              "ethnicity": "hispanic or latino",
              "gender": "male",
              "race": "white"
            },
            "_score": 7.0
          },
          {
            "summary": {
              "data_categories": [
                {
                  "file_count": 4,
                  "data_category": "Sequencing Reads"
                },
                {
                  "file_count": 13,
                  "data_category": "Biospecimen"
                },
                {
                  "file_count": 8,
                  "data_category": "Copy Number Variation"
                },
                {
                  "file_count": 16,
                  "data_category": "Simple Nucleotide Variation"
                },
                {
                  "file_count": 2,
                  "data_category": "Transcriptome Profiling"
                },
                {
                  "file_count": 3,
                  "data_category": "DNA Methylation"
                },
                {
                  "file_count": 8,
                  "data_category": "Clinical"
                },
                {
                  "file_count": 4,
                  "data_category": "Structural Variation"
                }
              ]
            },
            "case_id": "7a589441-11ef-4158-87e7-3951d86bc2aa",
            "diagnoses": [
              {
                "age_at_diagnosis": 20812,
                "primary_diagnosis": "Malignant lymphoma, large B-cell, diffuse, NOS"
              }
            ],
            "demographic": {
              "ethnicity": "not hispanic or latino",
              "gender": "female",
              "race": "white"
            },
            "_score": 4.0
          }
        ],
        "pagination": {
          "count": 2,
          "total": 32,
          "size": 2,
          "from": 0,
          "sort": "None",
          "page": 1,
          "pages": 16
        }
      },
      "warnings": {}
    }
    ```

__Example 4:__  The `/analysis/mutated_cases_count_by_project` endpoint produces counts for the number of cases that have associated `ssm` data in each project. The number of affected cases can be found under `"case_with_ssm": {"doc_count": $case_count}`.  

=== "Shell"

    ```Shell
    curl "https://api.gdc.cancer.gov/analysis/mutated_cases_count_by_project?size=0&pretty=true"
    ```

=== "Response"

    ```json
    {
      "took": 9,
      "timed_out": false,
      "_shards": {
        "total": 12,
        "successful": 12,
        "skipped": 0,
        "failed": 0
      },
      "hits": {
        "total": {
          "value": 44451,
          "relation": "eq"
        },
        "max_score": null,
        "hits": []
      },
      "aggregations": {
        "projects": {
          "doc_count_error_upper_bound": 0,
          "sum_other_doc_count": 0,
          "buckets": [
            {
              "key": "FM-AD",
              "doc_count": 18004,
              "case_summary": {
                "doc_count": 54012,
                "case_with_ssm": {
                  "doc_count": 18004
                }
              }
            },
            {
              "key": "TARGET-AML",
              "doc_count": 2492,
              "case_summary": {
                "doc_count": 10780,
                "case_with_ssm": {
                  "doc_count": 22
                }
              }
            },
            {
              "key": "TARGET-ALL-P2",
              "doc_count": 1587,
              "case_summary": {
                "doc_count": 5562,
                "case_with_ssm": {
                  "doc_count": 717
                }
              }
            },
            {
              "key": "MP2PRT-ALL",
              "doc_count": 1510,
              "case_summary": {
                "doc_count": 10472,
                "case_with_ssm": {
                  "doc_count": 1508
                }
              }
            },
            {
              "key": "CPTAC-3",
              "doc_count": 1235,
              "case_summary": {
                "doc_count": 8508,
                "case_with_ssm": {
                  "doc_count": 1218
                }
              }
            },
            {
              "key": "TARGET-NBL",
              "doc_count": 1132,
              "case_summary": {
                "doc_count": 3007,
                "case_with_ssm": {
                  "doc_count": 220
                }
              }
            },
            {
              "key": "TCGA-BRCA",
              "doc_count": 1098,
              "case_summary": {
                "doc_count": 9735,
                "case_with_ssm": {
                  "doc_count": 1098
                }
              }
            },
            {
              "key": "MMRF-COMMPASS",
              "doc_count": 995,
              "case_summary": {
                "doc_count": 3528,
                "case_with_ssm": {
                  "doc_count": 959
                }
              }
            },
            {
              "key": "BEATAML1.0-COHORT",
              "doc_count": 826,
              "case_summary": {
                "doc_count": 2891,
                "case_with_ssm": {
                  "doc_count": 759
                }
              }
            },
            {
              "key": "TARGET-WT",
              "doc_count": 652,
              "case_summary": {
                "doc_count": 3045,
                "case_with_ssm": {
                  "doc_count": 631
                }
              }
            },
            {
              "key": "TCGA-GBM",
              "doc_count": 617,
              "case_summary": {
                "doc_count": 3867,
                "case_with_ssm": {
                  "doc_count": 600
                }
              }
            },
            {
              "key": "TCGA-OV",
              "doc_count": 608,
              "case_summary": {
                "doc_count": 5028,
                "case_with_ssm": {
                  "doc_count": 599
                }
              }
            },
            {
              "key": "TCGA-LUAD",
              "doc_count": 585,
              "case_summary": {
                "doc_count": 4825,
                "case_with_ssm": {
                  "doc_count": 571
                }
              }
            },
            {
              "key": "TCGA-UCEC",
              "doc_count": 560,
              "case_summary": {
                "doc_count": 4559,
                "case_with_ssm": {
                  "doc_count": 559
                }
              }
            },
            {
              "key": "TCGA-KIRC",
              "doc_count": 537,
              "case_summary": {
                "doc_count": 4768,
                "case_with_ssm": {
                  "doc_count": 534
                }
              }
            },
            {
              "key": "TCGA-HNSC",
              "doc_count": 528,
              "case_summary": {
                "doc_count": 4577,
                "case_with_ssm": {
                  "doc_count": 528
                }
              }
            },
            {
              "key": "TCGA-LGG",
              "doc_count": 516,
              "case_summary": {
                "doc_count": 4570,
                "case_with_ssm": {
                  "doc_count": 516
                }
              }
            },
            {
              "key": "TCGA-THCA",
              "doc_count": 507,
              "case_summary": {
                "doc_count": 4442,
                "case_with_ssm": {
                  "doc_count": 507
                }
              }
            },
            {
              "key": "TCGA-LUSC",
              "doc_count": 504,
              "case_summary": {
                "doc_count": 4425,
                "case_with_ssm": {
                  "doc_count": 504
                }
              }
            },
            {
              "key": "TCGA-PRAD",
              "doc_count": 500,
              "case_summary": {
                "doc_count": 4365,
                "case_with_ssm": {
                  "doc_count": 500
                }
              }
            },
            {
              "key": "NCICCR-DLBCL",
              "doc_count": 489,
              "case_summary": {
                "doc_count": 1451,
                "case_with_ssm": {
                  "doc_count": 0
                }
              }
            },
            {
              "key": "TCGA-SKCM",
              "doc_count": 470,
              "case_summary": {
                "doc_count": 4125,
                "case_with_ssm": {
                  "doc_count": 470
                }
              }
            },
            {
              "key": "TCGA-COAD",
              "doc_count": 461,
              "case_summary": {
                "doc_count": 3888,
                "case_with_ssm": {
                  "doc_count": 461
                }
              }
            },
            {
              "key": "TCGA-STAD",
              "doc_count": 443,
              "case_summary": {
                "doc_count": 3884,
                "case_with_ssm": {
                  "doc_count": 443
                }
              }
            },
            {
              "key": "REBC-THYR",
              "doc_count": 440,
              "case_summary": {
                "doc_count": 2456,
                "case_with_ssm": {
                  "doc_count": 380
                }
              }
            },
            {
              "key": "TCGA-BLCA",
              "doc_count": 412,
              "case_summary": {
                "doc_count": 3645,
                "case_with_ssm": {
                  "doc_count": 412
                }
              }
            },
            {
              "key": "TARGET-OS",
              "doc_count": 383,
              "case_summary": {
                "doc_count": 1276,
                "case_with_ssm": {
                  "doc_count": 97
                }
              }
            },
            {
              "key": "TCGA-LIHC",
              "doc_count": 377,
              "case_summary": {
                "doc_count": 3204,
                "case_with_ssm": {
                  "doc_count": 377
                }
              }
            },
            {
              "key": "CPTAC-2",
              "doc_count": 342,
              "case_summary": {
                "doc_count": 1349,
                "case_with_ssm": {
                  "doc_count": 328
                }
              }
            },
            {
              "key": "TRIO-CRU",
              "doc_count": 339,
              "case_summary": {
                "doc_count": 339,
                "case_with_ssm": {
                  "doc_count": 0
                }
              }
            },
            {
              "key": "CGCI-BLGSP",
              "doc_count": 324,
              "case_summary": {
                "doc_count": 2076,
                "case_with_ssm": {
                  "doc_count": 262
                }
              }
            },
            {
              "key": "TCGA-CESC",
              "doc_count": 307,
              "case_summary": {
                "doc_count": 2623,
                "case_with_ssm": {
                  "doc_count": 306
                }
              }
            },
            {
              "key": "TCGA-KIRP",
              "doc_count": 291,
              "case_summary": {
                "doc_count": 2568,
                "case_with_ssm": {
                  "doc_count": 291
                }
              }
            },
            {
              "key": "HCMI-CMDC",
              "doc_count": 278,
              "case_summary": {
                "doc_count": 2420,
                "case_with_ssm": {
                  "doc_count": 277
                }
              }
            },
            {
              "key": "TCGA-TGCT",
              "doc_count": 263,
              "case_summary": {
                "doc_count": 2124,
                "case_with_ssm": {
                  "doc_count": 262
                }
              }
            },
            {
              "key": "TCGA-SARC",
              "doc_count": 261,
              "case_summary": {
                "doc_count": 2309,
                "case_with_ssm": {
                  "doc_count": 261
                }
              }
            },
            {
              "key": "CGCI-HTMCP-CC",
              "doc_count": 212,
              "case_summary": {
                "doc_count": 1452,
                "case_with_ssm": {
                  "doc_count": 206
                }
              }
            },
            {
              "key": "CMI-MBC",
              "doc_count": 200,
              "case_summary": {
                "doc_count": 653,
                "case_with_ssm": {
                  "doc_count": 174
                }
              }
            },
            {
              "key": "TCGA-LAML",
              "doc_count": 200,
              "case_summary": {
                "doc_count": 1533,
                "case_with_ssm": {
                  "doc_count": 200
                }
              }
            },
            {
              "key": "TARGET-ALL-P3",
              "doc_count": 191,
              "case_summary": {
                "doc_count": 782,
                "case_with_ssm": {
                  "doc_count": 86
                }
              }
            },
            {
              "key": "TCGA-ESCA",
              "doc_count": 185,
              "case_summary": {
                "doc_count": 1623,
                "case_with_ssm": {
                  "doc_count": 185
                }
              }
            },
            {
              "key": "TCGA-PAAD",
              "doc_count": 185,
              "case_summary": {
                "doc_count": 1720,
                "case_with_ssm": {
                  "doc_count": 185
                }
              }
            },
            {
              "key": "TCGA-PCPG",
              "doc_count": 179,
              "case_summary": {
                "doc_count": 1512,
                "case_with_ssm": {
                  "doc_count": 179
                }
              }
            },
            {
              "key": "OHSU-CNL",
              "doc_count": 176,
              "case_summary": {
                "doc_count": 494,
                "case_with_ssm": {
                  "doc_count": 158
                }
              }
            },
            {
              "key": "TCGA-READ",
              "doc_count": 172,
              "case_summary": {
                "doc_count": 1414,
                "case_with_ssm": {
                  "doc_count": 171
                }
              }
            },
            {
              "key": "TCGA-THYM",
              "doc_count": 124,
              "case_summary": {
                "doc_count": 1078,
                "case_with_ssm": {
                  "doc_count": 124
                }
              }
            },
            {
              "key": "TCGA-KICH",
              "doc_count": 113,
              "case_summary": {
                "doc_count": 705,
                "case_with_ssm": {
                  "doc_count": 66
                }
              }
            },
            {
              "key": "WCDT-MCRPC",
              "doc_count": 101,
              "case_summary": {
                "doc_count": 299,
                "case_with_ssm": {
                  "doc_count": 0
                }
              }
            },
            {
              "key": "TCGA-ACC",
              "doc_count": 92,
              "case_summary": {
                "doc_count": 809,
                "case_with_ssm": {
                  "doc_count": 92
                }
              }
            },
            {
              "key": "APOLLO-LUAD",
              "doc_count": 87,
              "case_summary": {
                "doc_count": 510,
                "case_with_ssm": {
                  "doc_count": 83
                }
              }
            },
            {
              "key": "TCGA-MESO",
              "doc_count": 87,
              "case_summary": {
                "doc_count": 813,
                "case_with_ssm": {
                  "doc_count": 87
                }
              }
            },
            {
              "key": "EXCEPTIONAL_RESPONDERS-ER",
              "doc_count": 84,
              "case_summary": {
                "doc_count": 412,
                "case_with_ssm": {
                  "doc_count": 20
                }
              }
            },
            {
              "key": "TCGA-UVM",
              "doc_count": 80,
              "case_summary": {
                "doc_count": 700,
                "case_with_ssm": {
                  "doc_count": 80
                }
              }
            },
            {
              "key": "CGCI-HTMCP-DLBCL",
              "doc_count": 70,
              "case_summary": {
                "doc_count": 465,
                "case_with_ssm": {
                  "doc_count": 50
                }
              }
            },
            {
              "key": "ORGANOID-PANCREATIC",
              "doc_count": 70,
              "case_summary": {
                "doc_count": 225,
                "case_with_ssm": {
                  "doc_count": 57
                }
              }
            },
            {
              "key": "TARGET-RT",
              "doc_count": 69,
              "case_summary": {
                "doc_count": 404,
                "case_with_ssm": {
                  "doc_count": 0
                }
              }
            },
            {
              "key": "CMI-MPC",
              "doc_count": 63,
              "case_summary": {
                "doc_count": 199,
                "case_with_ssm": {
                  "doc_count": 60
                }
              }
            },
            {
              "key": "MATCH-I",
              "doc_count": 60,
              "case_summary": {
                "doc_count": 345,
                "case_with_ssm": {
                  "doc_count": 57
                }
              }
            },
            {
              "key": "TCGA-DLBC",
              "doc_count": 58,
              "case_summary": {
                "doc_count": 441,
                "case_with_ssm": {
                  "doc_count": 50
                }
              }
            },
            {
              "key": "TCGA-UCS",
              "doc_count": 57,
              "case_summary": {
                "doc_count": 504,
                "case_with_ssm": {
                  "doc_count": 57
                }
              }
            },
            {
              "key": "BEATAML1.0-CRENOLANIB",
              "doc_count": 56,
              "case_summary": {
                "doc_count": 107,
                "case_with_ssm": {
                  "doc_count": 51
                }
              }
            },
            {
              "key": "MP2PRT-WT",
              "doc_count": 52,
              "case_summary": {
                "doc_count": 361,
                "case_with_ssm": {
                  "doc_count": 51
                }
              }
            },
            {
              "key": "TCGA-CHOL",
              "doc_count": 51,
              "case_summary": {
                "doc_count": 378,
                "case_with_ssm": {
                  "doc_count": 51
                }
              }
            },
            {
              "key": "CDDP_EAGLE-1",
              "doc_count": 50,
              "case_summary": {
                "doc_count": 384,
                "case_with_ssm": {
                  "doc_count": 50
                }
              }
            },
            {
              "key": "CTSP-DLBCL1",
              "doc_count": 45,
              "case_summary": {
                "doc_count": 201,
                "case_with_ssm": {
                  "doc_count": 0
                }
              }
            },
            {
              "key": "MATCH-W",
              "doc_count": 45,
              "case_summary": {
                "doc_count": 265,
                "case_with_ssm": {
                  "doc_count": 44
                }
              }
            },
            {
              "key": "MATCH-Z1A",
              "doc_count": 45,
              "case_summary": {
                "doc_count": 262,
                "case_with_ssm": {
                  "doc_count": 43
                }
              }
            },
            {
              "key": "CGCI-HTMCP-LC",
              "doc_count": 39,
              "case_summary": {
                "doc_count": 292,
                "case_with_ssm": {
                  "doc_count": 34
                }
              }
            },
            {
              "key": "CMI-ASC",
              "doc_count": 36,
              "case_summary": {
                "doc_count": 124,
                "case_with_ssm": {
                  "doc_count": 36
                }
              }
            },
            {
              "key": "MATCH-Z1D",
              "doc_count": 36,
              "case_summary": {
                "doc_count": 212,
                "case_with_ssm": {
                  "doc_count": 34
                }
              }
            },
            {
              "key": "MATCH-Q",
              "doc_count": 35,
              "case_summary": {
                "doc_count": 203,
                "case_with_ssm": {
                  "doc_count": 34
                }
              }
            },
            {
              "key": "MATCH-B",
              "doc_count": 33,
              "case_summary": {
                "doc_count": 187,
                "case_with_ssm": {
                  "doc_count": 32
                }
              }
            },
            {
              "key": "MATCH-Y",
              "doc_count": 31,
              "case_summary": {
                "doc_count": 181,
                "case_with_ssm": {
                  "doc_count": 30
                }
              }
            },
            {
              "key": "TARGET-ALL-P1",
              "doc_count": 24,
              "case_summary": {
                "doc_count": 86,
                "case_with_ssm": {
                  "doc_count": 0
                }
              }
            },
            {
              "key": "MATCH-U",
              "doc_count": 23,
              "case_summary": {
                "doc_count": 137,
                "case_with_ssm": {
                  "doc_count": 22
                }
              }
            },
            {
              "key": "MATCH-H",
              "doc_count": 21,
              "case_summary": {
                "doc_count": 122,
                "case_with_ssm": {
                  "doc_count": 21
                }
              }
            },
            {
              "key": "MATCH-N",
              "doc_count": 21,
              "case_summary": {
                "doc_count": 120,
                "case_with_ssm": {
                  "doc_count": 21
                }
              }
            },
            {
              "key": "TARGET-CCSK",
              "doc_count": 13,
              "case_summary": {
                "doc_count": 100,
                "case_with_ssm": {
                  "doc_count": 0
                }
              }
            },
            {
              "key": "VAREPOP-APOLLO",
              "doc_count": 7,
              "case_summary": {
                "doc_count": 14,
                "case_with_ssm": {
                  "doc_count": 7
                }
              }
            }
          ]
        }
      }
    }
    ```

### Survival Analysis Endpoint

[Survival plots](/Data_Portal/Users_Guide/mutation_frequency/#survival-plot-for-mutated-genes-and-mutations) are generated for different subsets of data, based on variants or projects, in the GDC Data Portal. The `/analysis/survival` endpoint can be used to programmatically retrieve the raw data used to generate these plots and apply different filters. Note that the `fields` and `format` parameters cannot be modified.

 __Example 1:__ A user wants to download data to generate a survival plot for cases from the project TCGA-DLBC.

=== "Shell"

    ```Shell
    curl "https://api.gdc.cancer.gov/analysis/survival?filters=%5B%7B%22op%22%3A%22%3D%22%2C%22content%22%3A%7B%22field%22%3A%22cases.project.project_id%22%2C%22value%22%3A%22TCGA-DLBC%22%7D%7D%5D&pretty=true"
    ```

=== "Response"

    ```json
    {
      "results": [
        {
          "meta": {
            "id": 139834474037000
          },
          "donors": [
            {
              "time": 1.0,
              "censored": true,
              "survivalEstimate": 1,
              "id": "dc87a809-95de-4eb7-a1c2-2650475f2d7e",
              "submitter_id": "TCGA-RQ-A6JB",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 17.0,
              "censored": true,
              "survivalEstimate": 1,
              "id": "4dd86ebd-ef16-4b2b-9ea0-5d1d7afef257",
              "submitter_id": "TCGA-RQ-AAAT",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 58,
              "censored": false,
              "survivalEstimate": 1,
              "id": "0bf573ac-cd1e-42d8-90cf-b30d7b08679c",
              "submitter_id": "TCGA-FA-A6HN",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 126.0,
              "censored": true,
              "survivalEstimate": 0.9777777777777777,
              "id": "f978cb0f-d319-4c01-b4c5-23ae1403a106",
              "submitter_id": "TCGA-FF-8047",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 132.0,
              "censored": true,
              "survivalEstimate": 0.9777777777777777,
              "id": "1843c82e-7a35-474f-9f79-c0a9af9aa09c",
              "submitter_id": "TCGA-FA-A4BB",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 132.0,
              "censored": true,
              "survivalEstimate": 0.9777777777777777,
              "id": "a43e5f0e-a21f-48d8-97e0-084d413680b7",
              "submitter_id": "TCGA-FA-8693",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 248,
              "censored": false,
              "survivalEstimate": 0.9777777777777777,
              "id": "0030a28c-81aa-44b0-8be0-b35e1dcbf98c",
              "submitter_id": "TCGA-FA-A7Q1",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 298.0,
              "censored": true,
              "survivalEstimate": 0.9539295392953929,
              "id": "f553f1a9-ecf2-4783-a609-6adca7c4c597",
              "submitter_id": "TCGA-FF-A7CQ",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 313,
              "censored": false,
              "survivalEstimate": 0.9539295392953929,
              "id": "f784bc3a-751b-4025-aab2-0af2f6f24266",
              "submitter_id": "TCGA-FF-A7CR",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 385.0,
              "censored": true,
              "survivalEstimate": 0.929469807518588,
              "id": "29e3d122-15a1-4235-a356-b1a9f94ceb39",
              "submitter_id": "TCGA-FF-A7CX",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 391,
              "censored": false,
              "survivalEstimate": 0.929469807518588,
              "id": "0e251c03-bf86-4ed8-b45d-3cbc97160502",
              "submitter_id": "TCGA-GS-A9U4",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 427.0,
              "censored": true,
              "survivalEstimate": 0.9043490019099776,
              "id": "e6365b38-bc44-400c-b4aa-18ce8ff5bfce",
              "submitter_id": "TCGA-FA-A82F",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 553.0,
              "censored": true,
              "survivalEstimate": 0.9043490019099776,
              "id": "b56bdbdb-43af-4a03-a072-54dd22d7550c",
              "submitter_id": "TCGA-FA-A86F",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 595,
              "censored": false,
              "survivalEstimate": 0.9043490019099776,
              "id": "31bbad4e-3789-42ec-9faa-1cb86970f723",
              "submitter_id": "TCGA-G8-6907",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 679.0,
              "censored": true,
              "survivalEstimate": 0.8777505018538018,
              "id": "0e9fcccc-0630-408d-a121-2c6413824cb7",
              "submitter_id": "TCGA-FF-8062",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 708,
              "censored": false,
              "survivalEstimate": 0.8777505018538018,
              "id": "a5b188f0-a6d3-4d4a-b04f-36d47ec05338",
              "submitter_id": "TCGA-FA-A4XK",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 719.0,
              "censored": true,
              "survivalEstimate": 0.8503207986708705,
              "id": "ed746cb9-0f2f-48ce-923a-3a9f9f00b331",
              "submitter_id": "TCGA-FA-A7DS",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 730.0,
              "censored": true,
              "survivalEstimate": 0.8503207986708705,
              "id": "c85f340e-584b-4f3b-b6a5-540491fc8ad2",
              "submitter_id": "TCGA-GS-A9TV",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 749.0,
              "censored": true,
              "survivalEstimate": 0.8503207986708705,
              "id": "69f23725-adca-48ac-9b33-80a7aae24cfe",
              "submitter_id": "TCGA-FA-A6HO",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 751.0,
              "censored": true,
              "survivalEstimate": 0.8503207986708705,
              "id": "67325322-483f-443f-9ffa-2a20d108a2fb",
              "submitter_id": "TCGA-FF-8046",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 765.0,
              "censored": true,
              "survivalEstimate": 0.8503207986708705,
              "id": "eda9496e-be80-4a13-bf06-89f0cc9e937f",
              "submitter_id": "TCGA-GS-A9TZ",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 788.0,
              "censored": true,
              "survivalEstimate": 0.8503207986708705,
              "id": "25ff86af-beb4-480c-b706-f3fe0306f7cf",
              "submitter_id": "TCGA-RQ-A68N",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 791.0,
              "censored": true,
              "survivalEstimate": 0.8503207986708705,
              "id": "1d0db5d7-39ca-466d-96b3-0d278c5ea768",
              "submitter_id": "TCGA-FF-A7CW",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 832.0,
              "censored": true,
              "survivalEstimate": 0.8503207986708705,
              "id": "c8cde9ea-89e9-4ee8-8a46-417a48f6d3ab",
              "submitter_id": "TCGA-FF-8061",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 946.0,
              "censored": true,
              "survivalEstimate": 0.8503207986708705,
              "id": "f0a326d2-1f3e-4a5d-bca8-32aaccc52338",
              "submitter_id": "TCGA-FF-8042",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 965.0,
              "censored": true,
              "survivalEstimate": 0.8503207986708705,
              "id": "a8e2df1e-4042-42af-9231-3a00e83489f0",
              "submitter_id": "TCGA-FF-8043",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 972.0,
              "censored": true,
              "survivalEstimate": 0.8503207986708705,
              "id": "e56e4d9c-052e-4ec6-a81b-dbd53e9c8ffe",
              "submitter_id": "TCGA-FM-8000",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 982.0,
              "censored": true,
              "survivalEstimate": 0.8503207986708705,
              "id": "45b0cf9f-a879-417f-8f39-7770552252c0",
              "submitter_id": "TCGA-GS-A9TQ",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 1081.0,
              "censored": true,
              "survivalEstimate": 0.8503207986708705,
              "id": "1f971af1-6772-4fe6-8d35-bbe527a037fe",
              "submitter_id": "TCGA-FF-8041",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 1163.0,
              "censored": true,
              "survivalEstimate": 0.8503207986708705,
              "id": "33365d22-cb83-4d8e-a2d1-06b675f75f6e",
              "submitter_id": "TCGA-GS-A9TT",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 1252,
              "censored": false,
              "survivalEstimate": 0.8503207986708705,
              "id": "6a21c948-cd85-4150-8c01-83017d7dc1ed",
              "submitter_id": "TCGA-G8-6324",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 1299.0,
              "censored": true,
              "survivalEstimate": 0.8003019281608192,
              "id": "f855dad1-6ffc-493e-ba6c-970874bc9210",
              "submitter_id": "TCGA-GR-A4D5",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 1334.0,
              "censored": true,
              "survivalEstimate": 0.8003019281608192,
              "id": "c1c06604-5ae2-4a53-b9c0-eb210d38e3f0",
              "submitter_id": "TCGA-GR-A4D6",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 1373.0,
              "censored": true,
              "survivalEstimate": 0.8003019281608192,
              "id": "58e66976-4507-4552-ac53-83a49a142dde",
              "submitter_id": "TCGA-GS-A9TX",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 1581.0,
              "censored": true,
              "survivalEstimate": 0.8003019281608192,
              "id": "ea54dbad-1b23-41cc-9378-d4002a8fca51",
              "submitter_id": "TCGA-G8-6325",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 1581.0,
              "censored": true,
              "survivalEstimate": 0.8003019281608192,
              "id": "d7df78b5-24f1-4ff4-bd9b-f0e6bec8289a",
              "submitter_id": "TCGA-GR-A4D4",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 1617.0,
              "censored": true,
              "survivalEstimate": 0.8003019281608192,
              "id": "29aff186-c321-4ff9-b81b-105e27e620ff",
              "submitter_id": "TCGA-GS-A9TW",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 1739.0,
              "censored": true,
              "survivalEstimate": 0.8003019281608192,
              "id": "5eff68ff-f6c3-40c9-9fc8-00e684a7b712",
              "submitter_id": "TCGA-GR-A4D9",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 2131.0,
              "censored": true,
              "survivalEstimate": 0.8003019281608192,
              "id": "f8cf647b-1447-4ac3-8c43-bef07765cabf",
              "submitter_id": "TCGA-G8-6326",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 2616.0,
              "censored": true,
              "survivalEstimate": 0.8003019281608192,
              "id": "6e9437f0-a4ed-475c-ab0e-bf1431c70a90",
              "submitter_id": "TCGA-GS-A9TY",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 2983.0,
              "censored": true,
              "survivalEstimate": 0.8003019281608192,
              "id": "c3d662ee-48d0-454a-bb0c-77d3338d3747",
              "submitter_id": "TCGA-GR-7353",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 3394.0,
              "censored": true,
              "survivalEstimate": 0.8003019281608192,
              "id": "fdecb74f-ac4e-46b1-b23a-5f7fde96ef9f",
              "submitter_id": "TCGA-GS-A9U3",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 3553,
              "censored": false,
              "survivalEstimate": 0.8003019281608192,
              "id": "a468e725-ad4b-411d-ac5c-2eacc68ec580",
              "submitter_id": "TCGA-G8-6909",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 3897.0,
              "censored": true,
              "survivalEstimate": 0.6402415425286554,
              "id": "1ea575f1-f731-408b-a629-f5f4abab569e",
              "submitter_id": "TCGA-GS-A9TU",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 4578.0,
              "censored": true,
              "survivalEstimate": 0.6402415425286554,
              "id": "7a589441-11ef-4158-87e7-3951d86bc2aa",
              "submitter_id": "TCGA-GR-7351",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 5980.0,
              "censored": true,
              "survivalEstimate": 0.6402415425286554,
              "id": "3622cf29-600f-4410-84d4-a9afeb41c475",
              "submitter_id": "TCGA-G8-6914",
              "project_id": "TCGA-DLBC"
            },
            {
              "time": 6425,
              "censored": false,
              "survivalEstimate": 0.6402415425286554,
              "id": "3f5a897d-1eaa-4d4c-8324-27ac07c90927",
              "submitter_id": "TCGA-G8-6906",
              "project_id": "TCGA-DLBC"
            }
          ]
        }
      ],
      "overallStats": {}
    }
    ```

__Example 2:__ Here the survival endpoint is used to compare two survival plots for TCGA-BRCA cases.  One plot will display survival information about cases with a particular mutation (in this instance: `chr3:g.179234297A>G`) and the other plot will display information about cases without that mutation. This type of query will also print the results of a chi-squared analysis between the two subsets of cases.  

=== "Json"

    ```json
    [  
      {  
        "op":"and",
        "content":[  
          {  
            "op":"=",
            "content":{  
              "field":"cases.project.project_id",
              "value":"TCGA-BRCA"
            }
          },
          {  
            "op":"=",
            "content":{  
              "field":"gene.ssm.ssm_id",
              "value":"edd1ae2c-3ca9-52bd-a124-b09ed304fcc2"
            }
          }
        ]
      },
      {  
        "op":"and",
        "content":[  
          {  
            "op":"=",
            "content":{  
              "field":"cases.project.project_id",
              "value":"TCGA-BRCA"
            }
          },
          {  
            "op":"excludeifany",
            "content":{  
              "field":"gene.ssm.ssm_id",
              "value":"edd1ae2c-3ca9-52bd-a124-b09ed304fcc2"
            }
          }
        ]
      }
    ]
    ```

=== "Shell"

    ```Shell
    curl "https://api.gdc.cancer.gov/analysis/survival?filters=%5B%7B%22op%22%3A%22and%22%2C%22content%22%3A%5B%7B%22op%22%3A%22%3D%22%2C%22content%22%3A%7B%22field%22%3A%22cases.project.project_id%22%2C%22value%22%3A%22TCGA-BRCA%22%7D%7D%2C%7B%22op%22%3A%22%3D%22%2C%22content%22%3A%7B%22field%22%3A%22gene.ssm.ssm_id%22%2C%22value%22%3A%22edd1ae2c-3ca9-52bd-a124-b09ed304fcc2%22%7D%7D%5D%7D%2C%7B%22op%22%3A%22and%22%2C%22content%22%3A%5B%7B%22op%22%3A%22%3D%22%2C%22content%22%3A%7B%22field%22%3A%22cases.project.project_id%22%2C%22value%22%3A%22TCGA-BRCA%22%7D%7D%2C%7B%22op%22%3A%22excludeifany%22%2C%22content%22%3A%7B%22field%22%3A%22gene.ssm.ssm_id%22%2C%22value%22%3A%22edd1ae2c-3ca9-52bd-a124-b09ed304fcc2%22%7D%7D%5D%7D%5D&pretty=true"
    ```

=== "Json2"     

    ```json
    {
      "overallStats": {
        "degreesFreedom": 1,
        "chiSquared": 0.8577589072612264,
        "pValue": 0.35436660628146011
      },
      "results": [
        {
          "donors": [
            {
              "survivalEstimate": 1,
              "id": "a991644b-3ee6-4cda-acf0-e37de48a49fc",
              "censored": true,
              "time": 10
            },
            {
              "survivalEstimate": 1,
              "id": "2e1e3bf0-1708-4b65-936c-48b89eb8966a",
              "censored": true,
              "time": 19
            },
    (truncated)
    ],
    "meta": {
      "id": 140055251282040
    }
    },
    {
    "donors": [
      {
        "survivalEstimate": 1,
        "id": "5e4187c9-98f8-4bdb-a8da-6a914e96f47a",
        "censored": true,
        "time": -31
      },
    (truncated)
    ```

The output represents two sets of coordinates delimited as objects with the `donors` tag. One set of coordinates will generate a survival plot representing TCGA-BRCA cases that have the mutation of interest and the other will generate a survival plot for the remaining cases in TCGA-BRCA.

__Example 3:__ Custom survival plots can be generated using the GDC API.  For example, a user could generate survival plot data comparing patients with a mutation in genes associated with a biological pathway with patients without mutations in that pathway. The following example compares a patient with at least one mutation in either gene `ENSG00000141510` or `ENSG00000155657` with patients that do not have mutations in these genes.

=== "Query"

    ``` json
    [  
       {  
          "op":"and",
          "content":[  
             {  
                "op":"=",
                "content":{  
                   "field":"cases.project.project_id",
                   "value":"TCGA-BRCA"
                }
             },
             {  
                "op":"=",
                "content":{  
                   "field":"gene.gene_id",
                   "value":["ENSG00000141510","ENSG00000155657"]
                }
             }
          ]
       },
       {  
          "op":"and",
          "content":[  
             {  
                "op":"=",
                "content":{  
                   "field":"cases.project.project_id",
                   "value":"TCGA-BRCA"
                }
             },
             {  
                "op":"excludeifany",
                "content":{  
                   "field":"gene.gene_id",
                   "value":["ENSG00000141510","ENSG00000155657"]
                }
             }
          ]
       }
    ]
    ```

=== "Shell"

    ```Shell
    curl "https://api.gdc.cancer.gov/analysis/survival?filters=%5B%0D%0A%7B%0D%0A%22op%22%3A%22and%22%2C%0D%0A%22content%22%3A%5B%0D%0A%7B%0D%0A%22op%22%3A%22%3D%22%2C%0D%0A%22content%22%3A%7B%0D%0A%22field%22%3A%22cases.project.project_id%22%2C%0D%0A%22value%22%3A%22TCGA-BRCA%22%0D%0A%7D%0D%0A%7D%2C%0D%0A%7B%0D%0A%22op%22%3A%22%3D%22%2C%0D%0A%22content%22%3A%7B%0D%0A%22field%22%3A%22gene.gene_id%22%2C%0D%0A%22value%22%3A%5B%22ENSG00000141510%22%2C%22ENSG00000155657%22%5D%0D%0A%7D%0D%0A%7D%0D%0A%5D%0D%0A%7D%2C%0D%0A%7B%0D%0A%22op%22%3A%22and%22%2C%0D%0A%22content%22%3A%5B%0D%0A%7B%0D%0A%22op%22%3A%22%3D%22%2C%0D%0A%22content%22%3A%7B%0D%0A%22field%22%3A%22cases.project.project_id%22%2C%0D%0A%22value%22%3A%22TCGA-BRCA%22%0D%0A%7D%0D%0A%7D%2C%0D%0A%7B%0D%0A%22op%22%3A%22excludeifany%22%2C%0D%0A%22content%22%3A%7B%0D%0A%22field%22%3A%22gene.gene_id%22%2C%0D%0A%22value%22%3A%5B%22ENSG00000141510%22%2C%22ENSG00000155657%22%5D%0D%0A%7D%0D%0A%7D%0D%0A%5D%0D%0A%7D%0D%0A%5D&pretty=true"
    ```

__Example 4:__ Survival plots can be even more customizable when sets of case IDs are used. Two sets of case IDs (or barcodes) can be retrieved in a separate step based on custom criteria and compared in a survival plot. See below for an example query.

=== "Json"

    ```Json
    [{  
       "op":"=",
       "content":{  
          "field":"cases.submitter_id",
          "value":["TCGA-HT-A74J","TCGA-43-A56U","TCGA-GM-A3XL","TCGA-A1-A0SQ","TCGA-K1-A6RV","TCGA-J2-A4AD","TCGA-XR-A8TE"]
       }
    },
    {  
       "op":"=",
       "content":{  
          "field":"cases.submitter_id",
          "value":["TCGA-55-5899","TCGA-55-6642","TCGA-55-7907","TCGA-67-6216","TCGA-75-5146","TCGA-49-4510","TCGA-78-7159"]
       }
    }]
    ```

=== "Shell"

    ```Shell
    curl "https://api.gdc.cancer.gov/analysis/survival?filters=%5B%7B%22op%22%3A%22%3D%22%2C%22content%22%3A%7B%22field%22%3A%22cases.submitter_id%22%2C%22value%22%3A%5B%22TCGA-HT-A74J%22%2C%22TCGA-43-A56U%22%2C%22TCGA-GM-A3XL%22%2C%22TCGA-A1-A0SQ%22%2C%22TCGA-K1-A6RV%22%2C%22TCGA-J2-A4AD%22%2C%22TCGA-XR-A8TE%22%5D%7D%7D%2C%7B%22op%22%3A%22%3D%22%2C%22content%22%3A%7B%22field%22%3A%22cases.submitter_id%22%2C%22value%22%3A%5B%22TCGA-55-5899%22%2C%22TCGA-55-6642%22%2C%22TCGA-55-7907%22%2C%22TCGA-67-6216%22%2C%22TCGA-75-5146%22%2C%22TCGA-49-4510%22%2C%22TCGA-78-7159%22%5D%7D%7D%5D"
    ```
