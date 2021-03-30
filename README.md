# Monit - UNIX Systems Management

Run Monit inside docker with Telegram notification support.

[![Monit](https://mmonit.com/monit/img/logo.png)](https://mmonit.com/monit/)

[Monit](https://mmonit.com/monit/) is a free open source utility for managing and monitoring, processes, programs, files, directories and filesystems on a UNIX system. Monit conducts automatic maintenance and repair and can execute meaningful causal actions in error situations.

[Monit2Telegram](https://github.com/TheSpad/monit2telegram) is a script that allows monit output to be sent via the Telegram bot API for notifications.

Default username/password: admin/monit

## Docker setup

Install docker: https://docs.docker.com/engine/installation/

Install docker compose: https://docs.docker.com/compose/install/

Docker documentation: https://docs.docker.com/

### Pull docker image

`docker pull thespad/docker-monit:latest`
or
`docker pull ghcr.io/thespad/docker-monit:latest`

### Or build docker image locally

- clone repo

- build docker image `docker build -t monit .`

### Then start monit
`docker run -d --name=monit -p 2812:2812 -v $(pwd)/config:/config -e PUID=1000 -e PGID 1000 -e TGTOKEN=<telegram API token> -e TGCHATID=<telegram chat ID> local/monit`

- or use [docker-compose](https://github.com/TheSpad/docker-monit/blob/develop/docker-compose.yml.sample)

### Monit2Telegram setup

- Configure API token and channel id in environment variables

- Test Telegram with `docker-compose run monit sendtelegram -m "Hello from the other side\!"`

- Add to checks with `exec` statement

```
check file nginx.pid with path /var/run/nginx.pid
    if changed pid then exec "/config/monit2telegram"
```
