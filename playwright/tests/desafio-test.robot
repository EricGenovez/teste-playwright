*** Settings ***
Resource    ../resources/desafio-resource.robot
Task Teardown   Tirar print

*** Test Cases ***
Desafio Playwright
    Cadastrar novo usuário
    Acessar a Lista de usuários
    Conferir se o usuário aparece na listagem

