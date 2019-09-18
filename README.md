![Bridging the Gap](https://github.com/flinders-university/bridging-the-gap/raw/master/public/gh_image.png)

# Bridging the Gap Web Platform

Bridging the Gap is a STEM education research collaboration 'connecting science to the real world'. It is a research project run by Flinders University in the College of Education, Psychology and Social Work with pre-service teachers.

This web platform supports the project team, industry contacts and schools to engage in industry placements (work integrated learning), research participation and a public facing CMS.  

## Features

* Content management system
* Learning objects
* User management
* Industry database and engagement tracking
* Contact management
* Compliance reporting
* Multi user blog interface
* Research data collection (surveys)
* Research data management (consent)

## Project team

Primary research officer & programming lead: [Aidan Cornelius-Bell](https://flinders.edu.au/people/aidan.cornelius-bell)

Other project team members: [Dr Carol Aldous](https://flinders.edu.au/people/carol.aldous), [Abby Witts](https://flinders.edu.au/people/abby.witts), [David Jeffries](https://flinders.edu.au/people/david.jeffries), [Narmon Tulsi](https://flinders.edu.au/people/narmon.tulsi)

## Technical Details

This platform is designed and tested to operate on Heroku using AWS as the 'static' storage in the Sydney region for research data storage, etc.

### Ruby version

This project uses, the now quite old, Ruby 2.3.0.

### System dependencies

* Postgres
* Linux, probably

### Configuration

Standard Ruby on Rails configuration applies. Environment variables are spec'd in the ```/config/environments/*.rb```

### Database creation

```
bundle exec rake db:create
```

### Database initialization

```
bundle exec rake db:migrate
```

### Asset creation & regeneration

```
bundle exec rake assets:clean assets:precompile
```
