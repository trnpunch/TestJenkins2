*** Settings ***
Resource  ../../import.robot

*** Keywords ***
send request to get app setting url using get method with key
  [Arguments]  ${key}
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ...  Key=${key}
  ${response}=  get request  oneapp_bff_service  ${uri.info.get_app_setting_url}  headers=${headers}
  [Return]  ${response}

send request to get app setting url using get method without key
  ${x-request-id}=  generate x-request id
  create session  oneapp_bff_service  ${oneapp_bff_url}  verify=True
  ${headers}=  create dictionary
  ...  Content-Type=application/json
  ...  X-Request-Id=rb-${x-request-id}
  ${response}=  get request  oneapp_bff_service  ${uri.info.get_app_setting_url}  headers=${headers}
  [Return]  ${response}

success response body from '${response}' should return correct app setting url
  ${actual_response_body}=  set variable  ${response.json()}
  should be equal as integers  ${actual_response_body}[code]  ${200}
  should not be empty  ${actual_response_body}[data]
  ${main_item_count}=  get length  ${actual_response_body}[data]
  should be equal  ${main_item_count}  ${2}
  should not be empty  ${actual_response_body}[data][th]
  ${th_item_count}=  get length  ${actual_response_body}[data][th]
  should be equal  ${th_item_count}  ${6}
  should not be empty  ${actual_response_body}[data][en]
  ${en_item_count}=  get length  ${actual_response_body}[data][en]
  should be equal  ${en_item_count}  ${6}
  should be equal  ${actual_response_body}[data][th][about_clubcard_url]  https://www.tescolotus.com/clubcard
  should be equal  ${actual_response_body}[data][th][app_feedback_url]  https://www.tescolotus.com/clubcard/contact
  should be equal  ${actual_response_body}[data][th][faq_url]  https://www.tescolotus.com/clubcard/faqs
  should be equal  ${actual_response_body}[data][th][contact_us_phone]  1712
  should be equal  ${actual_response_body}[data][th][term_of_use_url]  https://www.tescolotus.com/terms
  should be equal  ${actual_response_body}[data][th][privacy_policy_url]  https://www.tescolotus.com/privacy
  should be equal  ${actual_response_body}[data][en][about_clubcard_url]  https://www.tescolotus.com/en/clubcard
  should be equal  ${actual_response_body}[data][en][app_feedback_url]  https://www.tescolotus.com/en/clubcard/contact
  should be equal  ${actual_response_body}[data][en][faq_url]  https://www.tescolotus.com/en/clubcard/faqs
  should be equal  ${actual_response_body}[data][en][contact_us_phone]  1712
  should be equal  ${actual_response_body}[data][en][term_of_use_url]  https://www.tescolotus.com/en/terms
  should be equal  ${actual_response_body}[data][en][privacy_policy_url]  https://www.tescolotus.com/en/privacy