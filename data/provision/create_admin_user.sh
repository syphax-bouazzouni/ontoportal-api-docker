random_password=$(openssl rand -hex 12)
echo "Creating admin user with a random password"
bundle exec rake user:create[admin,admin@nodomain.org,$random_password] >/dev/null
echo "Make user admin"
bundle exec rake user:adminify[admin] > /dev/null
