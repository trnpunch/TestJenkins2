*** Settings ***
Resource  ../../import.robot
Resource  ../../keywords/promotion/get_promotion_detail_keywords.robot
Variables  ../../resources/test_data/${ENV}/promotion.yaml

*** Variables ***
${not_exist_promotion_id}  145d46c4-b88f-482c-bfda-5e2828c5aaaa
${invalid_promotion_id}  145d46c4-b88f-482c-bfda-5e2828c5aaaa-a

*** Test Cases ***
TC-ONEBFF-PDT-001 Get Promotion Detail - success - catalog promotion_id is exist
  [Tags]  integration
  ${get_promotion_detail_response}=  send request to get promotion detail using get method with key, language and promotion_id
  ...  ${access_key}
  ...  ${language.th}
  ...  ${catalog_promotion.id}
  http response status from '${get_promotion_detail_response}' should be '200'
  success response body from '${get_promotion_detail_response}' should return catalog promotion detail

TC-ONEBFF-PDT-002 Get Promotion Detail - promotion_id is not exist
  [Tags]  integration
  ${get_promotion_detail_response}=  send request to get promotion detail using get method with key, language and promotion_id
  ...  ${access_key}
  ...  ${language.th}
  ...  ${not_exist_promotion_id}
  http response status from '${get_promotion_detail_response}' should be '403'
  error response body should return error detail with code and error
  ...  ${get_promotion_detail_response}
  ...  403
  ...  ${NULL}

TC-ONEBFF-PDT-003 Get Promotion Detail - promotion_id is invalid format
  [Tags]  integration
  ${get_promotion_detail_response}=  send request to get promotion detail using get method with key, language and promotion_id
  ...  ${access_key}
  ...  ${language.th}
  ...  ${invalid_promotion_id}
  http response status from '${get_promotion_detail_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_detail_response}
  ...  400
  ...  ${promotion_id.field_name}
  ...  ${promotion_id.promotion_id_is_invalid}

TC-ONEBFF-PDT-004 Get Promotion Detail - key is invalid in header.
  [Tags]  integration
  ${get_promotion_detail_response}=  send request to get promotion detail using get method with key, language and promotion_id
  ...  ${invalid_access_key}
  ...  ${language.th}
  ...  ${catalog_promotion.id}
  http response status from '${get_promotion_detail_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_detail_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}

TC-ONEBFF-PDT-005 Get Promotion Detail - key is missing in header.
  [Tags]  integration
  ${get_promotion_detail_response}=  send request to get promotion detail using get method without key
  ...  ${language.th}
  ...  ${catalog_promotion.id}
  http response status from '${get_promotion_detail_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_detail_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}

TC-ONEBFF-PDT-006 Get Promotion Detail - key is empty in header.
  [Tags]  integration
  ${get_promotion_detail_response}=  send request to get promotion detail using get method with key, language and promotion_id
  ...  ${EMPTY}
  ...  ${language.th}
  ...  ${catalog_promotion.id}
  http response status from '${get_promotion_detail_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_detail_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}

TC-ONEBFF-PDT-007 Get Promotion Detail - language is invalid in header.
  [Tags]  integration
  ${get_promotion_detail_response}=  send request to get promotion detail using get method with key, language and promotion_id
  ...  ${access_key}
  ...  ${language.invalid}
  ...  ${catalog_promotion.id}
  http response status from '${get_promotion_detail_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_detail_response}
  ...  400
  ...  ${accept_language.field_name}
  ...  ${accept_language.accept_language_is_invalid}

TC-ONEBFF-PDT-008 Get Promotion Detail - language is missing in header.
  [Tags]  integration
  ${get_promotion_detail_response}=  send request to get promotion detail using get method without language
  ...  ${access_key}
  ...  ${catalog_promotion.id}
  http response status from '${get_promotion_detail_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_detail_response}
  ...  400
  ...  ${accept_language.field_name}
  ...  ${accept_language.accept_language_is_invalid}

TC-ONEBFF-PDT-009 Get Promotion Detail - language is empty in header.
  [Tags]  integration
  ${get_promotion_detail_response}=  send request to get promotion detail using get method with key, language and promotion_id
  ...  ${access_key}
  ...  ${EMPTY}
  ...  ${catalog_promotion.id}
  http response status from '${get_promotion_detail_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${get_promotion_detail_response}
  ...  400
  ...  ${accept_language.field_name}
  ...  ${accept_language.accept_language_is_invalid}

TC-ONEBFF-PDT-010 Get Promotion Detail - success - event promotion_id is exist
  [Tags]  not_ready
  ${get_promotion_detail_response}=  send request to get promotion detail using get method with key, language and promotion_id
  ...  ${access_key}
  ...  ${language.th}
  ...  ${event_promotion.id}
  http response status from '${get_promotion_detail_response}' should be '200'
  success response body from '${get_promotion_detail_response}' should return event promotion detail