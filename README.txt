#mod_health

Monitor Ejabberd and any applications running on it.
Based on https://www.ejabberd.im/mod_monitor_web but updated for Ejabberd 14.02+


## Ejabberd Config
First make sure the module is added in ejabberd.yml on the server port

```yml
  -
    port: 5281
    module: ejabberd_http
    request_handlers:
      "/healthcheck": mod_health
    web_admin: false
    http_poll: false
    http_bind: false
    ## register: true
    captcha: true
```

This will create an endpoint for mod_health to listen to at localhost:5281/healthcheck

## Adding additional applications to check

Define the application name as a constant at the top of the file:

```erlang
-define(MYSQL, mysql).
```

And then add the check in the check_health function:

```erlang
MySQL = get_status(?MYSQL),
```
