# Automated User Acceptance Test for Containerized Applications

Test automation written in Python and Robot Framework (RF) for containerized applications on Kubernetes.

## 1. Overview
Software to automate testing for containerized applications. It's written in Python and Robot Framework and it's highly customizable as test cases can be added dynamically and with minimal effort. The target is to enable the user to input a UAT Excel file which includes all the test cases, then the software executes them and updates the Excel with the result (PASS/FAIL), actual outputs and timestamps for each test case that was executed.

## 2. Features
- Consolidated input Excel file with all user inputs (Commands, parameters, expected output) and execution outputs.
- Ability to run tests for multiple systems with minimal change (1 parameter change).
- Records test results dynamically and formats the Excel accordingly (Successful test cases are colored in green and failed ones in red).
- Can be used for any system test, whether it's virtualized, containerized, or other.
- Supports REST/SOAP API testing.

## 3. Project Structure
└─ Main/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ main.robot<br>
└─ Data/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ System Test UAT.xlsx<br>
└─ Resources/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ utils.robot<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ utils.py<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ SetEnv.txt<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ id_rsa<br>
└─ TestLog/

#### Summary:
<table>
  <tr>
    <th>Directory</th>
    <th>File</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Main/</td>
    <td>main.robot</td>
    <td>Holds the main high-level logic for running each test case.</td>
  </tr>
  <tr>
    <td rowspan="3">Resources/</td>
    <td>utils.robot</td>
    <td>Implements low-level libraries and API calls. utils.py Implements helper functions that are called by utils.robot. Mainly used to read/write to the .xlsx file. SetEnv.txt Stores global variables used across main.robot and utils.robot.</td>
  </tr>
  <tr>
    <td>utils.py</td>
    <td>Implements helper functions that are called by utils.robot. Mainly used to read/write to the .xlsx file.</td>
  </tr>
  <tr>
    <td>SetEnv.txt</td>
    <td>Stores global variables used across main.robot and utils.robot.</td>
  </tr>
  <tr>
    <td>Data/</td>
    <td>System Test UAT.xlsx</td>
    <td>The Data directory stores the input Excel file.</td>
  </tr>
  <tr>
    <td colspan="2">TestLog/</td>
    <td>The TestLog directory can be used to store the output files (log-xxx.html, report-xxx.html, output-xxx.xml).</td>
  </tr>
</table>

## 4. User Input
The user input is consolidated in the input Excel file, stored under Data/System Test UAT.xlsx.
The global variable ‘${global_data_filename}’ in the SetEnv.txt file controls this, so to modify the file name/path you must change this variable as well.
### 4.1. Config Sheet
The input file must include a Config sheet holding all the user inputs, such as host, port, FQDN, username, password, etc. These are parameters used by utils.robot.
You may create one or more config sheets (e.g. one per site) and configure the robot suite to the one you intend to use by setting it in the SetEnv.txt file under '${global_data_config_sheetname}'.
### 4.2. Test Cases Sheet
Includes the following columns:
<table>
  <tr>
    <th>Column</th>
    <th>Description</th>
    <th>Occurence</th>
  </tr>
  <tr>
    <td>TC#</td>
    <td>Test case identifier.</td>
    <td>Optional</td>
  </tr>
  <tr>
    <td>Scenario</td>
    <td>Free text field. Can be used as an enum to categorize text cases.</td>
    <td>Optional</td>
  </tr>
  <tr>
    <td>Test Cases</td>
    <td>Test cases title</td>
    <td>Optional</td>
  </tr>
  <tr>
    <td>Exepcted Result</td>
    <td>Description of the expected result.</td>
    <td>Optional</td>
  </tr>
  <tr>
    <td>*** ${User_Input_Parameter_JSON} ***</td>
    <td>JSON string that maps the parameters used in the input command.</td>
    <td>Mandatory</td>
  </tr>
  <tr>
    <td>*** ${User_Input_Command} ***</td>
    <td>Used for the test cases that require an input command. It can include either hard set parameters or dynamic parameters that are defined in the JSON input, e.g. ${parameter1}.</td>
    <td>Mandatory</td>
  </tr>
  <tr>
    <td>Output</td>
    <td>The output received from CLI or REST API. It is automatically filled by the software.</td>
    <td>Filled by RF</td>
  </tr>
  <tr>
    <td>${Test Attendants/Reviewers}</td>
    <td>Optional field to list the names of the test attendants.<br>It is automatically appended to each test case by RF. The value is retrieved from the ${global_test_attendants} parameter in the Config sheet.</td>
    <td>Optional</td>
  </tr>
  <tr>
    <td>Test Date</td>
    <td>The test day and time are automatically filled by RF. The timezone set in the ${global_timezone} config parameter is used.</td>
    <td>Filled by RF</td>
  </tr>
  <tr>
    <td>Status</td>
    <td>Enum: [PASS|FAIL]<br>It is automatically filled by RF.</td>
    <td>Filled by RF</td>
  </tr>
</table>

## 5. Test Execution
### 5.1. Command Line Output
Below is a sample output of its execution:
```plaintext
> robot -d TestLog -L debug Main/main.robot
==============================================================================
X System Test
==============================================================================
TC-1-1 :: Verify X software version                                   | PASS |
------------------------------------------------------------------------------
TC-1-2 :: Verify software history & deployment status                 | PASS |
------------------------------------------------------------------------------
TC-1-3 :: Verify Kubernetes version                                   | PASS |
------------------------------------------------------------------------------
TC-1-4 :: Verify Kubernetes version                                   | PASS |
------------------------------------------------------------------------------
TC-1-5 :: Verify CCD version                                          | PASS |
------------------------------------------------------------------------------
TC-1-6 :: Verify CCD node details                                     | PASS |
------------------------------------------------------------------------------
TC-1-7 :: Verify pod status                                           | PASS |
------------------------------------------------------------------------------
TC-1-8 :: Verify Kubernetes service status                            | PASS |
------------------------------------------------------------------------------
TC-1-9 :: Verify Kubernetes deployment status                         | PASS |
------------------------------------------------------------------------------
TC-1-10 :: Verify Kubernetes ReplicaSet status                        | PASS |
------------------------------------------------------------------------------
TC-1-11 :: Verify Kubernetes HTTP proxy (Ingress) status              | PASS |
------------------------------------------------------------------------------
TC-1-12 :: Verify Kubernetes StatefulSet status                       | PASS |
------------------------------------------------------------------------------
TC-1-13 :: Verify Kubernetes ConfigMap status                         | PASS |
------------------------------------------------------------------------------
TC-1-14 :: Verify Kubernetes job status                               | PASS |
------------------------------------------------------------------------------
TC-1-15 :: Verify Cassandra status                                    | PASS |
------------------------------------------------------------------------------
TC-1-16 :: Verify Kubernetes Secret status                            | PASS |
------------------------------------------------------------------------------
TC-1-17 :: Verify Kubernetes Persistent Volumes (PV)                  | PASS |
------------------------------------------------------------------------------
TC-1-18 :: Verify Kubernetes Persistent Volume Claim (PVC)            | PASS |
------------------------------------------------------------------------------
TC-1-19 :: GUI Authentication                                         | PASS |
------------------------------------------------------------------------------
TC-1-20 :: Generate token with OAuth2 client                          | PASS |
------------------------------------------------------------------------------
...
X System Test                                                         | PASS |
60 tests, 60 passed, 0 failed
==============================================================================
```
### 5.2. Excel File Output
When running the test, the input Excel file is updated. The following columns are updated for each executed test case:
- Output
- Test Attendants/Reviewers
- Test Date
- Status [PASS|FAIL]

Additionally, the following files are produced under TestLog/:
- log-xxx.html
- report-xxx.html
- output-xxx.xml

#### Output:
![Output](https://private-user-images.githubusercontent.com/43040251/318359234-4c610f14-5ed7-4cde-8fdc-d37b8e263bad.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MTE5NTQzMTgsIm5iZiI6MTcxMTk1NDAxOCwicGF0aCI6Ii80MzA0MDI1MS8zMTgzNTkyMzQtNGM2MTBmMTQtNWVkNy00Y2RlLThmZGMtZDM3YjhlMjYzYmFkLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDA0MDElMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwNDAxVDA2NDY1OFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWNjZDE2NjliZTdlZjA5NThkMTJlNjYwNjZiZGJlZjY0YWJmZmIxN2IzNmYxOTY2NDc1YWY3MTMzMzVmMWU2M2MmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.iFOdo-ZvFoEF8YXWxpfM4U-YocYg-uUrzeJZ9ETOm4I)

