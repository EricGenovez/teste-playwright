*** Settings ***
Library    Browser
Library    FakerLibrary


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
    New Context    viewport={"width": 1200, 'height': 800}

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