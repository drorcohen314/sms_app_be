## Prepare the server

``` bash
bundle install
rails db:load:schema
rails db:migrate
```

## Run
``` bash
rail server
```

### THE SERVER REQUIRES A FEW ENVIRONMENT VARIABLES:
TWILIO_ACCOUNT_SID,
TWILIO_AUTH_TOKEN,
TWILIO_PHONE_NUMBER,

### AND IN PRODUCTION 
DATABASE_URL,
DATABASE_USERNAME,
DATABASE_PASSWORD

