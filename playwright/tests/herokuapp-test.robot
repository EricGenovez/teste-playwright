*** Settings ***
Resource    ../resources/herokuapp-resource.robot
Test Teardown    Tirar Print


*** Test Cases ***
Interagir com Dropdown
    Acessar "https://the-internet.herokuapp.com/dropdown"
    Selecionar opção "Option 2"

Interagir com Iframe
    Acessar "https://the-internet.herokuapp.com/iframe"
    Obter frase dentro do IFrame

Interagir com Tabela
    Acessar "https://the-internet.herokuapp.com/tables"
    Conferindo valores em tabelas 

Interagir com novas abas (pages)
    Acessar "https://the-internet.herokuapp.com/windows"
    ${pagina_id}    Get Page Ids    CURRENT
    Clicar e ir para nova página aberta
    Voltar para a página inicial    ${pagina_id}

