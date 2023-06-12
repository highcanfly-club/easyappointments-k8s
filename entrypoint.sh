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

apache2-foreground