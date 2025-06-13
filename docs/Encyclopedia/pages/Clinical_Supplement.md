# Clinical Supplement #

## Description ##

The purpose of a clinical supplement file is to make available clinical information that does not fit into the GDC Data Dictionary.

## Overview ##

The GDC Data Dictionary has an extensive set of clinical elements<sup>1</sup>. However, due to the number and variety of submitting projects the GDC is not able to accommodate all possible clinical elements into the GDC Data Dictionary. The clinical supplement offers a way for submitters to include all existing clinical data even though it may not conform to the GDC Data Dictionary. Note that the content of these files is not searchable via the API, does not fit the GDC Data Dictionary, and may use different CDEs and vocabulary than other projects stored in the GDC.  

For example, whether or not a patient has mutations in the ER, PR and HER2 genes is very important when researching breast cancer. This information would not be very useful in most other cancers, so it can be found in the clinical supplement files for breast cancer patients rather than being incorporated into the data model across all cancers.

While some elements are unique to certain cancers, there is no guarantee that all patients associated with these cancers will have all elements populated.

### Data Formats ###

Clinical Supplement files are available in the GDC Data Portal as case-level XML files. Most elements have an associated CDE-ID that can be queried at the CDE Browser website for additional information<sup>2</sup>.  

## References ##
1. [GDC Clinical Data Elements](https://gdc.cancer.gov/about-data/data-harmonization-and-generation/clinical-data-harmonization)
2. [CDE Browser](https://cadsr.cancer.gov/onedata/Home.jsp)

## External Links ##
* N/A

Categories: Data Type
