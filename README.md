#mod_health

Monitor Ejabberd and any applications running on it.
Based on https://github.com/nycholas/ which is based on https://www.ejabberd.im/mod_monitor_web 14.02+

## Objective
The target is to include the status code on the response of the healthcheck on the response status code.
- 204 response for all checked and properly running.
- 503 response when any of the services defined on the module are failling.

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

then add subsecuently on function ```get_all_status``` another check variable for the new status 
added (like: ```EJABBERDStatus = lists:keymember(?EJABBERD, 1, application:which_applications()),```), add this new obtained variable status to the list of results.
