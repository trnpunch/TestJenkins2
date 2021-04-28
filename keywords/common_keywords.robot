*** Settings ***
Resource  ../import.robot

*** Keywords ***
generate x-request id
  ${uuid}  evaluate  uuid.uuid4()  uuid
  ${x-request-id}  convert to string  ${uuid}
  [Return]  ${x-request-id}

error response body should return error detail with code, field and msg
  [Arguments]  ${response}  ${expected_error_code}  ${expected_error_field}  ${expected_error_msg}
  ${actual_response_body}=  set variable  ${response.json()}
  should be equal as integers  ${actual_response_body}[code]  ${${expected_error_code}}
  should be equal as strings  ${actual_response_body}[error][${expected_error_field}][0]  ${expected_error_msg}

error response body should return error detail with code, field and multiple msg
  [Arguments]  ${response}  ${expected_error_code}  ${expected_error_field_1}  ${expected_error_msg_1}  ${expected_error_field_2}  ${expected_error_msg_2}
  ${actual_response_body}=  set variable  ${response.json()}
  should be equal as integers  ${actual_response_body}[code]  ${${expected_error_code}}
  should be equal as strings  ${actual_response_body}[error][${expected_error_field_1}][0]  ${expected_error_msg_1}
  should be equal as strings  ${actual_response_body}[error][${expected_error_field_2}][0]  ${expected_error_msg_2}

error response body should return error detail with code and error
  [Arguments]  ${response}  ${expected_error_code}  ${expected_error}
  ${actual_response_body}=  set variable  ${response.json()}
  should be equal as integers  ${actual_response_body}[code]  ${${expected_error_code}}
  should be equal as strings  ${actual_response_body}[error]  ${expected_error}

http response status from '${response}' should be '${expected_http_response_status}'
  should be equal as integers  ${response.status_code}  ${${expected_http_response_status}}  invalid http status

  