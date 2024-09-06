# Docker Container For DEV

Pre-install with Python 3.12.5, Node 20.12.2, pnpm, git, LazyVim, Ranger

## Basic Docker Run Commands

Run basic bash inside container.

```shell
docker run -it --rm -p 4200:4200 -v ./pnpm:/root/.local/share/pnpm -v ./workspace:/workspace -v ./config:/root/.config fedora-dev:40 /bin/bash
```

Run with exposed ssh port.

```shell
docker run -d -p 2222:22 -p 4200:4200 -v ./pnpm:/root/.local/share/pnpm -v ./workspace:/workspace -v ./config:/root/.config --name fedora-dev fedora-dev:40 &&
# Enter inside the container
docker exec -it fedora-dev /bin/bash
```

Stop container with remove.

```shell
docker rm -f fedora-dev
```

## Save state to image

Sometime we might need to install packages or do something inside the container
and would like to save all those state into current image, we can use this below
command to save or update into current image.

```shell
docker commit -m ${comment} -a ${your_name} fedora-dev fedora-dev:40
docker commit -m "Installed @angular/cli as global" -a "khunbai" fedora-dev fedora-dev:40
```

## Serve developing web server from container

When you developing an Angular project or using any framework and serve dev server
with common command `npm start` and it's serving on localhost:4200, this means
localhost inside container. You cannot access it with localhost:4200 on host even
expose port 4200 with `-p 4200:4200` command in `docker run`.
To fix this you have to bind host to 0.0.0.0 by modify the start script in `package.json`

```json
"scripts": {
  "start": "ng serve --host 0.0.0.0"
  ...
}
```
