*** Settings ***
Resource  ../../import.robot

*** Keywords ***
send request to get address using get method with key
  [Arguments]  ${key}
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ...  Key=${key}
  ${response}=  get request  oneapp_bff_service  ${uri.info.get_address}  headers=${headers}
  [Return]  ${response}

send request to get address using get method without key
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ${response}=  get request  oneapp_bff_service  ${uri.info.get_address}  headers=${headers}
  [Return]  ${response}

success response body from '${response}' should return correct address data
  ${actual_response_body}=  set variable  ${response.json()}
  should be equal as integers  ${actual_response_body}[code]  ${200}
  should not be empty  ${actual_response_body}[data][0]
  ${address_file}=  get file  ${CURDIR}/../../resources/address.json
  ${json_address_file}=  evaluate  json.loads("""${address_file}""")  json
  ${string_address_file}=  convert to string  ${json_address_file}
  ${string_response_body}=  convert to string  ${response.json()}
  should be equal  ${string_response_body}  ${string_address_file}