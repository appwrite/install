#!/bin/env php
<?php

require_once __DIR__.'/../vendor/autoload.php';

global $request;

use Utopia\CLI\CLI;
use Utopia\CLI\Console;

$cli = new CLI();

$cli
    ->task('start')
    ->desc('Install Appwrite')
    ->action(function () {
        Console::success('Starting Appwrite installation...');

        $hostname = Console::confirm('Choose your server hostname: (default: \'localhost\')');
        $hostname = ($hostname) ? $hostname : 'localhost';
        
        $httpPort = Console::confirm('Choose your server HTTP port: (default: \'80\')');
        $httpPort = ($httpPort) ? $httpPort : 80;
        
        $httpsPort = Console::confirm('Choose your server HTTPS port: (default: \'443\')');
        $httpsPort = ($httpsPort) ? $httpsPort : 443;
        
        $cname = Console::confirm('Choose a CNAME target for your custom domains: (default: \''.$hostname.'\')');
        $cname = ($cname) ? $cname : $hostname;
        
        Console::log($hostname);
        Console::log($cname);



    });

$cli->run();
