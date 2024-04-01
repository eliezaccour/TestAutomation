*** Settings ***
Library  SSHLibrary
Library  Collections
Library  ../Resources/utils.py
Resource  ../Resources/utils.robot
Resource  ../Resources/SetEnv.txt

Suite Setup  Open Connection And Log In
Suite Teardown  Close All Connections

*** Test Cases ***
TC-1-1
    [Documentation]  Verify X software version
    ${tcid}  ${command}  ${input_json}  Preprocessing ST  1
    ${output}  Execute Command  ${command}
    Should Contain  ${output}  ${input_json['x_build_number']}
    Write St Result To Excel  ${output}  PASS  ${global_data_filename}  ${global_sheetname_st}  ${tcid+1}

TC-1-2
    [Documentation]  Verify software history & deployment status
    ${tcid}  ${command}  ${input_json}  Preprocessing ST  2
    Log  ${command}
    ${output}  Execute Command  ${command}
    Should Contain  ${output}  deployed
    Write St Result To Excel  ${output}  PASS  ${global_data_filename}  ${global_sheetname_st}  ${tcid+1}

TC-1-3
    [Documentation]  Verify Kubernetes version
    ${tcid}  ${command}  ${input_json}  Preprocessing ST  3
    Log  ${command}
    ${output}  Execute Command  ${command}
    Should Contain  ${output}  Client Version:
    Should Contain  ${output}  Server Version:
    Write St Result To Excel  ${output}  PASS  ${global_data_filename}  ${global_sheetname_st}  ${tcid+1}

TC-1-4
    [Documentation]  Verify Kubernetes version
    ${tcid}  ${command}  ${input_json}  Preprocessing ST  4
    ${output}  Execute Command  helm version
    Should Start With  ${output}  version.BuildInfo
    Write St Result To Excel  ${output}  PASS  ${global_data_filename}  ${global_sheetname_st}  ${tcid+1}

TC-1-5
    [Documentation]  Verify Kubernetes version
    ${tcid}  ${command}  ${input_json}  Preprocessing ST  5
    ${output}  Execute Command  docker --version
    Should Start With  ${output}  Docker version
    Write St Result To Excel  ${output}  PASS  ${global_data_filename}  ${global_sheetname_st}  ${tcid+1}

TC-1-20
    [Documentation]  Generate token with OAuth2 client
    ${tcid}  ${command}  ${input_json}  Preprocessing ST  20
    ${access_token}  AuthenticateREST  openid ${input_json['scope']}  ${global_host_oam}
    Log  Access token is: ${access_token}
    Write St Result To Excel  ${access_token}  PASS  ${global_data_filename}  ${global_sheetname_st}  ${tcid+1}