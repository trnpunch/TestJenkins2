*** Settings ***
Resource  ../../import.robot
Resource  ../../keywords/info/get_app_setting_url_keywords.robot

*** Test Cases ***
TC-ONEBFF-STT-001 Get App Setting URL - success - key is correct in header.
  [Tags]  integration
  ${get_app_setting_url_response}=  send request to get app setting url using get method with key
  ...  ${access_key}
  http response status from '${get_app_setting_url_response}' should be '200'
  success response body from '${get_app_setting_url_response}' should return correct app setting url

TC-ONEBFF-STT-002 Get App Setting URL - key is missing in header.
  [Tags]  integration
  ${get_app_setting_url_response}=  send request to get app setting url using get method without key
  http response status from '${get_app_setting_url_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_app_setting_url_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}

TC-ONEBFF-STT-003 Get App Setting URL - key is invalid in header.
  [Tags]  integration
  ${get_app_setting_url_response}=  send request to get app setting url using get method with key
  ...  ${invalid_access_key}
  http response status from '${get_app_setting_url_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_app_setting_url_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}

TC-ONEBFF-STT-004 Get App Setting URL - key is empty in header.
  [Tags]  integration
  ${get_app_setting_url_response}=  send request to get app setting url using get method with key
  ...  ${EMPTY}
  http response status from '${get_app_setting_url_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_app_setting_url_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}