*** Settings ***
Resource  ../../import.robot
Resource  ../../keywords/info/get_voucher_keywords.robot

*** Test Cases ***
TC-ONEBFF-VCH-001 Get Voucher - success - key is correct in header.
  [Tags]  integration
  ${get_voucher_response}=  send request to get voucher using get method with key
  ...  ${access_key}
  http response status from '${get_voucher_response}' should be '200'
  success response body from '${get_voucher_response}' should return correct voucher

TC-ONEBFF-VCH-002 Get Voucher - key is missing in header.
  [Tags]  integration
  ${get_voucher_response}=  send request to get voucher using get method without key
  http response status from '${get_voucher_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_voucher_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}

TC-ONEBFF-VCH-003 Get Voucher - key is invalid in header.
  [Tags]  integration
  ${get_voucher_response}=  send request to get voucher using get method with key
  ...  ${invalid_access_key}
  http response status from '${get_voucher_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_voucher_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}

TC-ONEBFF-VCH-004 Get Voucher - key is empty in header.
  [Tags]  integration
  ${get_voucher_response}=  send request to get voucher using get method with key
  ...  ${EMPTY}
  http response status from '${get_voucher_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_voucher_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}