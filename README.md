# Saasy

## Run command from scratch on you host

Simply execute the `mix saasy` task. It will prompt you a similar message to this:

```bash
$ mix saasy
Missing required argument
Command: saasy --provider [PROVIDER].
Description
-----------
Command that integrates data from different services. Converts their files with data to a native elixir format.
--------------------------
Usage
-----
  --provider: Name of the provider to import. Available ones are: capterra, softwareadvice
```

Then to import a provider just supply the `--provider` flag:

```bash
$ mix saasy --provider capterra
Importing Categories: Bugs & Issue Tracking, Development Tools; Name: GitGHub; Twitter: @github
Importing Categories: Instant Messaging & Chat, Web Collaboration, Productivity; Name: Slack; Twitter: @slackhq
Importing Categories: Project Management, Project Collaboration, Development Tools; Name: JIRA Software; Twitter: @jira
```

## Create docker container

Execute the task named `docker`

```bash
$ mix docker
```

## Check coverage status

`$ mix cover` Will create a coverage and open the report on your default browser.

## Check the docs

`$ mix rtfm` Generates documentation and opens it on your default browser.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `saasy` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:saasy, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/saasy](https://hexdocs.pm/saasy).

