# Timefy


Timefy is a redmine plugin for creating time entries from a spreadsheet file.

> The base idea is [Issuefy](https://github.com/tchx84/issuefy)

## Installation

0. `$ cd /path/to/redmine/plugins/`
1. `$ git clone https://github.com/gezabenko/timefy.git`
2. `$ bundle install --without development test`
3. And restart your webserver.

## Usage

0. Assign the _"timefy"_ permission to the roles you seem fit.
1. Users with the corresponding roles will see the _"Timefy"_ tab in projects view.

## Spreadsheet format

0. Issue number (mandatory): iiiii
1. Date (mandatory): dd/mm/yyyy
2. Hours (mandatory): h.p
3. Comment

check the `example/book.xls` for more details about the format.

## Features

- update issues in your project, from a spreadsheet.
- support for redmine 2.3.x and 2.4.x.

## Collaborating

- Take a look at the TODO part.
- Send a message to @gezabenko, just drop a pull request, through github or fork the repository.

## TODO

- [ ] support dynamic spreadsheet formats
- [ ] write tests
- [ ] activity
- [ ] other person behalf