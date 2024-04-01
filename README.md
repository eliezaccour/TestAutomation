# Automated User Acceptance Test for Containerized Applications

Test automation written in Python and Robot Framework for containerized applications on Kubernetes.

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
