Blaze-lite User Stories
=======================

As a user<br />
In order to use Blaze-lite<br />
I want to see a menu of choices to implement<br />

  - User runs `blaze start`
  - User is shown a menu of options

<hr />

As a user<br />
In order to keep my log current<br />
I want to add a trail to the log for either a hike, run, or bike<br />

  - User runs `blaze <hike/run/bike>`
  - User is guided via questions and menu choices to input data about the hike, run, or bike

<hr />

As a user<br />
In order to view my trail entries<br />
I want to run a list<br />

  - User runs `blaze list`

<hr />

As a user<br />
In order to maintain my log<br />
I want to edit a trail entry<br />

  - User runs `blaze edit <trail_id>`
  - User chooses from menu which field to edit
  - User is prompted to input new data

<hr />

As a user<br />
In order to maintain my log<br />
I want to delete a trail entry<br />

  - User runs `blaze delete <trail_id>`
  _ User is prompted to confirm deletion

<hr />

As a user<br />
In order to see a summary of my log<br />
I want to run a report of my trail data<br />

  - User runs `blaze summary`
  - User is shown a summary of data from log (mileage totals, # of trails, etc.)

<hr />

As a user<br />
In order to see a totals for a specific trail<br />
I want to run a report against a single trail<br />

  - User runs `blaze report <trail_id>`
  - User is shown data totals for specified trail

<hr />

As a user<br />
I order to see data which shares common data<br />
I want so search by certain fields<br />

  - User runs `blaze search`
  - User is shown a list of which fields can be queried
  - User runs `blaze search <field name> <input>`

<hr />

As a user<br />
In order to get the most out of the app<br />
I want to see a manual<br />

  - User runs `blaze man`
  - User is shown manual of commands and tips to utilize in Blaze-lite
