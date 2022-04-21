# Take-Home Test for Backend Engineer Role

Thank you for your interest in applying to the Backend Engineer role at System76! Your mission—should you choose to accept it—is outlined in [Assignment](#assignment).

## Why a take-home test?

In-person coding interviews can be stressful, and can hide some people's full potential. A take-home test gives you the chance showcase your talent by working in your own space, and on your own time.

We understand you may have time constraints, so we've made this as simple as possible to evaluate the skill and tech stack you will be using in your day-to-day here at System76.

## Assignment

Your mission will be to build a web API that can be used to query some information about Products.

- [Sample data](support/data.csv) is provided in the `/support` folder.
- We have provided [the stub](lib/mix/tasks/import_products.ex) for a [Mix Task](https://hexdocs.pm/mix/1.12/Mix.Task.html) to import this data.

Write your code, using [Ecto](https://hexdocs.pm/ecto/Ecto.html) to model the data, and store it in a local Postgres database. Then, utilize Phoenix to build a web API to query the models. A basic API design for this assignment would simply return all of the available products, and make them filterable by one or more categories: e.g. laptop, desktop, server. You may choose to improve and refine this design—and we encourage you to do so! This will give us an opportunity to see how you approach the design of an API you know you and your team members will be using in the future.

If you are running out of time, you can outline below in the [Notes](#notes) section how you would have done things differently if given more time.

## Setup Instructions

We use [asdf](https://asdf-vm.com/) to manage dependencies. This is a Phoenix 1.6.0 project, using Postgres for the database.

To start your Phoenix server:

- Install [asdf](https://asdf-vm.com/) to install Erlang and Elixir with `asdf install`. You can skip this step and use your OS preferred package manager or any other way you prefer.
- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server` or from inside IEx with `iex -S mix phx.server`

You can now visit [`localhost:4000`](http://localhost:4000) from your browser to see the app running.

Alternatively, you can run both the database and the app itself in a Docker environment using [Docker compose](https://docs.docker.com/compose/):

```shell
docker-compose build
docker compose up
```

## Evaluation Criteria

We will use this project as the basis for evaluating your skill as a developer as it relates to our tech stack and our team.

While we'll be gathering as much data as we can from your implementation, our evaluation will focus on these core concepts:

- Solution Integrity: Is your solution complete and functional?
- Design: What choices did you make in regards to functionality, readability, maintainability, extendability, and did you make appropriate use of language/framework features?
- Testability: Have you considered how you'd test your code?
- Documentation: Have you provided context for decisions and assumptions that you've made?

## Notes

### Your Notes

_TODO: Please leave us any notes about your experience with this challenge here._
- I stuff secrets into a .env file which means I run `source .env` before I startand my .env looks very similar to example.env
- I was going to weed out the to-be-records that had empty fields for strings then realized that would slow down reading the file and the changeset would handle that since the fields are required
- I'm using httpoison for web requests
  + Tried Tesla before and I'm not a fan
  + There's also a tool that converts curl request to httpoison: https://curlconverter.com/#elixir
- I'm creating a seperate module for api calls to the inventory instead of adding functions to the existing context to keep the context simple and allow the api to be reusable and replacable.
- Changesets use atoms in their maps so I added a key converter to the InventoryApi as a private function
- Added an inventory api user guide
- Added a folder for the mix folder to tests to follow the existing style
- I should have wrote the tests before the program


### Time Spent

_TODO: Give us a rough estimate of the time you spent working on the test. If you spent time learning in order to do this project please feel free to let us know that too. This makes sure that we are evaluating your work fairly and in context. It also gives us the opportunity to learn and adjust our process if needed._
Development   - 8 hr 55 min
Documentation - 1 hr 0 min
Testing Dev   - 6 hr 00 min
Research      - 2 hr 30 min

Learned skills
- Uploading files via curl using multipart
- Openning files recieved via multipart
- Test driven development
- Using testing features provided by Elixir & Phoenix

### Assumptions

_TODO: Did you find yourself needing to make assumptions to complete this? If so, what were they, and how did they impact your design/code?_
The assumptions I'm making are:
- records shouldn't have empty fields
- uuid is a universally unique identifier
- duplacate uuids aren't being tracked or counted

### Production Readiness

_TODO: Provide us with some notes about what you would do next if you had more time. Are there additional features that you would want to add? Specific improvements to the code you would make? Any additional testing or documentation?_
Next steps for this project would include:
- Authentication starting with `mix phx.gen.auth Accounts User users`
- Find nicer documentation tools & patterns
- Change the string keys to atoms
- Run the test setup once for all tests with the database & api
- Code some reciever functions for converting json bodies to Elixir structs
