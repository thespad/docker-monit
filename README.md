# Monit - UNIX Systems Management

Run Monit inside docker with Telegram notification support.

[![Monit](https://mmonit.com/monit/img/logo.png)](https://mmonit.com/monit/)

[Monit](https://mmonit.com/monit/) is a free open source utility for managing and monitoring, processes, programs, files, directories and filesystems on a UNIX system. Monit conducts automatic maintenance and repair and can execute meaningful causal actions in error situations.

[Monit2Telegram](https://github.com/matriphe/monit2telegram/) is a script that allows monit output to be sent via the Telegram bot API for notifications.

Default username/password: admin/monit

## Docker setup

Install docker: https://docs.docker.com/engine/installation/

Install docker compose: https://docs.docker.com/compose/install/

Docker documentation: https://docs.docker.com/

### Build-in docker image

- clone repo

- build docker image `docker build -t monit .`

- start monit: `docker run -d --name=monit -p 2812:2812 -v $(pwd)/monitrc:/etc/monitrc -v $(pwd)/telegramrc:/etc/telegramrc monit`

- or use `docker-compose`

### Monit2Telegram setup

- Configure API token and channel id in telegramrc

- Test Telegram with `docker exec monit sendtelegram -c /etc/telegramrc -m "Hello from the other side!"`

- Add to checks with `exec` statement

```
check file nginx.pid with path /var/run/nginx.pid
    if changed pid then exec "/usr/local/bin/monit2telegram"
```

### Troubleshooting

If when starting Monit returns the following message: `The control file '/etc/monitrc' permission 0755 is wrong, maximum 0700 allowed`, simply give the appropriate permissions to _monitrc_: `chmod 700 monitrc`.

If when starting Monit returns the following message: `The control file '/etc/monitrc' must be owned by you`, simply give ownership of _monitrc_ to the docker user: `chown root:root monitrc`.
