
# PocketBase

⚠️**UNOFFICIAL Pocketbase container images**⚠

   <a aria-label="Latest Pocketbase Version" href="https://github.com/pocketbase/pocketbase/releases" target="_blank">
    <img alt="Latest Pocketbase Version" src="https://img.shields.io/github/v/release/pocketbase/pocketbase?color=success&display_name=tag&label=latest&logo=docker&logoColor=%23fff&sort=semver&style=flat-square">
  </a>


[PocketBase](https://pocketbase.io) is an open source backend solution made in Go.



## Docker Run
```bash
docker run --name pocketbase -p 8090:8090 -v pocketbase-data:/pb_data -v ./public:/pb_public -v ./migrations:/pb_migrations augustodelg/pocketbase:latest
```
## Docker Compose

docker-compose.example.yaml

```yml
version: '3.7'

services:
  pocketbase:
    image: augustodelg/pocketbase
    ports:
      - 8090:8090
    volumes:
      - pocketbase-data:/pb_data
      - ./public:/pb_public
      - ./migrations:/pb_migrations

volumes:
  pocketbase-data:
```
## TODO
- ~~Make an  Github Action to automatically build images for each new version.~~
- ~~Supporting arm64 and armv7 architectures.~~
