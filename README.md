# Capistrano::FigaroYml

Capistrano tasks for handling figaro `application.yml` when deploying Rails 4+ apps.

### Install

Add this to `Gemfile`:

    group :development do
      gem 'capistrano', '~> 3.3.0'
      gem 'capistrano-figaro-yml', '~> 1.0.2'
    end

And then:

    $ bundle install

### Setup and usage

- make sure your local `config/application.yml` is not git tracked. It **should be on
  the disk**, but gitignored.

- populate production figaro settings in local `config/application.yml`:

        production:
          secret_key_base: "d6ced..."

- add to `Capfile`:

        require 'capistrano/figaro_yml'

- create figaro `application.yml` file on the remote server by executing this task:

        $ bundle exec cap production setup

You can now proceed with other deployment tasks.

#### What if a new config is added to figaro file?

- add it to local `config/application.yml`:

        production:
          secret_key_base: "d6ced..."
          foobar: "some_other_secret"

- if you're working in a team where other people have the deploy rights, compare
  you local `application.yml` with the one on the server. This is to ensure you
  didn't miss an update.
- copy to the server:

        $ bundle exec cap production setup

- notify your colleagues that have the deploy rights that the remote
  `application.yml` has been updated so they can change their copy.


### How it works

When you execute `$ bundle exec cap production setup`:

- figaro settings from your local `application.yml` are copied to the server.<br/>
- only "stage" secrets are copied: if you are deploying to `production`,
  only production secrets are copied there
- on the server secrets file is located  in `#{shared_path}/config/application.yml`

On deployment:

- secrets file is automatically symlinked to `#{current_path}/config/application.yml`

### Configuration

None.

### More Capistrano automation?

Check out [capistrano-plugins](https://github.com/capistrano-plugins) github org.

### License

[MIT](LICENSE.md)
