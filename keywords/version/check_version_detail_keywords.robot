*** Settings ***
Resource  ../../import.robot

*** Keywords ***
send request to check version detail using post method with app detail
  [Arguments]  ${key}  ${os}  ${version}
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ...  Key=${key}
  ${request_body}=  create dictionary
  ...  os=${os}
  ...  version=${version}
  ${response}=  post request  oneapp_bff_service  ${uri.version.check_version}  headers=${headers}  data=${request_body}
  [Return]  ${response}

send request to check version detail using post method without os
  [Arguments]  ${key}  ${version}
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ...  Key=${key}
  ${request_body}=  create dictionary
  ...  version=${version}
  ${response}=  post request  oneapp_bff_service  ${uri.version.check_version}  headers=${headers}  data=${request_body}
  [Return]  ${response}

send request to check version detail using post method without version
  [Arguments]  ${key}  ${os}
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ...  Key=${key}
  ${request_body}=  create dictionary
  ...  os=${os}
  ${response}=  post request  oneapp_bff_service  ${uri.version.check_version}  headers=${headers}  data=${request_body}
  [Return]  ${response}

send request to check version detail using post method without key
  [Arguments]  ${os}  ${version}
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ${request_body}=  create dictionary
  ...  os=${os}
  ...  version=${version}
  ${response}=  post request  oneapp_bff_service  ${uri.version.check_version}  headers=${headers}  data=${request_body}
  [Return]  ${response}

success response body should return app version detail, forced status and updated status
  [Arguments]  ${response}  ${os}  ${expected_your_version}  ${expected_forced_status}  ${expected_update_status}
  ${actual_response_body}=  set variable  ${response.json()}
  should be equal as integers  ${actual_response_body}[code]  ${200}
  should not be empty  ${actual_response_body}[data]
  ${main_item_count}=  get length  ${actual_response_body}[data]
  should be equal  ${main_item_count}  ${5}
  run keyword if  '${os}' == 'IOS'  run keywords
  ...  set test variable  ${expected_latest_version}  1.0.1  AND
  ...  set test variable  ${expected_force_version}  1.0.1
  ...  ELSE    run keywords
  ...  set test variable  ${expected_latest_version}  1.0.0  AND
  ...  set test variable  ${expected_force_version}  1.0.0
  should be equal as strings  ${actual_response_body}[data][your_version]  ${expected_your_version}
  should be equal as strings  ${actual_response_body}[data][latest_version]  ${expected_latest_version}
  should be equal as strings  ${actual_response_body}[data][force_version]  ${expected_force_version}
  should be equal  ${actual_response_body}[data][is_forced]  ${expected_forced_status}
  should be equal  ${actual_response_body}[data][is_same]  ${expected_update_status}