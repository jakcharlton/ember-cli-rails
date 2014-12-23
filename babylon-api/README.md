### Notes


### Useful snippets

#### Monitor changes to UI app and rebuild to Rails folder

`ember server` will bypass the Rails step and will fail to include any Rails specific code additions. Avoid this and use Rails to serve the HTML page

To have changes to the UI app reflected in the Rails app immediately set ember build to watch for changes

`ember build --output-path ../babylon-api/public --watch`

#### Deploying UI

The deploy is done by Gruntfile.coffee, taking the ember build to /dist and copying the assets to an S3 bucket, and then adding the asset information into Redis server to be picked up by the main Rails app

`grunt -p`

Grunt settings are read from env.json in the root folder of the UI app - in a format similar to :

```javascript
{
  "AWS": {
    "AccessKeyId": "SECRETID",
    "SecretKey": "SECRETKEY",
    "bucket":"babylon-ui"
  },
  "REDIS": {
    "development": {
      "host": "localhost",
      "port": "6379"
      },
    "production": {
      "host": "redis-host.com",
      "port": "9233",
      "password": "SECRET PASSWORD"
    }
  }
}
```


##### Deploying Rails 

From the root of the two apps, use git subtree to push the Rails app to Heroku

`git subtree push --prefix babylon-api heroku master`


