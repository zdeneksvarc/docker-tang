## Tang docker container image

Runs [tang](https://github.com/latchset/tang) inside a Rocky Linux docker container.

## Usage

```
docker run -d -p 8080:80 -v tang-db:/var/db/tang stackhpc/tang
```
