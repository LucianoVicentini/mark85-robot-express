*** Settings ***
Documentation        Cenários de autenticação do usuario

Library         Collections
Resource        ../resources/base.resource

Test Setup          Start Session
Test Teardown       Take Screenshot
Library    ../resources/libs/database.py

*** Test Cases ***
Deve poder cadastrar com um usuário pré-cadastrado
    
    ${user}    Create Dictionary
    ...        name=Fernando Papito
    ...        email=papito@msn.com
    ...        password=123456       

    Remove user from database        ${user}[email]
    Insert user from data base       ${user}    

    Submit login form                ${user}     
    User Should be logged in         ${user}[name]                         
    
Não deve logar com senha inválida

    ${user}    Create Dictionary
    ...        name=Steve Woz
    ...        email=waz@apple.com
    ...        password=123456       

    Remove user from database        ${user}[email]
    Insert user from data base       ${user}    

    Set To Dictionary    ${user}    password=abc123    

    Submit login form                ${user}   
    Notice should be                 Ocorreu um erro ao fazer login, verifique suas credenciais.  