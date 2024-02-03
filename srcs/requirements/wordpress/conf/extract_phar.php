<?php
// Open the Phar archive for reading
$phar = new Phar('/usr/local/bin/wp-cli.phar');

// Extract all files from the Phar archive to the specified directory
$phar->extractTo('usr/local/bin/wp');