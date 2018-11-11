# Random Notes

## Start mssql as a docker container
```bash
docker run \
  --rm \
  -e 'ACCEPT_EULA=Y' \
  -e 'SA_PASSWORD=Qwerty!23456' \
  -p 1433:1433 \
  --name mssql \
  microsoft/mssql-server-linux
```

## Start postgres as a docker container

```bash
docker run \ 
  --rm \
  --name postgres \
  -p 5432:5432 \
  -e POSTGRES_USER=user \
  -e POSTGRES_PASSWORD=mysecretpassword \
  postgres
```
