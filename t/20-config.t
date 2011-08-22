#!/usr/local/bin/perl

BEGIN { # emacs changes cwd
    chdir '..' while not -d 't';
    use lib 'lib';
}

use strict;
use warnings FATAL => 'all';
#use diagnostics;

use Data::Dump;
#use Carp qw();

$|=1;
################################################################################
use Test::Most;

use App::TaskBuilder::Heavy::Config;

throws_ok {
    App::TaskBuilder::Heavy::Config->new;
} qr/^The following errors were/, 'no args to new()';

$ENV{EMAIL} = 'me@here';

my $cfg;
lives_ok {
    $cfg = App::TaskBuilder::Heavy::Config->new(
        abstract => 'It does stuff',
        author   => 'me',
        name     => 'App::Foo::Bar',
        version  => '1.00',
    );
} "new() works with correct args";

ok $cfg, "Config->new returned something";
isa_ok $cfg, 'App::TaskBuilder::Heavy::Config';

is $cfg->version, '1.00', "can initialise attributes";
is $cfg->version('1.01'), '1.01', "looks like attributes can be changed";
is $cfg->version, '1.01', "yes, attributes can be changed";
is $cfg->email, 'me@here', "email has been correctly initialised";

done_testing;
