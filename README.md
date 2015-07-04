# docker-redir

A simple Docker TCP port redirector.

Use this for temporarily redirecting a port in a started container.

## Exposed ports

For ports that are exposed in the target image, run the container
without arguments.

    docker run -d -p 8888:8888 --link target-container jamesandariese/redir

## Unexposed ports

To redirect a custom port that's not exposed, run with the IP and
port of the target container.

    docker run -d -p 8888:8888 jamesandariese/redir 172.17.0.50 8888

Don't forget to bind the port to the external interface (e.g., `-p 8888:8888`).
