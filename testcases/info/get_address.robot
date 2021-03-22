*** Settings ***
Resource  ../../import.robot
Resource  ../../keywords/info/get_address_keywords.robot

*** Test Cases ***
TC-ONEBFF-ADD-001 Get Addresses - success - key is correct in header.
  [Tags]  integration
  ${get_address_response}=  send request to get address using get method with key
  ...  ${access_key}
  http response status from '${get_address_response}' should be '200'
  success response body from '${get_address_response}' should return correct address data

TC-ONEBFF-ADD-002 Get Addresses - key is missing in header.
  [Tags]  integration
  ${get_address_response}=  send request to get address using get method without key
  http response status from '${get_address_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_address_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}

TC-ONEBFF-ADD-003 Get Addresses - key is invalid in header.
  [Tags]  integration
  ${get_address_response}=  send request to get address using get method with key
  ...  ${invalid_access_key}
  http response status from '${get_address_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_address_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}

TC-ONEBFF-ADD-004 Get Addresses - key is empty in header.
  [Tags]  integration
  ${get_address_response}=  send request to get address using get method with key
  ...  ${EMPTY}
  http response status from '${get_address_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_address_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}