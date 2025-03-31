*** Settings ***
Resource    ../Resources/serverest-resource.robot


*** Test Cases ***
Login com sucesso serverest
    Abrir o navegador
    Ir para o site 
    Cadastro o novo usuário
    Conferir se o usuário foi cadastrado