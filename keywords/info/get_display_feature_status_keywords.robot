*** Settings ***
Resource  ../../import.robot

*** Keywords ***
send request to get display feature status using get method with key
  [Arguments]  ${key}
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ...  Key=${key}
  ${response}=  get request  oneapp_bff_service  ${uri.info.get_display_feature_status}  headers=${headers}
  [Return]  ${response}

send request to get display feature status using get method without key
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ${response}=  get request  oneapp_bff_service  ${uri.info.get_display_feature_status}  headers=${headers}
  [Return]  ${response}

success response body from '${response}' should return correct display feature status
  ${actual_response_body}=  set variable  ${response.json()}
  should be equal as integers  ${actual_response_body}[code]  ${200}
  should not be empty  ${actual_response_body}[data]
  ${main_item_count}=  get length  ${actual_response_body}[data]
  should be equal  ${main_item_count}  ${1}
  should be equal  ${actual_response_body}[data][is_show_feature]  ${FALSE}