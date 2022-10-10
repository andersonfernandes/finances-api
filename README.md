# Finances API [![Build](https://github.com/andersonfernandes/finances-api/actions/workflows/main.yml/badge.svg)](https://github.com/andersonfernandes/finances-api/actions/workflows/main.yml) [![Maintainability](https://api.codeclimate.com/v1/badges/88419b2509fcfa371c8c/maintainability)](https://codeclimate.com/github/andersonfernandes/finances-api/maintainability)  [![Test Coverage](https://api.codeclimate.com/v1/badges/88419b2509fcfa371c8c/test_coverage)](https://codeclimate.com/github/andersonfernandes/finances-api/test_coverage)

This application provides a REST API to manage your financial life. Keep track of your expenses, incomes and transfers between accounts.

**Demo:** http://financesapi.herokuapp.com/

**Swagger Hub:** https://app.swaggerhub.com/apis/andersonfernandes/finances-api/1.0

## Developer Setup

1. Install [docker](https://www.docker.com/) and [docker-compose](https://docs.docker.com/compose/)
2. Run `./scripts/start_app.sh` to raise the docker infrastructure and start a detached development server at [localhost:5000](http://localhost:5000)

## Commands

In order to use the following commands, add `docker-compose exec web` before it.

- `bundle exec rubocop` - Run the full suite of linters on the codebase.
- `bundle exec rspec` - Run the tests on the codebase.

## Contributing

This project is intended to be a safe, welcoming space for collaboration.
There are many ways to contribute to this project:

**Bugs**
If you spot a bug, let us know! File a GitHub Issue for this project. When filing an issue add the following:

- Title: Sentence that summarizes the bug concisely
- Comment:
    - The environment you experienced the bug (browser, browser version, kind of account any extensions enabled)
    - The exact steps you took that triggered the bug. Steps 1, 2, 3, etc.
    - The expected outcome
    - The actual outcome, including screen shot
    - (Bonus Points:) Animated GIF or video of the bug occurring
- Label: Apply the label `bug`

**Code Submissions**
This project logs all work needed and work being actively worked on via GitHub Issues. Submissions related to these are especially appreciated, but patches and additions outside of these are also great.

If you are working on something related to an existing GitHub Issue that already has an assignee, talk with them first (we don't want to waste your time). If there is no assignee, assign yourself (if you have permissions) or post a comment stating that you're working on it.

To work on your code submission, follow:

1. Fork the repo and create a new branch
2. Commit changes
3. Submit Pull Request
4. Discuss via Pull Request
5. Pull Request gets approved or denied by core team member

## License

The application is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Finances project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).
