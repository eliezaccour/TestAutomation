# Automated User Acceptance Test for Containerized Applications

Test automation written in Python and Robot Framework for containerized applications on Kubernetes.

## Overview
Software to automate testing for containerized applications. It's written in Python and Robot Framework and it's highly customizable as test cases can be added dynamically and with minimal effort. The target is to enable the user to input a UAT Excel file which includes all the test cases, then the software executes them and updates the Excel with the result (PASS/FAIL), actual outputs and timestamps for each test case that was executed.

## Features
- Consolidated input Excel file with all user inputs (Commands, parameters, expected output) and execution outputs.
- Ability to run tests for multiple systems with minimal change (1 parameter change).
- Records test results dynamically and formats the Excel accordingly (Successful test cases are colored in green and failed ones in red).
- Can be used for any system test, whether it's virtualized, containerized, or other.
- Supports REST/SOAP API testing.

## Project Structure
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
