*** Settings ***
Resource  ../../import.robot

*** Keywords ***
send request to get promotion detail using get method with key, language and promotion_id
  [Arguments]  ${key}  ${lang}  ${promotion_id}
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ...  Key=${key}
  ...  Accept-Language=${lang}
  ${response}=  get request  oneapp_bff_service   ${uri.promotion.get_promotion}/${promotion_id}  headers=${headers}
  [Return]  ${response}

send request to get promotion detail using get method without key
  [Arguments]  ${lang}  ${promotion_id}
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ...  Accept-Language=${lang}
  ${response}=  get request  oneapp_bff_service  ${uri.promotion.get_promotion}/${promotion_id}  headers=${headers}
  [Return]  ${response}

send request to get promotion detail using get method without language
  [Arguments]  ${key}  ${promotion_id}
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ...  Key=${key}
  ${response}=  get request  oneapp_bff_service   ${uri.promotion.get_promotion}/${promotion_id}  headers=${headers}
  [Return]  ${response}

success response body from '${response}' should return catalog promotion detail
  ${actual_response_body}=  set variable  ${response.json()}
  should be equal as integers  ${actual_response_body}[code]  ${200}
  should not be empty  ${actual_response_body}[data]
  ${main_item_count}=  get length  ${actual_response_body}[data]
  should be equal  ${main_item_count}  ${8}
  should not be empty  ${actual_response_body}[data][type_code]
  should not be empty  ${actual_response_body}[data][title]
  should not be empty  ${actual_response_body}[data][short_description]
  should be equal  ${actual_response_body}[data][link_url]  ${NULL}
  should not be empty  ${actual_response_body}[data][start_date]
  should not be empty  ${actual_response_body}[data][expired_date]
  should not be empty  ${actual_response_body}[data][cover_image_url]
  should not be empty  ${actual_response_body}[data][catalog_image_url]

success response body from '${response}' should return event promotion detail
  ${actual_response_body}=  set variable  ${response.json()}
  should be equal as integers  ${actual_response_body}[code]  ${200}
  should not be empty  ${actual_response_body}[data]
  ${main_item_count}=  get length  ${actual_response_body}[data]
  should be equal  ${main_item_count}  ${8}
  should not be empty  ${actual_response_body}[data][type_code]
  should not be empty  ${actual_response_body}[data][title]
  should not be empty  ${actual_response_body}[data][short_description]
  should be equal  ${actual_response_body}[data][link_url]  ${NULL}
  should not be empty  ${actual_response_body}[data][start_date]
  should not be empty  ${actual_response_body}[data][expired_date]
  should not be empty  ${actual_response_body}[data][cover_image_url]
  should not be empty  ${actual_response_body}[data][event_image_url]