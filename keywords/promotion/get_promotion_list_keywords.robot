*** Settings ***
Resource  ../../import.robot

*** Keywords ***
send request to get promotion list using get method with key, language and query parameter
  [Arguments]  ${key}  ${lang}  ${query_parameter}
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ...  Key=${key}
  ...  Accept-Language=${lang}
  ${response}=  get request  oneapp_bff_service   ${uri.promotion.get_promotion}?${query_parameter}  headers=${headers}
  [Return]  ${response}

send request to get promotion list using get method without key
  [Arguments]  ${lang}  ${promotion_id}
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ...  Accept-Language=${lang}
  ${response}=  get request  oneapp_bff_service  ${uri.promotion.get_promotion}/${promotion_id}  headers=${headers}
  [Return]  ${response}

send request to get promotion list using get method without language
  [Arguments]  ${key}  ${promotion_id}
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ...  Key=${key}
  ${response}=  get request  oneapp_bff_service   ${uri.promotion.get_promotion}/${promotion_id}  headers=${headers}
  [Return]  ${response}

success response body from '${response}' should return catalog promotion list with '${limit}'
  ${actual_response_body}=  set variable  ${response.json()}
  should be equal as integers  ${actual_response_body}[code]  ${200}
  should not be empty  ${actual_response_body}[data]
  ${main_item_count}=  get length  ${actual_response_body}[data]
  should be equal  ${main_item_count}  ${2}
  should not be empty  ${actual_response_body}[data][count]
  should not be empty  ${actual_response_body}[data][list]
  should not be empty  ${actual_response_body}[data][list][0]
  ${list_item_0_count}=  get length  ${actual_response_body}[data][list][0]
  should be equal  ${list_item_0_count}  ${8}
  should not be empty  ${actual_response_body}[data][list][0][promotion_id]
  should not be empty  ${actual_response_body}[data][list][0][type_code]
  should not be empty  ${actual_response_body}[data][list][0][subject]
  should not be empty  ${actual_response_body}[data][list][0][short_description]
  should not be empty  ${actual_response_body}[data][list][0][start_date]
  should not be empty  ${actual_response_body}[data][list][0][expired_date]
  should not be empty  ${actual_response_body}[data][list][0][created_at]
  should not be empty  ${actual_response_body}[data][list][0][cover_image_url]
  ${list_item_count}=  get length  ${actual_response_body}[data][list]
  should be true  ${list_item_count} <= ${limit}
  FOR  ${index}  IN RANGE  ${list_item_count}
    should be equal as strings  ${actual_response_body}[data][list][${index}][type_code]  CATALOG   fail at index = ${index}
  END

success response body from '${response}' should return event promotion list with '${limit}'
  ${actual_response_body}=  set variable  ${response.json()}
  should be equal as integers  ${actual_response_body}[code]  ${200}
  should not be empty  ${actual_response_body}[data]
  ${main_item_count}=  get length  ${actual_response_body}[data]
  should be equal  ${main_item_count}  ${2}
  should not be empty  ${actual_response_body}[data][count]
  should not be empty  ${actual_response_body}[data][list]
  should not be empty  ${actual_response_body}[data][list][0]
  ${list_item_0_count}=  get length  ${actual_response_body}[data][list][0]
  should be equal  ${list_item_0_count}  ${8}
  should not be empty  ${actual_response_body}[data][list][0][promotion_id]
  should not be empty  ${actual_response_body}[data][list][0][type_code]
  should not be empty  ${actual_response_body}[data][list][0][subject]
  should not be empty  ${actual_response_body}[data][list][0][short_description]
  should not be empty  ${actual_response_body}[data][list][0][start_date]
  should not be empty  ${actual_response_body}[data][list][0][expired_date]
  should not be empty  ${actual_response_body}[data][list][0][created_at]
  should not be empty  ${actual_response_body}[data][list][0][cover_image_url]
  ${list_item_count}=  get length  ${actual_response_body}[data][list]
  should be true  ${list_item_count} <= ${limit}
  FOR  ${index}  IN RANGE  ${list_item_count}
    should be equal as strings  ${actual_response_body}[data][list][${index}][type_code]  EVENT   fail at index = ${index}
  END

success response body from '${response}' should return correct promotion list with '${limit}'
  ${actual_response_body}=  set variable  ${response.json()}
  should be equal as integers  ${actual_response_body}[code]  ${200}
  should not be empty  ${actual_response_body}[data]
  ${main_item_count}=  get length  ${actual_response_body}[data]
  should be equal  ${main_item_count}  ${2}
  should not be empty  ${actual_response_body}[data][count]
  should not be empty  ${actual_response_body}[data][list]
  should not be empty  ${actual_response_body}[data][list][0]
  ${list_item_0_count}=  get length  ${actual_response_body}[data][list][0]
  should be equal  ${list_item_0_count}  ${8}
  should not be empty  ${actual_response_body}[data][list][0][promotion_id]
  should not be empty  ${actual_response_body}[data][list][0][type_code]
  should not be empty  ${actual_response_body}[data][list][0][subject]
  should not be empty  ${actual_response_body}[data][list][0][short_description]
  should not be empty  ${actual_response_body}[data][list][0][start_date]
  should not be empty  ${actual_response_body}[data][list][0][expired_date]
  should not be empty  ${actual_response_body}[data][list][0][created_at]
  should not be empty  ${actual_response_body}[data][list][0][cover_image_url]
  ${list_item_count}=  get length  ${actual_response_body}[data][list]
  should be true  ${list_item_count} <= ${limit}