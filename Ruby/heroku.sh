wget -qO- https://toolbelt.heroku.com/install.sh | sh
heroku login
git init && git commit -am "init"

sudo heroku login
sudo heroku create rubycoursera
git remote -v
sudo heroku auth:token
git push heroku master

username : blank
password : heroku auth token

where the auth token can be retrieved by $ heroku auth:token

rails new appname --database=postgresql

#config/database.yml
host: localhost
username: pguser
password: pguser_password

rake db:create

sudo heroku login
sudo heroku git:clone -a appname
cd appname

sudo git add .
sudo git commit -am "make it better"
sudo git push heroku master

sudo heroku run rake db:migrate

sudo heroku run rake rake db:seed