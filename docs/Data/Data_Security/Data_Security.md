# Data Security

To protect the privacy of research participants and support data integrity, the GDC requires user authorization and authentication for:

 - downloading controlled-access data
 - submitting data to the GDC

To perform these functions, GDC users must first obtain appropriate authorization via dbGaP and then authenticate via eRA Commons. The GDC sets user permissions at the project level according to dbGaP authorizations.

*See [Data Access Processes and Tools](https://gdc.cancer.gov/access-data/data-access-processes-and-tools) to learn more about the difference between open-access and controlled-access data.*

## Authorization via dbGaP

Instructions for obtaining authorization via dbGaP are provided in [Obtaining Access to Controlled Data](https://gdc.cancer.gov/access-data/obtaining-access-controlled-data) and [Obtaining Access to Submit Data](https://gdc.cancer.gov/submit-data/obtaining-access-submit-data).

## Authentication via eRA Commons

The following authentication methods are supported by the GDC:

|GDC Tool|Authentication Method|
|----|----|
| GDC Data Portal | Log in using eRA Commons account|
| GDC Data Submission Portal | Log in using eRA Commons account |
| GDC Data Transfer Tool | Authentication Token |
| GDC API | Authentication Token |


### Authentication Tokens

The GDC Data Transfer Tool and the GDC API use tokens for authentication. GDC authentication tokens are alphanumeric strings of characters like this one:

	ALPHANUMERICTOKEN-01234567890+AlPhAnUmErIcToKeN=0123456789-ALPHANUMERICTOKEN-01234567890+AlPhAnUmErIcToKeN=0123456789-ALPHANUMERICTOKEN-01234567890+AlPhAnUmErIcToKeN=0123456789-ALPHANUMERICTOKEN-01234567890+AlPhAnUmErIcToKeN=0123456789-ALPHANUMERICTOKEN-01234567890+AlPhAnUmErIcToKeN=0123456789-ALPHANUMERICTOKEN-01234567890+AlPhAnUmErIcToKeN=0123456789-ALPHANUMERICTOKEN-01234567890+AlPhAnUmErIcToKeN=0123456789-ALPHANUMERICTOKEN-01234567890+AlPhAnUmErIcToKeN=0123456789-ALPHANUMERICTOKEN-01234567890+AlPhAnUmErIcToKeN=0123456789-ALPHANUMERICTOKEN-01234567890+AlPhAnUmErIcToKeN=0123456789-ALPHANUMERICTOKEN-01234567890+AlPhAnUmErIcToKeN=0123456789-ALPHANUMERICTOKEN-01234567890+AlPhAnUmErIcToKeN=0123456789-ALPHANUMERICTOKEN-01234567890+AlPhAnUmErIcToKeN=0123456789-ALPHANUMERICTOKEN-01234567890+AlPhAnUmErIcToKeN=0123456789-ALPHANUMERICTOKEN-01234567890+AlPhAnUmErIcToKeN=0123456789-ALPHANUMERICTOKEN-01234567890+AlPhAnUmErIcToKeN=0123456789-ALPHANUMERICTOKEN-01234567890+AlPhAnUmErIcToKeN=0123456789-ALPHANUMERICTOKEN-01234567890+AlPhAnUmErIcToKeN=0123456789-ALPHANUMERICTO

## Logging into the GDC

To login to the GDC, users must click on the `Login` button on the top right of the GDC Website.

![Login](images/v2_image_login.jpg)

After clicking Login, users authenticate themselves using their eRA Commons login and password.  If authentication is successful, the eRA Commons username will be displayed in the upper right corner of the screen, in place of the "Login" button.

Upon successful authentication, GDC Data Portal users can:

- See which controlled-access files they can access.
- Download controlled-access files directly from the GDC Data Portal.
- Download an authentication token for use with the GDC Data Transfer Tool or the GDC API.
- See controlled-access mutation data they can access.

Controlled-access files are identified via their status in the Access Column:

[![GDC Data Portal Main Page](images/gdc-file-status-controlled-v2_3.png)](images/gdc-file-status-controlled-v2_3.png "Click to see the full image.")

The rest of this section describes controlled data access features of the GDC Data Portal available to authorized users. For more information about open and controlled-access data, and about obtaining access to controlled data, see [Data Access Processes and Tools](https://gdc.cancer.gov/access-data/data-access-processes-and-tools).

## User Profile

After logging into the GDC Portal, users can view which projects they have access to by clicking the `User Profile` section in the dropdown menu in the top corner of the screen.

[![User Profile Drop Down](images/gdc-user-profile-v2_small.png)](images/gdc-user-profile-v2_small.png "Click to see the full image.")

Clicking this button shows the list of projects.

[![User Profile](images/Profile_Access_List.png)](images/Profile_Access_List.png "Click to see the full image.")

## GDC Authentication Tokens

The GDC Data Portal provides authentication tokens for use with the GDC Data Transfer Tool or the GDC API. To download a token:

1. Log into the GDC using your eRA Commons credentials.
2. Click the username in the top right corner of the screen.
3. Select the "Download token" option.

![Token Download Button](images/Token_Download_v2_small.jpg)

A new token is generated each time the `Download Token` button is clicked.

For more information about authentication tokens, see [Data Security](../../Data/Data_Security/Data_Security.md#authentication-tokens).

>__Note:__ The authentication token should be kept in a secure location, as it allows access to all data accessible by the associated user account.

## Logging Out

To log out of the GDC, click the username in the top right corner of the screen, and select the Logout option.

![Logout link](images/gdc-user-portal-logout-v2_3.jpg)





#### Obtaining A Token

Users can obtain authentication tokens from the [GDC Data Portal](https://portal.gdc.cancer.gov) and the [GDC Data Submission Portal](https://portal.gdc.cancer.gov/submission). See the [GDC Data Submission Portal User's Guide](../../Data_Submission_Portal/Users_Guide/Data_Submission_Process.md#authentication) for instructions.

#### Token Expiration

Tokens are valid for 30 days from the time of issue. Any request to the GDC API that uses an expired token will result in an error.

Tokens can be replaced at any time by downloading a new token, which will be valid for another 30 days.

## Checking User Permissions

Users can view the permissions granted to them by the GDC system as follows:

0. Log into the [GDC Data Portal](https://portal.gdc.cancer.gov) or the [GDC Data Submission Portal](https://portal.gdc.cancer.gov/submission) using your eRA Commons account.
0. Open the URL `https://portal.gdc.cancer.gov/auth/user` to see a JSON object that describes user permissions.
