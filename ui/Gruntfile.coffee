module.exports = (grunt) ->
  timestamp = Date.now().toString()

  grunt.initConfig
    env: grunt.file.readJSON 'env.json'

    s3:
      options:
        key: '<%= env.AWS.AccessKeyId %>'
        secret: '<%= env.AWS.SecretKey %>'
        bucket: '<%= env.AWS.bucket %>'
        region: 'us-west-2'
        access: 'public-read'
        headers:
          "Cache-Control": "max-age=630720000, public" # 2 years
          "Expires": new Date(Date.now() + 630720000).toUTCString()
      prod:
        upload: [
          src: 'dist/assets/*'
          dest: "#{timestamp}/assets/"
        ,
          src: 'dist/assets/images/*'
          dest: '/assets/images'
        ,
          src: 'dist/fonts/*'
          dest: '/assets/fonts'
        ]

    redis:
      options:
        prefix: "#{timestamp}:"
        currentDeployKey: timestamp
        manifestKey: 'latest_ten_deploys'
        manifestSize: 10
      dev:
        options:
          host: '<%= env.REDIS.development.host %>'
          port: '<%= env.REDIS.development.port %>'
        files: src : ["dist/app.html"]
      prod:
        options:
          host: '<%= env.REDIS.production.host %>'
          port: '<%= env.REDIS.production.port %>'
          connectionOptions: auth_pass: '<%= env.REDIS.production.password %>'
        files: src : ["dist/app.html"]

    replace:
      dist:
        src: ['dist/*.html','dist/**/*.js','dist/**/*.css']
        overwrite: true
        replacements: [{
          from: 'cloudfront.net/assets'
          to: "cloudfront.net/#{timestamp}/assets"
          }
        ]

    shell:
      options:
        stdout: true
        stderr: true
        failOnError: true
      dev: command: 'ember build --environment=development --output-path ../babylon-api/public'
      prod: command: 'ember build --environment=production'
      done: command: "echo Deploy complete, deploy key: #{timestamp}"

  grunt.loadNpmTasks 'grunt-debug-task';
  grunt.loadNpmTasks 'grunt-s3'
  grunt.loadNpmTasks 'grunt-redis-manifest'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-text-replace'

  # Default task(s). flag can be '-prod' or '-p'
  target = if grunt.option('prod') or grunt.option('p') then 'prod' else 'dev'

  grunt.task.registerTask 'update_yaml', 'Update Rails YAML with deploy key', () ->
    YAML = require('yamljs');
    conf = { 'deploy': { 'main': timestamp } }
    grunt.file.write('../babylon-api/config/frontend_deploy.yml', YAML.stringify(conf));

  if target is 'prod'
    grunt.registerTask 'default', [ "shell:#{target}"
                                    'replace'
                                    's3'
                                    "redis:#{target}",
                                    "update_yaml",
                                    "shell:done" ]
  else
    grunt.registerTask 'default', [ "shell:dev" ]