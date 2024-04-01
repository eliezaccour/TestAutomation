*** Settings ***
Library  RequestsLibrary
Library  XML
Library  SeleniumLibrary
Library  String
Library  ../Resources/utils.py

*** Keywords ***
Preprocessing ST
    [Documentation]  Test case preprocessing.
    [Arguments]  ${testcase_number}
    ${tcid}  Evaluate  ${testcase_number}
    ${command}  ${input_json}  Read Input Command  ${global_data_filename}  ${tcid}
    ${command}  Populate Command Variables  ${command}  ${input_json}
    Initialize St Tc Status  ${global_data_filename}  ${global_sheetname_st}  ${tcid+1}  ${global_test_attendants}  ${global_timezone}
    ${status}  ${result}  Run Keyword And Ignore Error  Should Be Equal  ${input_json}  _NA_
    IF  '${status}'!='PASS'
        ${input_json}  Evaluate  json.loads('''${input_json}''')  json
    END
    [Return]  ${tcid}  ${command}  ${input_json}

LoadConfigParameters
    [Documentation]  Load Config parameters.
    ${config_keys}  ${config_values}  utils_st.Read Config Key Value Pairs  ${global_data_filename}  ${global_data_config_sheetname}
    ${length}  Get Length  ${config_keys}
    FOR  ${i}  IN RANGE  ${length}
      Set Global Variable  ${config_keys}[${i}]  ${config_values}[${i}]
    END

Open Connection And Log In
    LoadConfigParameters
    Open Connection  ${global_host}
    Login With Public Key  ${global_username}  ${global_ssh_id_rsa}

ExecuteCommand
    [Arguments]  ${command}
    Write  ssh ${global_username}@${global_host}
    Read Until  >
    Write  ${command}
    ${output}  Read  delay=${global_command_delay}
    [Return]  ${output}

AuthenticateREST
    [Arguments]  ${scope}  ${host}
    ${headers}  Create Dictionary  Content-Type=application/x-www-form-urlencoded
    Create Session  X_REST_Session  https://${host}:${global_port}  disable_warnings=1
    ${response} =  POST On Session  X_REST_Session  url=/oauth/v1/token?username=${global_username}&password=${global_password}&client_id=${global_client_id}&client_secret=${global_client_secret}&grant_type=password&scope=${scope}  headers=${headers}  expected_status=Any
    ${response_json}=    Evaluate    json.loads($response.text)    json
    ${access_token} =  Set Variable  ${response_json['access_token']}
    Set Suite Variable  ${global_access_token}  ${access_token}
    [Return]  ${access_token}

SendREST POST
    [Arguments]  ${url}  ${scope}  ${data}  ${host}
    ${access_token}  AuthenticateREST  ${scope}  ${host}
    ${headers}  Create Dictionary  Authorization=Bearer ${access_token}  Content-Type=application/json
    Create Session  X_REST_Session  https://${host}:${global_port}  disable_warnings=1
    ${doesDataExist}  Run Keyword And Ignore Error  Variable Should Exist  ${data}  return status
    IF  '${data}'=='_EMPTY_'
        ${doesDataExist}  Set Variable  _EMPTY_
    END
    IF  "${doesDataExist}"=="(\'PASS\', None)"
        ${response} =  POST On Session  X_REST_Session  url=${url}  headers=${headers}  data=${data}  expected_status=Any
    ELSE
        ${response} =  POST On Session  X_REST_Session  url=${url}  headers=${headers}  expected_status=Any
    END
    [Return]  ${response}

SendREST POST Multipart Form-Data
    [Arguments]  ${url}  ${scope}  ${files}  ${data}  ${host}
    ${access_token}  AuthenticateREST  ${scope}  ${host}
    ${headers}  Create Dictionary  Authorization=Bearer ${access_token}
    Create Session  X_REST_Session  https://${host}:${global_port}  disable_warnings=1
    ${doesDataExist}  Run Keyword And Ignore Error  Variable Should Exist  ${data}  return status
    ${status}  ${result}  Run Keyword And Ignore Error  Should Be Equal  ${input_json}  _EMPTY_
    IF  '${status}'=='PASS'
        ${doesDataExist}  Set Variable  _EMPTY_
    END
    IF  "${doesDataExist}"=="(\'PASS\', None)"
        ${response} =  POST On Session  X_REST_Session  url=${url}  headers=${headers}  data=${data}  files=${files}  expected_status=Any
    ELSE
        ${response} =  POST On Session  X_REST_Session  url=${url}  headers=${headers}  files=${files}  expected_status=Any
    END
    [Return]  ${response}

SendREST PUT
    [Arguments]  ${url}  ${scope}  ${data}  ${host}
    ${access_token}  AuthenticateREST  ${scope}  ${host}
    ${headers}  Create Dictionary  Authorization=Bearer ${access_token}  Content-Type=application/json
    Create Session  X_REST_Session  https://${host}:${global_port}  disable_warnings=1
    ${doesDataExist}  Run Keyword And Ignore Error  Variable Should Exist  ${data}  return status
    IF  '${data}'=='_EMPTY_'
        ${doesDataExist}  Set Variable  _EMPTY_
    END
    IF  "${doesDataExist}"=="(\'PASS\', None)"
        ${response} =  PUT On Session  X_REST_Session  url=${url}  headers=${headers}  data=${data}  expected_status=Any
    ELSE
        ${response} =  PUT On Session  X_REST_Session  url=${url}  headers=${headers}  expected_status=Any
    END
    [Return]  ${response}

SendREST PUT Multipart Form-Data
    [Arguments]  ${url}  ${scope}  ${files}  ${data}  ${host}
    ${access_token}  AuthenticateREST  ${scope}  ${host}
    ${headers}  Create Dictionary  Authorization=Bearer ${access_token}
    Create Session  X_REST_Session  https://${host}:${global_port}  disable_warnings=1
    ${doesDataExist}  Run Keyword And Ignore Error  Variable Should Exist  ${data}  return status
    IF  '${data}'=='_EMPTY_'
        ${doesDataExist}  Set Variable  _EMPTY_
    END
    IF  "${doesDataExist}"=="(\'PASS\', None)"
        ${response} =  PUT On Session  X_REST_Session  url=${url}  headers=${headers}  data=${data}  files=${files}  expected_status=Any
    ELSE
        ${response} =  PUT On Session  X_REST_Session  url=${url}  headers=${headers}  files=${files}  expected_status=Any
    END
    [Return]  ${response}

SendREST GET
    [Arguments]  ${url}  ${scope}  ${data}  ${host}
    ${access_token}  AuthenticateREST  ${scope}  ${host}
    ${headers}  Create Dictionary  Authorization=Bearer ${access_token}  Content-Type=application/json
    Create Session  X_REST_Session  https://${host}:${global_port}  disable_warnings=1
    ${isDataIncluded}  Run Keyword And Ignore Error  Should Not Be Equal As Strings  ${data}  _EMPTY_
    IF  "${isDataIncluded}"=="(\'FAIL\', \'_EMPTY_ == _EMPTY_\')"
        ${response} =  GET On Session  X_REST_Session  url=${url}  headers=${headers}  expected_status=Any
    ELSE
        ${response} =  GET On Session  X_REST_Session  url=${url}  headers=${headers}  data=${data}  expected_status=Any
    END
    [Return]  ${response}

SendREST DELETE
    [Arguments]  ${url}  ${scope}  ${host}
    ${access_token}  AuthenticateREST  ${scope}  ${host}
    ${headers}  Create Dictionary  Authorization=Bearer ${access_token}  Content-Type=application/json
    Create Session  X_REST_Session  https://${host}:${global_port}  disable_warnings=1
    ${response} =  DELETE On Session  X_REST_Session  url=${url}  headers=${headers}  expected_status=Any
    [Return]  ${response}

ValidateResponseOK
    [Documentation]  Validates that the response is success (i.e. succeeds if the response is a success response)
    [Arguments]  ${response}
    Run Keyword If  ${response.ok} is not ${TRUE}  Fail  Unexpected response: ${response.text}

