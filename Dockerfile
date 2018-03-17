FROM elixir:1.6-alpine as builder

ENV MIX_ENV prod

WORKDIR /build

RUN mix local.hex --force && \
 mix local.rebar --force

# Copy all dependencies files
COPY mix.* ./

# Install all production dependencies and Compile all dependencies
RUN mix deps.get --only prod && \
    mix deps.compile

# Copy all application files
COPY . .

# Compile the entire project
RUN mix compile && mix escript.build

FROM elixir:1.6-alpine

WORKDIR /application

COPY --from=builder /build/saasy /application/saasy

ENTRYPOINT ["/application/saasy"]