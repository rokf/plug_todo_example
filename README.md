# Plug TODO Example

This is an example Elixir project.
It is made of a Plug server which speaks to a GenServer storage instance.
Together they build a tiny REST TODO app.

Install dependencies with `mix deps.get` and run with `make` or `mix run --no-halt`.

`curl` client example:

- add - `curl -X GET "localhost:8080/add?txt=Something"`
- remove - `curl -X GET "localhost:8080/remove?index=2"`
- get state - `curl -X GET "localhost:8080/state"`

Consider this a work in progress although the basic thing I imagined works. I need to add coments, clean stuff up and I'll maybe add some more stuff.
