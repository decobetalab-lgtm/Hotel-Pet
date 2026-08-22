# 🐾 Hotel Pet

### Sistema de gerenciamento de estadia de pets — visão do gerente

[![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)](https://en.wikipedia.org/wiki/HTML5)
[![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)](https://developer.mozilla.org/pt-BR/docs/CSS)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/decobetalab-lgtm/Hotel-Pet)
[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-222222?style=for-the-badge&logo=githubpages&logoColor=white)](https://decobetalab-lgtm.github.io/Hotel-Pet/login.html)

## 📌 Identificação Acadêmica

- **Universidade:** Universidade Estadual do Sudoeste da Bahia — UESB
- **Curso:** Superior de Tecnologia em Análise e Desenvolvimento de Sistemas — EAD
- **Disciplina:** Programação Web I
- **Professor:** Lucas Santos de Oliveira
- **Aluno:** Carlos André Sousa Luz
- **Atividade:** Trabalho Final — Hotel Pet

## 📋 Descrição

O **Hotel Pet** é uma interface web estática para representar a visão do gerente de um estabelecimento de hospedagem de animais. O projeto apresenta visualmente o gerenciamento de pets, usuários, reservas, perfil e configurações.

> **Esta versão é acadêmica e estática.**

Não implementa banco de dados, login real, cadastro persistente, backend, API, autenticação ou processamento no servidor. Todas as operações são simuladas por páginas HTML independentes.

## 🛠️ Tecnologias Utilizadas

- HTML5
- CSS3
- SVG
- Git
- GitHub
- GitHub Pages

Não há backend, banco de dados ou API nesta etapa do projeto.

## 📁 Estrutura do Projeto

```text
.github/workflows/deploy.yml
css/estilo.css
imagens/*.svg
16 páginas HTML
.gitignore
PLANO_COMMITS.md
README.md
```

## 🖼️ Recursos Visuais

A pasta `imagens/` é a única pasta gráfica do projeto, contendo:

- `logo.svg` — logotipo do Hotel Pet
- `avatar-ana.svg` — avatar da Ana
- `avatar-carlos.svg` — avatar do Carlos
- `avatar-joao.svg` — avatar do João
- `avatar-jose.svg` — avatar do José
- `avatar-maria.svg` — avatar de Maria

A pasta duplicada `images/` foi eliminada para evitar redundância de recursos. Todos os arquivos SVG são referenciados corretamente a partir de `imagens/`.

## 📄 Páginas da Aplicativo

| Página | Finalidade |
| -------- | ----------- |
| `login.html` | Entrada |
| `index.html` | Visão geral |
| `reservas.html` | Lista de reservas |
| `reserva_cadastrar.html` | Cadastro de reserva |
| `reserva_visualizar.html` | Detalhes da reserva |
| `reserva_editar.html` | Edição de reserva |
| `pets.html` | Lista de pets |
| `pet_cadastrar.html` | Cadastro de pet |
| `pet_visualizar.html` | Detalhes do pet |
| `pet_editar.html` | Edição de pet |
| `usuarios.html` | Lista de usuários |
| `usuario_cadastrar.html` | Cadastro de usuário |
| `usuario_visualizar.html` | Detalhes do usuário |
| `usuario_editar.html` | Edição de usuário |
| `perfil.html` | Perfil do gerente |
| `configuracoes.html` | Configurações de diária e vagas |

## 🔗 Navegação

```text
login.html
   ↓
index.html
   ├── Pets
   ├── Usuários
   ├── Reservas
   ├── Perfil
   └── Configurações
```

As operações são simuladas por páginas HTML independentes, sem navegação JavaScript ou redirecionamento lateral.

## ▶️ Execução Local

```bash
git clone https://github.com/decobetalab-lgtm/Hotel-Pet.git
cd Hotel-Pet
```

Abra qualquer página HTML (ex: `login.html`) diretamente em um navegador. Não é necessário servidor ou instalação de dependências. Como é uma aplicação estática, a navegação ocorre por links locais entre os arquivos.

## 🌐 GitHub Pages

- **Repositório:** https://github.com/decobetalab-lgtm/Hotel-Pet
- **Aplicação:** https://decobetalab-lgtm.github.io/Hotel-Pet/login.html

O projeto utiliza GitHub Pages com workflow em `.github/workflows/deploy.yml` para publicação automática na branch `gh-pages`.

## ✅ Validação

A publicação verifica referências locais dos atributos `href` e `src` das páginas HTML. A validação ajuda a identificar links ou recursos que tenham sido removidos ou apontados para caminhos incorretos.

## 📚 Escopo Acadêmico

O projeto está limitado à etapa de desenvolvimento de interface com HTML e CSS. Portanto, não implementa:

- banco de dados;
- backend;
- API;
- autenticação real;
- persistência de informações;
- processamento de cadastros no servidor.

As telas de cadastro, edição, consulta e reserva servem para demonstrar a estrutura e o fluxo visual propostos para o sistema.

## 👨‍💻 Autor

**Carlos André Sousa Luz**

GitHub: https://github.com/decobetalab-lgtm

---

Repositório: https://github.com/decobetalab-lgtm/Hotel-Pet
Página publicada: https://decobetalab-lgtm.github.io/Hotel-Pet/login.html