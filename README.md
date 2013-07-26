desiccator
==========

Dashboard for GitHub pull requests.

Run with Rack. Syncs data to a SQLite database.

# Due Dates and Required Reviewers

If you wish, include lines like these in your pull request description:

> Reviewers: @brokensandals @sun16
> Due: 2013-07-29

Due date can also be specified as a duration from the creation time:

> Due: 5 hours
> Due: 1 business day

# Completion

Reviewers who comment "+1" on the pull request will be shown as 'completed' on the dashboard.

# Setup

## config.yaml

Place a `config.yaml` file in the root directory of the app:

```yaml
crawl_interval: 5m
github: https://github.com
github_api: https://api.github.com
```

## Crawling users/orgs

Go to `/users/:login/settings` to enable periodically syncing of a user/org or do a one-off sync.

## Default reviewers and due dates

After crawling a user/org, go to `/repos/:user/:repo/settings` to configure a default set of reviewers
(which will be combined with the explicit reviewer set, if any) and a default due date.
