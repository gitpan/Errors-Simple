#!/usr/bin/perl

use warnings;
use strict;
use Errors::Simple;

print "1..7\n";

require "t/test_class.pl";
print "ok 1\n";

my $obj = Errors::Simple::Test->new();

if($obj)	{
	print "ok 2\n";
}
else	{
	print "not ok 2\n";
}

if(!$obj->something())	{
	print "ok 3\n";

	if($obj->e_check())	{
		print "ok 4\n";

		my $output;

		if($output = $obj->e_text())	{
			print "ok 5\n";
		}
		else	{
			print "not ok 5\n";
		}

		if($output = $obj->e_html())	{
			print "ok 6\n";
		}
		else	{
			print "not ok 6\n";
		}

		$obj->e_flush();

		if(!$obj->e_check())	{
			print "ok 7\n";
		}
		else	{
			print "not ok 7\n";
		}
	}
	else	{
		print "not ok 4\n";
	}
}
else	{
	print "not ok 3\n";
}
