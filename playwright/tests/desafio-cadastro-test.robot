*** Settings ***
Resource    ../resources/desafio-cadastro-resource.robot


*** Test Cases ***
Cadastrar Novo usuário
    Cadastrar novo usuário
    Cadastrar um novo produto
    Conferir que o produto aparece na listagem