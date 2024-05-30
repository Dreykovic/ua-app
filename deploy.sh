sudo apt install apache2 apache2-utils libexpat1 python3 python3-dev libapache2-mod-wsgi-py3
cd /var/www/
git clone https://github.com/Dreykovic/ua-app.git
cp ua-app/ua.conf /etc/apache2/sites-available/ua.conf

chown www-data:www-data ua-app/
chown www-data:www-data ua-app/db.sqlite3 
chmod 775 ua-app/
chmod 664 ua-app/db.sqlite3 
apt install python3-venv
apt install python3-tk
cd ua-app/
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt 
a2ensite caert.egotransfert.com.conf 
a2dissite 000-default.conf 
systemctl restart apache2



git pull
cp app.service /etc/systemd/system/caert.service 
systemctl status caert.service 
systemctl stop caert.service 
systemctl daemon-reload
systemctl stop caert.service 
systemctl start caert.service 
systemctl status caert.service 


echo "<VirtualHost *:80>
    ServerAdmin dreybirewa@gmail.com
    ServerName egotransfert.com
    ServerAlias www.egotransfert.com

    DocumentRoot /var/www/ua-app

    Alias /static /var/www/ua-app/static
    <Directory /var/www/ua-app/static>
        Require all granted
    </Directory>

    Alias /media /var/www/ua-app/media
    <Directory /var/www/ua-app/media>
        Require all granted
    </Directory>

    <Directory /var/www/ua-app/ua>
        <Files wsgi.py>
            Require all granted
        </Files>
    </Directory>

    WSGIDaemonProcess caert user=www-data group=www-data threads=2 python-path=/var/www/ua-app python-home=/var/www/ua-app/venv
    WSGIProcessGroup caert
    WSGIScriptAlias / /var/www/ua-app/ua/wsgi.py application-group=%{GLOBAL}

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
" > /etc/apache2/sites-available/ua.conf


echo "[Unit]
Description=AMONA Audrey Birewa Audrey
After=network.target

[Service]
WorkingDirectory=/var/www/ua-app
ExecStart=/var/www/ua-app/venv/bin/gunicorn -w 4 --bind 0.0.0.0:8000 ua.wsgi:application

Type=simple
User=root
Group=root

[Install]
WantedBy=default.target" > /systemd/system/caert.service