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

use App::TaskBuilder::Heavy;

pass "use App::TaskBuilder::Heavy";

my $builder = App::TaskBuilder::Heavy->new;

done_testing;
