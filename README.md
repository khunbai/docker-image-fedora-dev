# Docker Container For DEV

Pre-install with Python 3.12.5, Node 20.12.2, pnpm, git, LazyVim, Ranger

## Basic Docker Run Commands

Run basic bash inside container.

```shell
docker run -it --rm -p 4200:4200 -v ./pnpm:/root/.local/share/pnpm -v ./workspace:/workspace -v ./config:/root/.config fedora-dev:40 /bin/zsh
```

Run with exposed ssh port.

```shell
docker run -d -p 2222:22 -p 4200:4200 -v ./pnpm:/root/.local/share/pnpm -v ./workspace:/workspace -v ./config:/root/.config --name fedora-dev fedora-dev:40 &&
# Enter inside the container
docker exec -it fedora-dev /bin/zsh
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
docker commit fedora-dev fedora-dev:40
# or
docker commit -m ${comment} -a ${your_name} fedora-dev fedora-dev:40
docker commit -m "Installed @angular/cli as global" -a "khunbai" fedora-dev fedora-dev:40
```

## Push to docker hub

First save tag to match with repository name.

```shell
docker tag fedora-dev:40 ${your_dockerhub_username}/fedora-dev:40
```

Log in to docker with access token, Go to docker hub website and go to
section Account Settings > Personal access tokens > copy the token

At prompting to enter password, paste the token copied from above.

```shell
docker login -u ${your_dockerhub_username}
```

Push the image to Docker Hub

```shell
docker push ${your_dockerhub_username}/fedora-dev:40
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

## Example of project directory structure

![alt text](https://github.com/khunbai/docker-image-fedora-dev/blob/main/readme_assets/ex_folder_str.png?raw=true)

## Basic keymaps

### LazyVim

#### Normal Mode

- `za` Toggle fold
- `<leader>uh` Toggle inlay hints
- `<leader>sr` Search and replace
- `<leader>cd` Open warning/error dianostic panel
- `<leader>cf` Format current file
- `<leader>xt` Open todo-comments.nvim window
- `<leader>bd` Close current tab/buffer

---

Multicursor

- `<C-o>` add a cursor
- `<C-u>` exit multi-cursor mode to normal
- `<C-i>` Go to first cursor and enable multi-cursor mode
- `<C-q>` Clear all cursors
- `<C-n>` Go to next word and add cursor
- `<C-m>` Remove current cursor and go to next word and add cursor
- `<leader-x>` Remove nearest cursor

#### Neotree

- `<S-h>` Toggle hidden files/folders

### TMUX

- `<C-a>` Prefix
- `<prefix>j` Move to below pane (k for move to above)
- `<prefix>1` Switch to window 1, number could be 0-9
- `<prefix>-` Horizontal split pane
- `<prefix>c` Create new window
- `<prefix>,` Rename window
- `<prefix><S-i>` Install plugin (TPM)
- `<prefix><C-s>` Save session (TMUX SESSION)
- `<prefix><C-r>` Restore session (TMUX SESSION)
- `<prefix>[` Enter copy mode
- `<prefix>]` Paste tmux clipboard copied from tmux copy mode

**Tmux copy mode keymap**

| Action | emacs | vi |
|--------------------|--------------------|---------------|
| move character | Up Down Left Right | j k h l |
| move line | Ctrl-Up Ctrl-Down | Ctrl+Y Ctrl+E |
| move whole screen | PageUp PageDown | Ctrl+B Ctrl+F |
| search | Ctrl+S | / |
| start selection | Ctrl+Space | Space |
| copy selection | Ctrl+W | Enter |
| clear selection | Ctrl+G | Escape |
| exit copy mode | Escape | q |
