# ExChess - Backend

<a name="readme-top"></a>
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
        <a href="#built-with">Built With</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#configuration">Configuration</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#documentation">Documentation</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>

### Built With

* [Elixir][elixir-url]
* [Phoenix][phoenix-url]
* [PostgreSQL][postgresql-url]
* [Docker][docker-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

**If you want to use the docker container you can skip the `Prerequisites` section and go to `Configuration`.**

### Prerequisites

#### Erlang + Elixir 1.14.2 / OTP 25

* macOS

  ```sh
  brew install erlang elixir
  ```

* ArchLinux

  ```sh
  pacman -S erlang elixir
  ```

* Windows
  Checkout [Elixir's documentation](https://elixir-lang.org/install.html#windows)

#### Stockfish

* Linux/MacOS
  Download the latest version of stockfish:

  ```sh
  git clone https://github.com/official-stockfish/Stockfish
  ```

* Build the project

  ```sh
  cd src
  make help
  make net
  make build ARCH=x86-64-modern
  ```

* Install it

  ```sh
  sudo make install
  ```

### Configuration

#### Database

In order to launch the database server, you need to launch the Docker container. Rename `docker-compose.yml.example` to `docker-compose.yml` and set the follwing environment variables:

```yml
app:
  environment:
    DB_USER: "<DB_USER>"
    DB_PASSWORD: "<DB_PASSWORD>"
db:
  environment:
    POSTGRES_USER: <DB_USER>
    POSTGRES_PASSWORD: <DB_PASSWORD>
```

### Installation

In can either install Elixir's binaries directly on your machine or you can use a docker container that provides an already configured development environment.

#### On your machine

1. Install dependencies

   ```sh
   mix deps.get
   ```

2. Compile the dependencies

    ```sh
    mix deps.compile
    ```

3. Launch the database container

    ```sh
    docker compose up -d
    ```

4. Create database and lanch migrations

   ```sh
   mix ecto.create
   mix ecto.migrate
   ```

5. Populate the database

    ```sh
    mix run ./priv/repo/seeds.exs
    ```

6. Finally, launch the web server

   ```sh
   mix phx.server
   ```

   Or you if want to have a console and execute Elixir code in live (just like Ruby on Rails console/irb):

   ```sh
   iex -S mix phx.server
   ```

#### On the container

1. Build `Phoenix` and `Stockfish` images

   ```sh
   docker-compose build
   ```

2. Run all containers

   ```sh
   docker-compose up -d
   ```

3. Check the logs

   ```sh
   docker-compose logs -f
   ```
<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Directory structure

Just like most web applications written in Elixir, this project follows the `directory structure` defined for [Phoenix][phoenix-url]. [The excellent official documentation](https://hexdocs.pm/phoenix/directory_structure.html) explains in great detail the purpose of each directory.

The unit tests can be found under the `test/` directory.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

- [Thynkon](https://github.com/Thynkon)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[elixir-url]: https://elixir-lang.org
[phoenix-url]: https://www.phoenixframework.org
[postgresql-url]: https://www.postgresql.org
[docker-url]: https://www.docker.com
