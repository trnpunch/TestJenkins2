*** Settings ***
Resource  ../../import.robot
Resource  ../../keywords/info/get_display_feature_status_keywords.robot

*** Test Cases ***
TC-ONEBFF-FST-001 Get Display Feature Status - success - key is correct in header.
  [Tags]  integration
  ${get_display_feature_status_response}=  send request to get display feature status using get method with key
  ...  ${access_key}
  http response status from '${get_display_feature_status_response}' should be '200'
  success response body from '${get_display_feature_status_response}' should return correct display feature status

TC-ONEBFF-FST-002 Get Display Feature Status - key is missing in header.
  [Tags]  integration
  ${get_display_feature_status_response}=  send request to get display feature status using get method without key
  http response status from '${get_display_feature_status_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_display_feature_status_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}

TC-ONEBFF-FST-003 Get Display Feature Status - key is invalid in header.
  [Tags]  integration
  ${get_display_feature_status_response}=  send request to get display feature status using get method with key
  ...  ${invalid_access_key}
  http response status from '${get_display_feature_status_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_display_feature_status_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}

TC-ONEBFF-FST-004 Get Display Feature Status - key is empty in header.
  [Tags]  integration
  ${get_display_feature_status_response}=  send request to get display feature status using get method with key
  ...  ${EMPTY}
  http response status from '${get_display_feature_status_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${get_display_feature_status_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}