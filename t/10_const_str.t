#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use ok 'Perl::Generate::AST::Node::Const::Str';

foreach my $orig (
	"foo",
	"blah blah blah",
	q("moose"), q('moose'),
	q#'"fajhdt$1{}!()#,
	"\x{92}",
	'$foo',
	'@{[ die ]}',
	"\0",
	"\n\r",
) {

	my $str = Perl::Generate::AST::Node::Const::Str->new( value => $orig );

	is( eval $str->stringify, $orig, "roundrip safe" );
}


