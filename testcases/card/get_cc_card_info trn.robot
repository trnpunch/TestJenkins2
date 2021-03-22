*** Settings ***
Resource  ../../import.robot
Resource  ../../keywords/clubcard/get_cc_card_info_keywords.robot

*** Test Cases ***
TC-ONEBFF-CARD-001 get cc card info - success - key is correct in header.
  [Tags]  integration
  ${get_cc_card_info_response}=  send request to get cc card info using get method with key
  ...  ${access_key}
  log to console   ${\n}${access_key}
  ${actual_response_body}=  set variable  ${get_cc_card_info_response.json()}
  log to console   ${actual_response_body}
  should be equal as integers  ${actual_response_body}[code]  ${200}
  should not be empty  ${actual_response_body}[data]
  ${main_item_count}=  get length  ${actual_response_body}[data]
  should be equal  ${main_item_count}  ${2}
  should not be empty  ${actual_response_body}[data][image_url]
  should not be empty  ${actual_response_body}[data][last_modified]
  log to console   ${get_cc_card_info_response.status_code}

  http response status from '${get_cc_card_info_response}' should be '200'
  success response body from '${get_cc_card_info_response}' should return correct cc card infomation


# TC-ONEBFF-CARD-002
#   [Tags]  integration
#   ${get_cc_card_info_response}=  send request to get cc card info using get method without key
#   http response status from '${get_cc_card_info_response}' should be '401'
  
  
#   log to console   ${actual_response_body}
#   error response body should return error detail with code, field and msg
#   ...  ${get_cc_card_info_response}
#   ...  401
#   ...  ${key.field_name}
#   ...  ${key.key_is_invalid}
#   log to console  ${key}


# TC-ONEBFF-CARD-003 
#   [Tags]  integration
#   ${get_cc_card_info_response}=  send request to get cc card info using get method with key
#   ...  ${invalid_access_key}

#   ${actual_response_body}=  set variable  ${get_cc_card_info_response.json()}
#   should be equal as integers  ${get_cc_card_info_response.status_code}   401
#   should be equal as integers  ${actual_response_body}[code]    401
#   should not be empty  ${actual_response_body}[error]
#   should not be empty  ${actual_response_body}[error][key]  ${key.key_is_invalid}
#   ${actual_response_body}[error][${expected_error_field}][0]  
#   log to console   ${\n} ${actual_response_body}
#   # should be equal  ${actual_response_body}[data]  ${key.key_is_invalid}
  



