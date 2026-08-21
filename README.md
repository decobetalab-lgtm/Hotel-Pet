# Hotel Pet

Sistema de gerenciamento de estadia de pets - visao do gerente.

Projeto desenvolvido para a disciplina de Programacao Web I, utilizando apenas HTML e CSS.

## Tecnologias

- HTML5
- CSS3
- SVG para icones e avatares

## Estrutura do projeto

```
hotelpet/
├── css/
│   └── estilo.css
├── imagens/
│   ├── logo.svg
│   ├── avatar-ana.svg
│   ├── avatar-carlos.svg
│   ├── avatar-joao.svg
│   ├── avatar-jose.svg
│   └── avatar-maria.svg
├── index.html
├── login.html
├── perfil.html
├── configuracoes.html
├── pets.html
├── pet_cadastrar.html
├── pet_visualizar.html
├── pet_editar.html
├── usuarios.html
├── usuario_cadastrar.html
├── usuario_visualizar.html
├── usuario_editar.html
├── reservas.html
├── reserva_cadastrar.html
├── reserva_visualizar.html
├── reserva_editar.html
└── README.md
```

## Paginas

1. `login.html` - Tela de entrada do sistema.
2. `index.html` - Visao geral do hotel.
3. `reservas.html` - Lista de reservas.
4. `reserva_cadastrar.html` - Nova reserva.
5. `reserva_visualizar.html` - Detalhes da reserva.
6. `reserva_editar.html` - Edicao de reserva.
7. `pets.html` - Lista de pets.
8. `pet_cadastrar.html` - Cadastro de pet.
9. `pet_visualizar.html` - Detalhes do pet.
10. `pet_editar.html` - Edicao de pet.
11. `usuarios.html` - Lista de usuarios.
12. `usuario_cadastrar.html` - Cadastro de usuario.
13. `usuario_visualizar.html` - Detalhes do usuario.
14. `usuario_editar.html` - Edicao de usuario.
15. `perfil.html` - Perfil do gerente logado.
16. `configuracoes.html` - Configuracao de diaria e vagas.

## Como visualizar localmente

Abra o arquivo `login.html` em um navegador. A navegacao entre as telas funciona por links, sem backend.

## Como publicar no GitHub Pages

O repositorio possui um workflow em `.github/workflows/deploy.yml` que publica automaticamente o site na branch `gh-pages`.

Para ativar:

1. Acesse `Settings > Pages` do repositorio.
2. Em **Source**, selecione **Deploy from a branch**.
3. Selecione a branch `gh-pages` e a pasta `/ (root)`.
4. Salve.

O workflow sera executado automaticamente a cada push na branch `main`. Voce tambem pode executa-lo manualmente na aba **Actions**.

O site estara disponivel em:
```
https://decobetalab-lgtm.github.io/Hotel-Pet/login.html
```

## Autor

Carlos Luz - @decobetalab-lgtm
