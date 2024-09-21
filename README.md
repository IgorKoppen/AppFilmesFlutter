# Movie App

## Descrição

O **Movie App** é um aplicativo incrível que permite aos usuários explorar uma vasta biblioteca de filmes. Com ele, você pode:
- Ver detalhes dos filmes.
- Buscar por filmes específicos.
- Procurar filmes similares.
- Ler reviews de filmes.

## Funcionalidades

- **Detalhes do Filme**: Veja informações detalhadas sobre qualquer filme.
- **Buscar Filme**: Realize buscas personalizadas para encontrar exatamente o que você deseja assistir.
- **Filmes Similares**: Descubra filmes similares aos que você gostou.
- **Reviews**: Leia análises e reviews de outros usuários sobre os filmes.

## Como Usar

1. Clone o repositório:
    ```bash
    git clone https://github.com/seu-usuario/movie-app.git
    ```
2. Navegue até o diretório do projeto:
    ```bash
    cd MovieApp
    ```
3. Instale as dependências:
    ```bash
    flutter pub get
    ```
4. Execute o aplicativo:
    ```bash
    flutter run
    ```

## Estrutura do Código

- **HomePage**: A página principal que exibe as categorias de filmes como "Now Playing", "Popular" e "Upcoming".
- **ApiServices**: Classe responsável por fazer as chamadas à API e fornecer os dados dos filmes.
- **TopRatedPage**: Página que exibe uma lista dos filmes mais bem avaliados (Top Rated).
- **search_page.**: Página que para buscar um filme específico com base no nome.
  
## API Utilizada

Este aplicativo utiliza a [The Movie Database (TMDb) API](https://www.themoviedb.org/documentation/api) para buscar informações sobre filmes. Certifique-se de obter a sua própria API key e configurar no aplicativo.

## Exemplos

### Tela Principal
![Tela Principal](https://raw.githubusercontent.com/IgorKoppen/MovieApp/refs/heads/main/DocsImagens/Home.png?token=GHSAT0AAAAAACWZUJFENBVYXHOCWWT55CDCZXOJOQQ)
![Tela Principal](https://raw.githubusercontent.com/IgorKoppen/MovieApp/refs/heads/main/DocsImagens/Home2.png?token=GHSAT0AAAAAACWZUJFFRGI3D3TSNND2CAJQZXOJSBA)

### Detalhes do Filme
![Detalhes do Filme](https://raw.githubusercontent.com/IgorKoppen/MovieApp/refs/heads/main/DocsImagens/Details%201.png?token=GHSAT0AAAAAACWZUJFEDNDNUXK76YY663JEZXOJPLQ)
![Detalhes do Filme](https://raw.githubusercontent.com/IgorKoppen/MovieApp/refs/heads/main/DocsImagens/Details2.png?token=GHSAT0AAAAAACWZUJFEMFU7KLAS7RY5NSZYZXOJQAA)

### Busca de Filme
![Busca de Filme](https://raw.githubusercontent.com/IgorKoppen/MovieApp/refs/heads/main/DocsImagens/Search.png?token=GHSAT0AAAAAACWZUJFENMCJW62E6PDJZ2QGZXOJUMQ)

### Top Rated Movies
![Top Rated Movies](https://raw.githubusercontent.com/IgorKoppen/MovieApp/refs/heads/main/DocsImagens/TopRated.png?token=GHSAT0AAAAAACWZUJFESOSTMZJ27GB4SCIKZXOJVHA)

### Reviews
![Reviews de usuários](https://raw.githubusercontent.com/IgorKoppen/MovieApp/refs/heads/main/DocsImagens/Reviews.png?token=GHSAT0AAAAAACWZUJFERDBBJ2MQT6T5562UZXOJT3A)

### Similar Movies
![Filmes similares](https://raw.githubusercontent.com/IgorKoppen/MovieApp/refs/heads/main/DocsImagens/SimilarMovies.png?token=GHSAT0AAAAAACWZUJFFQIMBMMGZXW3QXLMMZXOJUZA)
