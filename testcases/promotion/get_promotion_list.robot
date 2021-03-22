*** Settings ***
Resource  ../../import.robot
Resource  ../../keywords/promotion/get_promotion_list_keywords.robot

*** Variables ***
${promotion_type_catalog}  CATALOG
${promotion_type_event}  EVENT
${invalid_promotion_type}  catalog
${promotion_list_limit}  10
${promotion_list_limit_more_than_100}  101
${promotion_list_limit_less_than_-1}  -2
${invalid_promotion_list_limit}  A
${promotion_list_offset}  0
${invalid_promotion_list_offset}  A

*** Test Cases ***
TC-ONEBFF-PLST-001 Get Promotion list - success - type = CATALOG
  [Tags]  integration
  ${get_promotion_list_response}=  send request to get promotion list using get method with key, language and query parameter
  ...  ${access_key}
  ...  ${language.th}
  ...  type=${promotion_type_catalog}&limit=${promotion_list_limit}&offset=${promotion_list_offset}
  http response status from '${get_promotion_list_response}' should be '200'
  success response body from '${get_promotion_list_response}' should return catalog promotion list with '${promotion_list_limit}'

TC-ONEBFF-PLST-002 Get Promotion list - success - type = EVENT
  [Tags]  not_ready
  ${get_promotion_list_response}=  send request to get promotion list using get method with key, language and query parameter
  ...  ${access_key}
  ...  ${language.th}
  ...  type=${promotion_type_event}&limit=${promotion_list_limit}&offset=${promotion_list_offset}
  http response status from '${get_promotion_list_response}' should be '200'
  success response body from '${get_promotion_list_response}' should return event promotion list with '${promotion_list_limit}'

TC-ONEBFF-PLST-003 Get Promotion list - success - without type.
  [Tags]  integration
  ${get_promotion_list_response}=  send request to get promotion list using get method with key, language and query parameter
  ...  ${access_key}
  ...  ${language.th}
  ...  limit=${promotion_list_limit}&offset=${promotion_list_offset}
  http response status from '${get_promotion_list_response}' should be '200'
  success response body from '${get_promotion_list_response}' should return correct promotion list with '${promotion_list_limit}'

TC-ONEBFF-PLST-004 Get Promotion list - type is empty.
  [Tags]  integration
  ${get_promotion_list_response}=  send request to get promotion list using get method with key, language and query parameter
  ...  ${access_key}
  ...  ${language.th}
  ...  type=${EMPTY}&limit=${promotion_list_limit}&offset=${promotion_list_offset}
  http response status from '${get_promotion_list_response}' should be '200'
  success response body from '${get_promotion_list_response}' should return correct promotion list with '${promotion_list_limit}'

TC-ONEBFF-PLST-005 Get Promotion list - type is invalid format.
  [Tags]  integration
  ${get_promotion_list_response}=  send request to get promotion list using get method with key, language and query parameter
  ...  ${access_key}
  ...  ${language.th}
  ...  type=${invalid_promotion_type}&limit=${promotion_list_limit}&offset=${promotion_list_offset}
  http response status from '${get_promotion_list_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_list_response}
  ...  400
  ...  ${promotion_type.field_name}
  ...  ${promotion_type.promotion_type_is_invalid}

TC-ONEBFF-PLST-006 Get Promotion list - limit more than 100.
  [Tags]  integration
  ${get_promotion_list_response}=  send request to get promotion list using get method with key, language and query parameter
  ...  ${access_key}
  ...  ${language.th}
  ...  type=${promotion_type_catalog}&limit=${promotion_list_limit_more_than_100}&offset=${promotion_list_offset}
  http response status from '${get_promotion_list_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_list_response}
  ...  400
  ...  ${promotion_limit.field_name}
  ...  ${promotion_limit.promotion_limit_is_invalid}

TC-ONEBFF-PLST-007 Get Promotion list - limit less than -1.
  [Tags]  integration
  ${get_promotion_list_response}=  send request to get promotion list using get method with key, language and query parameter
  ...  ${access_key}
  ...  ${language.th}
  ...  type=${promotion_type_catalog}&limit=${promotion_list_limit_less_than_-1}&offset=${promotion_list_offset}
  http response status from '${get_promotion_list_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_list_response}
  ...  400
  ...  ${promotion_limit.field_name}
  ...  ${promotion_limit.promotion_limit_is_invalid}

TC-ONEBFF-PLST-008 Get Promotion list - limit is invalid format.
  [Tags]  integration
  ${get_promotion_list_response}=  send request to get promotion list using get method with key, language and query parameter
  ...  ${access_key}
  ...  ${language.th}
  ...  type=${promotion_type_catalog}&limit=${invalid_promotion_list_limit}&offset=${promotion_list_offset}
  http response status from '${get_promotion_list_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_list_response}
  ...  400
  ...  ${promotion_limit.field_name}
  ...  ${promotion_limit.promotion_limit_is_invalid_format}

TC-ONEBFF-PLST-009 Get Promotion list - limit is missing.
  [Tags]  integration
  ${get_promotion_list_response}=  send request to get promotion list using get method with key, language and query parameter
  ...  ${access_key}
  ...  ${language.th}
  ...  type=${promotion_type_catalog}&offset=${promotion_list_offset}
  http response status from '${get_promotion_list_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_list_response}
  ...  400
  ...  ${promotion_limit.field_name}
  ...  ${promotion_limit.promotion_limit_is_required}

TC-ONEBFF-PLST-010 Get Promotion list - limit is empty.
  [Tags]  integration
  ${get_promotion_list_response}=  send request to get promotion list using get method with key, language and query parameter
  ...  ${access_key}
  ...  ${language.th}
  ...  type=${promotion_type_catalog}&limit=${EMPTY}&offset=${promotion_list_offset}
  http response status from '${get_promotion_list_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_list_response}
  ...  400
  ...  ${promotion_limit.field_name}
  ...  ${promotion_limit.promotion_limit_is_required}

TC-ONEBFF-PLST-011 Get Promotion list - offset is invalid format.
  [Tags]  integration
  ${get_promotion_list_response}=  send request to get promotion list using get method with key, language and query parameter
  ...  ${access_key}
  ...  ${language.th}
  ...  type=${promotion_type_catalog}&limit=${promotion_list_limit}&offset=${invalid_promotion_list_offset}
  http response status from '${get_promotion_list_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_list_response}
  ...  400
  ...  ${promotion_offset.field_name}
  ...  ${promotion_offset.promotion_offset_is_invalid}

TC-ONEBFF-PLST-012 Get Promotion list - offset is missing.
  [Tags]  integration
  ${get_promotion_list_response}=  send request to get promotion list using get method with key, language and query parameter
  ...  ${access_key}
  ...  ${language.th}
  ...  type=${promotion_type_catalog}&limit=${promotion_list_limit}
  http response status from '${get_promotion_list_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_list_response}
  ...  400
  ...  ${promotion_offset.field_name}
  ...  ${promotion_offset.promotion_offset_is_required}

TC-ONEBFF-PLST-013 Get Promotion list - offset is empty.
  [Tags]  integration
  ${get_promotion_list_response}=  send request to get promotion list using get method with key, language and query parameter
  ...  ${access_key}
  ...  ${language.th}
  ...  type=${promotion_type_catalog}&limit=${promotion_list_limit}&offset=${EMPTY}
  http response status from '${get_promotion_list_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_list_response}
  ...  400
  ...  ${promotion_offset.field_name}
  ...  ${promotion_offset.promotion_offset_is_required}

TC-ONEBFF-PLST-014 Get Promotion list - key is invalid in header.
  [Tags]  integration
  ${get_promotion_list_response}=  send request to get promotion list using get method with key, language and query parameter
  ...  ${invalid_access_key}
  ...  ${language.th}
  ...  type=${promotion_type_catalog}&limit=${promotion_list_limit}&offset=${promotion_list_offset}
  http response status from '${get_promotion_list_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_list_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}

TC-ONEBFF-PLST-015 Get Promotion list - key is missing in header.
  [Tags]  integration
  ${get_promotion_list_response}=  send request to get promotion list using get method without key
  ...  ${language.th}
  ...  type=${promotion_type_catalog}&limit=${promotion_list_limit}&offset=${promotion_list_offset}
  http response status from '${get_promotion_list_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_list_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}

TC-ONEBFF-PLST-016 Get Promotion list - key is empty in header.
  [Tags]  integration
  ${get_promotion_list_response}=  send request to get promotion list using get method with key, language and query parameter
  ...  ${EMPTY}
  ...  ${language.th}
  ...  type=${promotion_type_catalog}&limit=${promotion_list_limit}&offset=${promotion_list_offset}
  http response status from '${get_promotion_list_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_list_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}

TC-ONEBFF-PLST-017 Get Promotion list - language is invalid in header.
  [Tags]  integration
  ${get_promotion_list_response}=  send request to get promotion list using get method with key, language and query parameter
  ...  ${access_key}
  ...  ${language.invalid}
  ...  type=${promotion_type_catalog}&limit=${promotion_list_limit}&offset=${promotion_list_offset}
  http response status from '${get_promotion_list_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_list_response}
  ...  400
  ...  ${accept_language.field_name}
  ...  ${accept_language.accept_language_is_invalid}

TC-ONEBFF-PLST-018 Get Promotion list - language is missing in header.
  [Tags]  integration
  ${get_promotion_list_response}=  send request to get promotion list using get method without language
  ...  ${access_key}
  ...  type=${promotion_type_catalog}&limit=${promotion_list_limit}&offset=${promotion_list_offset}
  http response status from '${get_promotion_list_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_list_response}
  ...  400
  ...  ${accept_language.field_name}
  ...  ${accept_language.accept_language_is_invalid}

TC-ONEBFF-PLST-019 Get Promotion list - language is empty in header.
  [Tags]  integration
  ${get_promotion_list_response}=  send request to get promotion list using get method with key, language and query parameter
  ...  ${access_key}
  ...  ${EMPTY}
  ...  type=${promotion_type_catalog}&limit=${promotion_list_limit}&offset=${promotion_list_offset}
  http response status from '${get_promotion_list_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_list_response}
  ...  400
  ...  ${accept_language.field_name}
  ...  ${accept_language.accept_language_is_invalid}