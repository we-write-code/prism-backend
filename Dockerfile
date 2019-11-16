FROM elixir:1.9-alpine
EXPOSE 4000

COPY docker/scripts/entrypoint.sh /

RUN set -x \
  && apk add bash vim inotify-tools make gcc erlang-dev g++ \
  && chmod +x /entrypoint.sh \
  && mkdir /prism

RUN mix local.hex --force \
  && mix local.rebar --force

WORKDIR /prism

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
CMD ["mix", "phx.server"]
