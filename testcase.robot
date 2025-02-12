*** Settings ***

Library  SeleniumLibrary

*** Variables ***
${URL}  https://www.practo.com
${SEARCH_BOX_XPATH}  //input[@data-qa-id='omni-searchbox-keyword']
${SUGGESTION_ITEM_XPATH}  (//div[contains(@class,'c-omni-suggestion-item')])[1]
${DOCTOR_LIST_XPATH}  (//h2[@data-qa-id='doctor_name'])[3]
${DOCTOR_URL_XPATH}  (//h2[@data-qa-id='doctor_name'])[1]/ancestor::a
${INFO_XPATH}  //span[contains(text(),'Info')]
${STORIES_XPATH}  //span[contains(text(),'Stories')][1]
${CONSULT_XPATH}  //span[contains(text(),'Consult Q&A')]
${HEALTHFEED_XPATH}  //span[contains(text(),'Healthfeed')][1]
${SPECIALIST}  Dentist

*** Test Cases ***
Verify the Doctors Profile Is Navigating to all fields like Info,Patient Stories,Etc.
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Search For Dentist
    Select A Doctor And Open Profile
    Interact With Doctor Profile Sections
    Close Browser

*** Keywords ***
Search For Dentist
    [Documentation]  We Are Selecting The Doctor With the specialization of dentist
    Wait Until Element Is Visible    ${SEARCH_BOX_XPATH}    timeout=10s
    Clear Element Text    ${SEARCH_BOX_XPATH}
    Input Text    ${SEARCH_BOX_XPATH}    ${SPECIALIST}
    Sleep    2s
    Click Element    ${SUGGESTION_ITEM_XPATH}

Select A Doctor And Open Profile
    [Documentation]  We are selecting the first dentist doctor profile.
    Wait Until Element Is Visible    ${DOCTOR_URL_XPATH}    timeout=10s
    ${DOCTOR_URL} =    Get Element Attribute    ${DOCTOR_URL_XPATH}    href
    Go To    ${DOCTOR_URL}

Interact With Doctor Profile Sections
    [Documentation]  Checking for the Doctor's Info,Patient Stories,Healthfeed,and answers written by doctor for any queries.
    Click And Scroll    ${INFO_XPATH}
    Click And Scroll    ${STORIES_XPATH}
    Click And Scroll    ${CONSULT_XPATH}
    Click And Scroll    ${HEALTHFEED_XPATH}
    Sleep    5s

Click And Scroll
    [Arguments]  ${ELEMENT}
    Click Element    ${ELEMENT}
    Scroll Down
    Scroll Back to Top
    Sleep    2s

Scroll Down
    Execute JavaScript    window.scrollBy(0, 400);
    Sleep    2s

Scroll Back to Top
    Execute JavaScript    window.scrollTo(0, 0);