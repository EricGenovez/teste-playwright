*** Settings ***
Library    Browser
Library    FakerLibrary

*** Variables ***
${BROWSER}    chromium
${HEADLESS}   ${false}
${URL}        https://front.serverest.dev/login
${SENHA}      12345

### Variaveis resources
${INPUT_NOME}          //*[@id="nome"]
${INPUT_PREÇO}         //*[@id="price"]
${TEXTAREA_DESC}       //*[@id="description"]
${INPUT_QTD}           //*[@id="quantity"]
${ARQUIVO}             //*[@id="imagem"]
${FILE}                \juninho.jpg
${BUTTON_CADASTRAR}    //*[@id="root"]/div/div/div/form/div[6]/div/button


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

Cadastrar um novo produto
    Click    //*[@id="root"]/div/div/p[2]/div[4]/div/div/a
    ${title}     Get Text    h1  ==  Cadastro de Produtos
    ${PRODUTO}   FakerLibrary.Language Name
    Fill Text    ${INPUT_NOME}    ${PRODUTO}
    Set Test Variable    ${PRODUTO}
    Fill Text    ${INPUT_PREÇO}    2
    Fill Text    ${TEXTAREA_DESC}    txt=Testetestetestetestestestestesteste
    Fill Text    ${INPUT_QTD}    2
    Upload File By Selector    ${ARQUIVO}    ${FILE}
    Click        ${BUTTON_CADASTRAR}

Conferir que o produto aparece na listagem
    ${elemento}   Get Table Cell Element    css=table    "Descrição"    "${PRODUTO}"
    ${descricao}  Get Text  ${elemento}  ==  Testetestetestetestestestestesteste
    Highlight Elements    ${elemento}
    Take Screenshot       fullPage=${true}
