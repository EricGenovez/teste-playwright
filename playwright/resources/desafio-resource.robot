*** Settings ***
Library    Browser
Library    FakerLibrary

*** Variables ***
${BROWSER}    chromium
${HEADLESS}   ${false}
${URL}        https://front.serverest.dev/login
${SENHA}      12345

*** Keywords *** 
Tirar print
    Take Screenshot

Abrir o navegador
    New Browser    browser=${BROWSER}
    ...            headless=${HEADLESS}
    New Context    viewport={"width":1280, 'height':800}
Ir para o site
    New Page    url=${URL}
    ${title}    Get Title    ==    Front - ServeRest
    Log         ${title}

Cadastrar novo usuário
    Abrir o navegador
    Ir para o site
    ${NAME}    FakerLibrary.Name
    Set Test Variable    ${NAME}
    Click    //*[@id="root"]/div/div/form/small/a
    ${EMAIL}    FakerLibrary.Email
    Set Test Variable    ${EMAIL}
    Fill Text    //*[@id="nome"]        ${NAME}
    Fill Text    //*[@id="email"]       ${EMAIL}
    Fill Text    //*[@id="password"]    ${SENHA}
    Check Checkbox    //*[@id="administrador"]
    Click    text="Cadastrar"
    ${title}    Get Text    h1    ==    Bem Vindo ${NAME}
    Log    ${title}    

Acessar a Lista de usuários
    Click    //*[@id="root"]/div/div/p[2]/div[3]/div/div/a
    ${LISTA}    Get Text    h1    ==    Lista dos usuários
Conferir se o usuário aparece na listagem
    ${TABELA}    Get Table Cell Element    //*[@id="root"]/div/div/p/table   "Nome"    "${EMAIL}"
    ${NOME}    Get Text    ${TABELA}    ==    ${NAME}
    Log    ${NOME}