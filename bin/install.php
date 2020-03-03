#!/bin/env php
<?php

require_once __DIR__.'/../vendor/autoload.php';

global $request;

use Utopia\CLI\CLI;
use Utopia\CLI\Console;
use Utopia\Validator\Domain;
use Utopia\Validator\Range;
use Utopia\Validator\URL;

$cli = new CLI();

$cli
    ->task('start')
    ->desc('Install Appwrite')
    ->param('source', 'https://appwrite.io', function() {return new URL();}, 'Installation source', true)
    ->param('domain', 'localhost', function() {return new Domain();}, 'Installation domain', true)
    ->param('httpPort', 80, function() {return new Range(0, 65535);}, 'Installation HTTP port', true)
    ->param('httpsPort', 443, function() {return new Range(0, 65535);}, 'Installation HTTPS port', true)
    ->param('cname', 'localhost', function() {return new Domain();}, 'Installation CNAME target', true)
    ->action(function ($source, $domain, $httpPort, $httpsPort, $cname) {
        Console::success('Starting Appwrite installation...');

        if(!empty($domain)) {
            $domain = Console::confirm('Choose your server hostname: (default: \'localhost\')');
            $domain = ($domain) ? $domain : 'localhost';
        }

        if(!empty($httpPort)) {
            $httpPort = Console::confirm('Choose your server HTTP port: (default: 80)');
            $httpPort = ($httpPort) ? $httpPort : 80;
        }
        
        if(!empty($httpsPort)) {
            $httpsPort = Console::confirm('Choose your server HTTPS port: (default: 443)');
            $httpsPort = ($httpsPort) ? $httpsPort : 443;
        }
        
        if(!empty($cname)) {
            $cname = Console::confirm('Choose a CNAME target for your custom domains: (default: \''.$domain.'\')');
            $cname = ($cname) ? $cname : $domain;
        }
        
        $composeUrl = $source.'/docker-compose.yml?'.http_build_query([
            'domain' => $domain,
            'httpPort' => $httpPort,
            'httpsPort' => $httpPort,
            'cname' => $cname,
        ]);

        $composeFile = @file_get_contents($composeUrl);

        if(!$composeFile) {
            throw new Exception('Failed to fetch Docker Compose file');
        }
        
        if(!file_put_contents('/install/data/docker-compose.yml', $composeFile)) {
            throw new Exception('Failed to save Docker Compose file');
        }

        shell_exec('docker-compose -f /install/data/docker-compose.yml up -d');
    });

$cli->run();
