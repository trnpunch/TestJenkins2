*** Settings ***
Resource  ../../import.robot
Resource  ../../keywords/clubcard/get_cc_card_info_keywords.robot

*** Test Cases ***
TC-ONEBFF-CARD-001 get cc card info - success - key is correct in header.
  [Tags]  integration
  ${get_cc_card_info_response}=  send request to get cc card info using get method with key
  ...  ${access_key}
  http response status from '${get_cc_card_info_response}' should be '200'
  success response body from '${get_cc_card_info_response}' should return correct cc card infomation

TC-ONEBFF-CARD-002 get cc card info - key is missing in header.
  [Tags]  integration
  ${get_cc_card_info_response}=  send request to get cc card info using get method without key
  http response status from '${get_cc_card_info_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_cc_card_info_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}

TC-ONEBFF-CARD-003 get cc card info - key is invalid in header.
  [Tags]  integration
  ${get_cc_card_info_response}=  send request to get cc card info using get method with key
  ...  ${invalid_access_key}
  http response status from '${get_cc_card_info_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_cc_card_info_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}

TC-ONEBFF-CARD-004 get cc card info - key is empty in header.
  [Tags]  integration
  ${get_cc_card_info_response}=  send request to get cc card info using get method with key
  ...  ${EMPTY}
  http response status from '${get_cc_card_info_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_cc_card_info_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}