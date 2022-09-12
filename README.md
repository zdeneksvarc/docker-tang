## Tang docker container image

Runs [tang](https://github.com/latchset/tang) inside a Rocky Linux docker container.

## Usage

It is recommended to use the latest versioned release e.g v1.0.0. To avoid needing to update the README
each time, the documentation will use the `latest` tag.

Simplest example:

```
docker run -d -p 8080:80 -v tang-db:/var/db/tang ghcr.io/stackhpc/tang:latest
```

Using host networking with a custom port:

```
docker run -e TANG_LISTEN_PORT=1234 -d --network host -v tang-db:/var/db/tang ghcr.io/stackhpc/tang:latest
```
