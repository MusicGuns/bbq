# Eventmaker
Web app for managing events. Create events, subscribe to them, comment on them, attach photos, restrict access to them.

## Deployment
http://bbqmaker.space

## Technology stack
Backend:
* Rails 7
* Yandex Cloud bucket for storaging photos
* Resque workers
* OAuth via VK and Yandex

Frontend:
* Lightbox2
* Yandex maps

## Launching
1. Clone repo
1. Install `libvips`
1. Use bundler
1. Setup your API keys:
>__credentials.yml.enc__
>```
>secret_key_base:
>
>yc:
>  access_key_id:
>  secret_access_key:
>
>yandex_maps_api_key: 
>
>development:
>  omniauth_ya_id: 
>  omniauth_ya_secret: 
>
>test:
>  omniauth_ya_id: 
>  omniauth_ya_secret: 
>
>production:
>  omniauth_ya_id: 
>  omniauth_ya_secret: 
>```
5. Setup your psql
1. Change `database.yml`
1. Create a new database and run migrations
1. Run workers `QUEUE=eventmaker* bundle exec rake environment resque:work`
1. Run application
1. Enjoy

Also you can deploy it via capistrano (configure it for your vps before).
