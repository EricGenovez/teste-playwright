*** Settings ***
Library    Browser

*** Variables ***
${BROWSER}    chromium
${HEADLESS}   ${false}
${DROPDOWN}    //*[@id="dropdown"]

*** Keywords ***
Tirar Print
    Take Screenshot 

Acessar "${SITE}"
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Page       url=${SITE}

Selecionar opção "${OPTION}"
    Select Options By    xpath=${DROPDOWN}    text    ${OPTION}

Obter frase dentro do IFrame
    ${text}    Get Text    //*[@id="mce_0_ifr"] >>> //*[@id="tinymce"]
    Log    ${text}

Conferindo valores em tabelas
    ### Nessa etapa ele faz a conferencia pelo número da coluna e pelo número da linha, e confere se
    ### está correto utilizando a keyword Get Text + == pra conferencia
    Click    //*[@id="table1"]/thead/tr/th[1]/span >> text=Last Name
    ${elemento}    Get Table Cell Element    //*[@id="table1"]    1    3
    ${nome}    Get Text    ${elemento}    ==    Jason
    Log    ${nome}
    
    ### Nessa etapa ele busca pela valor da coluna que se chama "First Name" 
    ### pela linha que contenha o valor "http://www.jdoe.com"

    ${elemento}    Get Table Cell Element    //*[@id="table1"]    "First Name"    "http://www.jdoe.com"
    ${nome}    Get Text    ${elemento}    ==    Jason
    Log    ${nome}

# ${pagina_id}    Get Page Ids    CURRENT

Clicar e ir para nova página aberta
    Click    text="Click Here"
    Switch Page    NEW
    Get Text    h3    ==    New Window
    Tirar Print

Voltar para a página inicial
    [Arguments]    ${pagina_id}
    Switch Page    ${pagina_id}[0]     ### O número 0 representa a código do item da lista
    Tirar Print