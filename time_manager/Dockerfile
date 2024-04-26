FROM elixir:1.15.6

ENV DEBIAN_FRONTEND=noninteractive

# RUN mix local.hex --force
# RUN mix archive.install hex phx_new --force
RUN apt-get update && apt-get install -y inotify-tools

WORKDIR /app

ENTRYPOINT [ "./entrypoint.sh"] 