#!/usr/bin/perl

use warnings;
use strict;

use Errors::Simple;

print "1..1\n";

my $err = Errors::Simple->e_new();

if($err)	{
	print "ok 1\n";
}
else	{
	print "not ok 1\n";
}
