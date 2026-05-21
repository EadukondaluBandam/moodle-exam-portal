#!/bin/bash

if [ ! -f /var/www/html/config.php ]; then
cat > /var/www/html/config.php <<EOF
<?php
unset(\$CFG);
global \$CFG;
\$CFG = new stdClass();

\$CFG->dbtype = 'pgsql';
\$CFG->dblibrary = 'native';
\$CFG->dbhost = getenv('MOODLE_DATABASE_HOST');
\$CFG->dbname = getenv('MOODLE_DATABASE_NAME');
\$CFG->dbuser = getenv('MOODLE_DATABASE_USER');
\$CFG->dbpass = getenv('MOODLE_DATABASE_PASSWORD');
\$CFG->prefix = 'mdl_';
\$CFG->dboptions = array (
  'dbpersist' => 0,
  'dbport' => 5432,
);

\$CFG->wwwroot = 'https://moodle-exam.onrender.com';
\$CFG->dataroot = '/tmp/moodledata';
\$CFG->admin = 'admin';

require_once(__DIR__ . '/lib/setup.php');
EOF
fi

mkdir -p /tmp/moodledata
chmod -R 777 /tmp/moodledata

apache2-foreground
