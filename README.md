## Tang docker container image

Runs [tang](https://github.com/latchset/tang) inside a Debian docker container.

## Usage

Local build:

```
docker build --no-cache -t tang:latest .
```

Simplest example:

```
docker run -d -p 8080:80 -v tang-db:/var/db/tang tang:latest
```

Using host networking with a custom port:

```
docker run -e TANG_LISTEN_PORT=1234 -d --network host -v tang-db:/var/db/tang tang:latest
```

## Manual testing

```
# Build your own container
docker build --no-cache -t tang:latest .
# Start a tang container
docker run --rm -e TANG_LISTEN_PORT=1234 --name tang -d --network host -v tang-db:/var/db/tang tang:latest
# Encrypt some text
echo "Hello World" | clevis encrypt tang '{ "url": "http://localhost:1234"}' > secret.jwe
# Stop docker to trigger container deletion
docker stop tang
# Recreate to test persistence of DB
docker run --rm -e TANG_LISTEN_PORT=1234 --name tang -d --network host -v tang-db:/var/db/tang tang:latest
# Attempt decrypt
clevis decrypt < secret.jwe
```

## Simple Docker Compose

```
services:
  tang:
    image: tang:latest
    container_name: tang
    ports:
      - "28888:80"
    volumes:
      - ./tang-keys:/var/db/tang
    healthcheck:
      test: ["CMD", "/tangd-healthcheck"]
      interval: 30s
      timeout: 10s
      retries: 3
    restart: always
```