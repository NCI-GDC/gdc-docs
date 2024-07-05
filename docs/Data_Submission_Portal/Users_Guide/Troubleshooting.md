# Data Submission Troubleshooting

This guide is intended to assist in problem-solving when encountering data upload errors. Please contact the GDC Help Desk at __<support@nci-gdc.datacommons.io>__ if you have any questions or concerns regarding a submission project.

## Transactions Page

After attempting data upload, the Data Submission Portal's [transaction page](https://docs.gdc.cancer.gov/Data_Submission_Portal/Users_Guide/Data_Submission_Process/#transactions) will indicate the state of each transaction as `SUCCEEDED`, `PENDING`, or `FAILED`. 

[![GDC Submission Transaction Page](images/DSP_Transaction_Page.png)](images/DSP_Transaction_Page.png "Click to see the full image.")

### Transaction Details

Clicking on a failed upload will open the [details panel](https://docs.gdc.cancer.gov/Data_Submission_Portal/Users_Guide/Data_Submission_Process/#transactions-details), which includes a Documents section containing an Error Report. 

[![GDC Submission Transaction Details](images/DSP_Transaction_Details.png)](images/DSP_Transaction_Details.png "Click to see the full image.")

## Error Report

The Error Report is generated in tab-delimited format and describes the reason(s) that the transaction was not successful.

### Error Report Table

The Error Report table displays the following information:

|Column|Description|
| --- | --- |
| __entityType__ | Entity type that caused the error |
| __key__ | Property that caused the error|
| __errorType__ | The type of error |
| __message__ | Detailed description of the error |
| __id__ | UUID of the errored entity |

[![GDC Submission Transaction Details](images/DSP_Error_Report.png)](images/DSP_Error_Report.png "Click to see the full image.")

### Data Upload Error Messages

Each error type can have numerous error messages which are detailed in the following sections.

#### ERROR Messages

|Message|Explanation|Solution|
| --- | --- | --- |
| __'{Value}' is not one of [{acceptable values}]__ | The value is not accepted by the GDC for the designated property | Ensure the property value is acceptable by reviewing the GDC Data Dictionary |
| __'{Entity}' with {'project_id': '{project_id}', 'submitter_id': '{entity submitter_id}'} already exists in the GDC__ | An entity with that submitter_id has already been uploaded to the designated project | Ensure the submitter_id is unique to the project |
| __Additional properties are not allowed ('{property}' or '{list of properties}')was/were unexpected__ | The given property or properties are not accepted for the designated entity | Ensure entity accepts the properties by reviewing the GDC Data Dictionary |
| __{value} is less than the minimum of -32872__ | The amount is less than the minimum accepted value | Ensure the value is greater than or equal to the minimum value |

#### INVALID_LINK Messages

|Message|Explanation|Solution|
| --- | --- | --- |
| __'{Parent entity}' link has to be one_to_one, target node {parent entity} already has {child entity}__ | The parent entity can only have one child entity, and the child entity can only have one parent entity | Ensure the parent entity is only linked to one child entity and vice versa |
| __'{Parent entity}' link has to be one_to_many, target node {parent entity} already has a {child entity}__ | The parent entity cannot have multiple child entities | Ensure each parent entity is only linked to one child entity |
| __'{Parent entity}' link has to be many_to_one__ | The child entity cannot have multiple parent entities | Ensure the child entity links to only one parent entity |
| __More than one link destination found for {parent entity}__ | A new entity's submitter_id is already in use, such that multiple entities with the same submitter_id would exist had the upload not failed | Make sure the submitter_ids for each new entity are unique |
| __Entity is missing required link to {parent entity}__ | The child entity is not linked to a parent node | Link the child entity to at least one parent entity, based on their relationship (many_to_one, one_to_many, or one_to_one) |
| __No link destination found for {}__ | The parent entity's submitter_id does not exist | Make sure the child entity is linking to the correct parent entity and that the submitter_id is accurate |

#### INVALID_PROPERTY Messages

|Message|Explanation|Solution|
| --- | --- | --- |
| __Key '{property}' is not a valid property for type '{entity}'__ | The designated entity does not accept that property | Ensure the property is accepted for the entity by reviewing the GDC Data Dictionary |

#### INVALID_TYPE Messages

|Message|Explanation|Solution|
| --- | --- | --- |
| __missing 'type'__ | This is a vague error message that frequently does not encapsulate the reason that the data upload is failing | Scrutinize the file for other issues such as a formatting problem (e.g. an extra column in the TSV, incorrect JSON formatting, the node is already in state=submitted, or a case is not registered with dbGaP) |

#### INVALID_VALUE Messages

|Message|Explanation|Solution|
| --- | --- | --- |
| __None is not of type 'string'__ | If a property accepts string values, 'null' is not an accepted value | Update the entity to have a string value for the given property, change a null value to "null", or remove the property if it is not required |
| __{value} is not valid under any of the given schemas: {value} is less than the minimum of {minimum value} and {value} is not of type 'null'__ | The amount does not fall within the accepted minimum and maximum values | Ensure the value falls within the accepted range |

#### MISSING_PROPERTY Messages

|Message|Explanation|Solution|
| --- | --- | --- |
| __'{value}' is a required property__ | The upload is missing a required property | Ensure the required property is included in the file |

#### NOT_FOUND Messages

|Message|Explanation|Solution|
| --- | --- | --- |
| __Cannot create node with new submitter id specified. If update action (PUT) requested, Ensure specified id/submitter id exists__ | The submitter_id does not exist so the entity cannot be versioned and replaced with an entity with the new_submitter_id | If the new_submitter_id already exists and the md5sum is the same, this entity has already been uploaded and can be skipped. If neither the submitter_id nor the new_submitter_id exists, remove submitter_id and change "new_submitter_id" to "submitter_id" |
| __Unable to validate case against dbGaP. {}__ | The case submitter_id is not registered in dbGaP | Ensure that there are no typos in the submitter_id or submit additional cases to dbGaP |
| __Case submitter_id '{}' not found in dbGaP__ | The case submitter_id is not registered in dbGaP | Ensure that there are no typos in the submitter_id or submit additional cases to dbGaP |

#### UNALLOWED_GENCODE_VERSION Messages

|Message|Explanation|Solution|
| --- | --- | --- |
| __{value} is not in allowed gencode versions {self.allowed_versions}__ | The specified gencode version is not accepted | Update the gencode version to an accepted GDC value (currently either "neutral" or "v36") |