*** Settings ***
Resource  ../../import.robot
Resource  ../../keywords/version/check_version_detail_keywords.robot

*** Variables ***
${os_android}  ANDROID
${os_ios}  IOS
${request_app_version}  1.1.0
${over_latest_version}  30.0.0
${under_latest_version}  0.0.1

*** Test Cases ***
TC-ONEBFF-VER-001 Check version - ANDROID - success - your_version is force_version.
  [Tags]  integration
  ${check_version_response}=  send request to check version detail using post method with app detail
  ...  ${access_key}
  ...  ${os_android}
  ...  ${request_app_version}
  http response status from '${check_version_response}' should be '200'
  success response body should return app version detail, forced status and updated status
  ...  ${check_version_response}
  ...  ${os_android}
  ...  ${request_app_version}
  ...  ${FALSE}
  ...  ${TRUE}

TC-ONEBFF-VER-002 Check version - IOS - success - your_version is force_version.
  [Tags]  integration
  ${check_version_response}=  send request to check version detail using post method with app detail
  ...  ${access_key}
  ...  ${os_ios}
  ...  ${request_app_version}
  http response status from '${check_version_response}' should be '200'
  success response body should return app version detail, forced status and updated status
  ...  ${check_version_response}
  ...  ${os_ios}
  ...  ${request_app_version}
  ...  ${FALSE}
  ...  ${TRUE}

TC-ONEBFF-VER-003 Check version - ANDROID - success - your_version later than force_version
  [Tags]  integration
  ${check_version_response}=  send request to check version detail using post method with app detail
  ...  ${access_key}
  ...  ${os_android}
  ...  ${over_latest_version}
  http response status from '${check_version_response}' should be '200'
  success response body should return app version detail, forced status and updated status
  ...  ${check_version_response}
  ...  ${os_android}
  ...  ${over_latest_version}
  ...  ${FALSE}
  ...  ${TRUE}

TC-ONEBFF-VER-004 Check version - IOS - success - your_version later than force_version
  [Tags]  integration
  ${check_version_response}=  send request to check version detail using post method with app detail
  ...  ${access_key}
  ...  ${os_ios}
  ...  ${over_latest_version}
  http response status from '${check_version_response}' should be '200'
  success response body should return app version detail, forced status and updated status
  ...  ${check_version_response}
  ...  ${os_ios}
  ...  ${over_latest_version}
  ...  ${FALSE}
  ...  ${TRUE}

TC-ONEBFF-VER-005 Check version - ANDROID - success - your_version lower than force_version
  [Tags]  integration
  ${check_version_response}=  send request to check version detail using post method with app detail
  ...  ${access_key}
  ...  ${os_android}
  ...  ${under_latest_version}
  http response status from '${check_version_response}' should be '200'
  success response body should return app version detail, forced status and updated status
  ...  ${check_version_response}
  ...  ${os_android}
  ...  ${under_latest_version}
  ...  ${TRUE}
  ...  ${FALSE}

TC-ONEBFF-VER-006 Check version - IOS - success - your_version lower than force_version.
  [Tags]  integration
  ${check_version_response}=  send request to check version detail using post method with app detail
  ...  ${access_key}
  ...  ${os_ios}
  ...  ${under_latest_version}
  http response status from '${check_version_response}' should be '200'
  success response body should return app version detail, forced status and updated status
  ...  ${check_version_response}
  ...  ${os_ios}
  ...  ${under_latest_version}
  ...  ${TRUE}
  ...  ${FALSE}

TC-ONEBFF-VER-007 Check version - version is invalid format.
  [Tags]  integration
  ${check_version_response}=  send request to check version detail using post method with app detail
  ...  ${access_key}
  ...  ${os_ios}
  ...  1.0.A
  http response status from '${check_version_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${check_version_response}
  ...  400
  ...  ${version.field_name}
  ...  ${version.version_is_invalid}

TC-ONEBFF-VER-008 Check version - version is missing.
  [Tags]  integration
  ${check_version_response}=  send request to check version detail using post method without version
  ...  ${access_key}
  ...  ${os_ios}
  http response status from '${check_version_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${check_version_response}
  ...  400
  ...  ${version.field_name}
  ...  ${version.version_is_required}

TC-ONEBFF-VER-009 Check version - version is empty.
  [Tags]  integration
  ${check_version_response}=  send request to check version detail using post method with app detail
  ...  ${access_key}
  ...  ${os_ios}
  ...  ${EMPTY}
  http response status from '${check_version_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${check_version_response}
  ...  400
  ...  ${version.field_name}
  ...  ${version.version_is_required}

TC-ONEBFF-VER-010 Check version - os is invalid format.
  [Tags]  integration
  ${check_version_response}=  send request to check version detail using post method with app detail
  ...  ${access_key}
  ...  iOS
  ...  ${request_app_version}
  http response status from '${check_version_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${check_version_response}
  ...  400
  ...  ${os.field_name}
  ...  ${os.os_is_invalid}

TC-ONEBFF-VER-011 Check version - os is missing.
  [Tags]  integration
  ${check_version_response}=  send request to check version detail using post method without os
  ...  ${access_key}
  ...  ${request_app_version}
  http response status from '${check_version_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${check_version_response}
  ...  400
  ...  ${os.field_name}
  ...  ${os.os_is_required}

TC-ONEBFF-VER-012 Check version - os is empty.
  [Tags]  integration
  ${check_version_response}=  send request to check version detail using post method with app detail
  ...  ${access_key}
  ...  ${EMPTY}
  ...  ${request_app_version}
  http response status from '${check_version_response}' should be '400'
  error response body should return error detail with code, field and msg
  ...  ${check_version_response}
  ...  400
  ...  ${os.field_name}
  ...  ${os.os_is_required}

TC-ONEBFF-VER-013 Check version - key is invalid in header.
  [Tags]  integration
  ${check_version_response}=  send request to check version detail using post method with app detail
  ...  ${invalid_access_key}
  ...  ${os_android}
  ...  ${request_app_version}
  http response status from '${check_version_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${check_version_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}

TC-ONEBFF-VER-014 Check version - key is missing in header.
  ${check_version_response}=  send request to check version detail using post method without key
  ...  ${os_android}
  ...  ${request_app_version}
  http response status from '${check_version_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${check_version_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}

TC-ONEBFF-VER-015 Check version - key is empty in header.
  ${check_version_response}=  send request to check version detail using post method with app detail
  ...  ${EMPTY}
  ...  ${os_android}
  ...  ${request_app_version}
  http response status from '${check_version_response}' should be '401'
  error response body should return error detail with code, field and msg
  ...  ${check_version_response}
  ...  401
  ...  ${key.field_name}
  ...  ${key.key_is_invalid}