*** Settings ***
Resource  ../../import.robot

*** Keywords ***
send request to get cc card info using get method with key
  [Arguments]  ${key}
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ...  Key=${key}
  ${response}=  get request  oneapp_bff_service  ${uri.cc_card.get_cc_card_info}  headers=${headers}
  [Return]  ${response}

send request to get cc card info using get method without key
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ${response}=  get request  oneapp_bff_service  ${uri.cc_card.get_cc_card_info}  headers=${headers}
  [Return]  ${response}

success response body from '${response}' should return correct cc card infomation
  ${actual_response_body}=  set variable  ${response.json()}
  should be equal as integers  ${actual_response_body}[code]  ${200}
  should not be empty  ${actual_response_body}[data]
  ${main_item_count}=  get length  ${actual_response_body}[data]
  should be equal  ${main_item_count}  ${2}
  should not be empty  ${actual_response_body}[data][image_url]
  should not be empty  ${actual_response_body}[data][last_modified]