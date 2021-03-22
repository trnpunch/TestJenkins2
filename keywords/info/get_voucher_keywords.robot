*** Settings ***
Resource  ../../import.robot

*** Keywords ***
send request to get voucher using get method with key
  [Arguments]  ${key}
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ...  Key=${key}
  ${response}=  get request  oneapp_bff_service  ${uri.info.get_voucher}  headers=${headers}
  [Return]  ${response}

send request to get voucher using get method without key
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ${response}=  get request  oneapp_bff_service  ${uri.info.get_voucher}  headers=${headers}
  [Return]  ${response}

success response body from '${response}' should return correct voucher
  ${actual_response_body}=  set variable  ${response.json()}
  should be equal as integers  ${actual_response_body}[code]  ${200}
  should not be empty  ${actual_response_body}[data]
  ${main_item_count}=  get length  ${actual_response_body}[data]
  should be equal  ${main_item_count}  ${2}
  should not be empty  ${actual_response_body}[data][th]
  ${th_item_count}=  get length  ${actual_response_body}[data][th]
  should be equal  ${th_item_count}  ${4}
  should not be empty  ${actual_response_body}[data][en]
  ${en_item_count}=  get length  ${actual_response_body}[data][en]
  should be equal  ${en_item_count}  ${4}
  should not be empty  ${actual_response_body}[data][th][detail_voucher]
  should not be empty  ${actual_response_body}[data][th][condition_voucher]
  should not be empty  ${actual_response_body}[data][th][detail_coupon]
  should not be empty  ${actual_response_body}[data][th][condition_coupon]
  should not be empty  ${actual_response_body}[data][en][detail_voucher]
  should not be empty  ${actual_response_body}[data][en][condition_voucher]
  should not be empty  ${actual_response_body}[data][en][detail_coupon]
  should not be empty  ${actual_response_body}[data][en][condition_coupon]