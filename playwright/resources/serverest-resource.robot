*** Settings ***
Library    Browser
Library    FakerLibrary
Library    DateTime


*** Variables ***
${BROWSER}        chromium
${HEADLESS}       ${false}
${URL}            https://front.serverest.dev/login
${NAME}           Eric
${SENHA}          12345

*** Keywords ***
Abrir o navegador
    New Browser    browser=${BROWSER}
    ...            headless=${HEADLESS}
    
    ${TRACE_NAME}      FakerLibrary.Uuid 4
    ${NOW}             Get Current Date    result_format=%d-%m-%Y_%H%M%S
    ${RECORD_VIDEO}    Create Dictionary    dir=${OUTPUT_DIR}/evidencies/videos/${NOW}
    
    New Context    viewport={'width': 1200, 'height': 800}
    ...            tracing=${OUTPUT_DIR}/evidencies/traces/${NOW}/${TRACE_NAME}.zip
    ...            recordVideo=${RECORD_VIDEO}

Ir para o site   
    New Page    url=${URL}
    ${title}    Get Title    ==   Front - ServeRest
    Log    ${title}

Cadastro o novo usuário
    Click    css=.btn-link
    # Click    text="Cadastre-se"
    # Click    css=a[data-testid='cadastrar']
    ${EMAIL}    FakerLibrary.Email
    Set Test Variable    ${EMAIL}
    Fill Text         //*[@id="nome"]      txt=${NAME}
    Fill Text         //*[@id="email"]     txt=${EMAIL}
    Fill Text         //*[@id="password"]  txt=${SENHA}
    Check Checkbox    //*[@id="administrador"]
    Click    xpath=//*[@id="root"]/div/div/form/div[5]/button >> text="Cadastrar"
    Sleep    5s


Conferir se o usuário foi cadastrado
    Wait For Elements State    h1    visible
    Get Text    h1    ==    Bem Vindo ${NAME}
    Get Element States    xpath=//*[@id="navbarTogglerDemo01"]/form/button    validate    value & visible

Criar usuário via API
    ${EMAIL}    FakerLibrary.Email
    Set Test Variable    ${EMAIL}
    ${resposta}    Http    url=https://serverest.dev/usuarios
    ...                    method=POST
    ...                    body={"nome": "Fulano da Silva","email": "${EMAIL}","password": "12345","administrador": "true"}
    
    Should Be Equal As Integers    ${resposta["status"]}    201

Logar com o usuário cadastrado via API
    ${resposta}    Http    url=https://serverest.dev/login
    ...                    method=POST
    ...                    body={"email": "${EMAIL}","password": "12345"}
    
    Should Be Equal As Integers    ${resposta["status"]}    200
    LocalStorage Set Item    serverest/userEmail    ${EMAIL}
    LocalStorage Set Item    serverest/userToken    ${resposta["body"]["authorization"]}
    LocalStorage Set Item    serverest/userNome     Fulano da Silva

    Go To    url=https://front.serverest.dev/admin/home

    Take Screenshot