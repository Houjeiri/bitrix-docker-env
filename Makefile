bitrix-download:
	wget https://www.1c-bitrix.ru/download/standard_encode.tar.gz -P ./www
	wget http://www.1c-bitrix.ru/download/scripts/restore.php -P ./www
	chmod -R 0777 www