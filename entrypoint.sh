#!/bin/bash
#########################################################################
# © Ronan LE MEILLAT 2023
# released under the GPLv3 terms
#########################################################################
chmod -R ugo+rwx /var/www/html/storage
BASE_URL=${BASE_URL:-'http://localhost:8888'}
LANGUAGE=${LANGUAGE:-'english'}
DEBUG=${DEBUG:-'FALSE'}
DB_HOST=${DB_HOST:-'mysql'}
DB_NAME=${DB_NAME:-'easyappointments'}
DB_USERNAME=${DB_USERNAME:-'root'}
DB_PASSWORD=${DB_PASSWORD:-'hellodocker'}
GOOGLE_SYNC_FEATURE=${GOOGLE_SYNC_FEATURE:-'FALSE'}
GOOGLE_PRODUCT_NAME=${GOOGLE_PRODUCT_NAME:-''}
GOOGLE_CLIENT_ID=${GOOGLE_CLIENT_ID:-''}
GOOGLE_CLIENT_SECRET=${GOOGLE_CLIENT_SECRET:-''}
GOOGLE_API_KEY=${GOOGLE_API_KEY:-''}
MAIL_USERAGENT=${MAIL_USERAGENT:-'HCF!Schedule'}
MAIL_PROTOCOL=${MAIL_PROTOCOL:-'smtp'}
MAIL_TYPE=${MAIL_TYPE:-'html'}
MAIL_SMTP_DEBUG=${MAIL_SMTP_DEBUG:-'1' }
MAIL_SMTP_AUTH=${MAIL_SMTP_AUTH:-'FALSE'}
MAIL_SMTP_HOST=${MAIL_SMTP_HOST:-'smtpd'}
MAIL_SMTP_USER=${MAIL_SMTP_USER:-''}
MAIL_SMTP_PASS=${MAIL_SMTP_PASS:-''}
MAIL_SMTP_CRYPTO=${MAIL_SMTP_CRYPTO:-''}
MAIL_SMTP_PORT=${MAIL_SMTP_PORT:-'25'}

cat << EOF > /var/www/html/config.php
<?php
class Config {

    // ------------------------------------------------------------------------
    // GENERAL SETTINGS
    // ------------------------------------------------------------------------

    const BASE_URL      = '$BASE_URL';
    const LANGUAGE      = '$LANGUAGE';
    const DEBUG_MODE    = $DEBUG;

    // ------------------------------------------------------------------------
    // DATABASE SETTINGS
    // ------------------------------------------------------------------------

    const DB_HOST       = '$DB_HOST';
    const DB_NAME       = '$DB_NAME';
    const DB_USERNAME   = '$DB_USERNAME';
    const DB_PASSWORD   = '$DB_PASSWORD';

    // ------------------------------------------------------------------------
    // GOOGLE CALENDAR SYNC
    // ------------------------------------------------------------------------

    const GOOGLE_SYNC_FEATURE   = $GOOGLE_SYNC_FEATURE; // Enter TRUE or FALSE
    const GOOGLE_PRODUCT_NAME   = '$GOOGLE_PRODUCT_NAME';
    const GOOGLE_CLIENT_ID      = '$GOOGLE_CLIENT_ID';
    const GOOGLE_CLIENT_SECRET  = '$GOOGLE_CLIENT_SECRET';
    const GOOGLE_API_KEY        = '$GOOGLE_API_KEY';
}
?>
EOF
cat << EOF > /var/www/html/application/config/email.php
<?php defined('BASEPATH') or exit('No direct script access allowed');
\$config['useragent'] = '$MAIL_USERAGENT';
\$config['protocol'] = '$MAIL_PROTOCOL';
\$config['mailtype'] = '$MAIL_TYPE';
\$config['smtp_debug'] = '$MAIL_SMTP_DEBUG'; 
\$config['smtp_auth'] = $MAIL_SMTP_AUTH;
\$config['smtp_host'] = '$MAIL_SMTP_HOST';
\$config['smtp_user'] = '$MAIL_SMTP_USER';
\$config['smtp_pass'] = '$MAIL_SMTP_PASS';
\$config['smtp_crypto'] = '$MAIL_SMTP_CRYPTO'; 
\$config['smtp_port'] = $MAIL_SMTP_PORT;
EOF
apache2-foreground