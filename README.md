![Bridging the Gap](https://github.com/flinders-university/bridging-the-gap/raw/master/public/gh_image.png)

# Bridging the Gap Web Platform

Bridging the Gap is a STEM education research collaboration 'connecting science to the real world'. It is a research project run by Flinders University in the College of Education, Psychology and Social Work with pre-service teachers.

This web platform supports the project team, industry contacts and schools to engage in industry placements (work integrated learning), research participation and a public facing CMS.  

## Technical Details

This platform is designed and tested to operate on Heroku.

### Ruby version

This project uses the, now quite old, 2.3.0.

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
