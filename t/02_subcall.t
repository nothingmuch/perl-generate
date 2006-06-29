#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use ok 'Perl::Generate::AST::Node::Subcall';

sub foo { "magic" };

my $sub = Perl::Generate::AST::Node::Subcall->new(
	subname => "foo",
);

can_ok( $sub, "ppi" );

isa_ok( $sub->ppi, "PPI::Node" );

my $f = PPI::Document::Fragment->new;
$f->add_element( $sub->ppi );

can_ok( $sub, "stringify" );

is( eval $sub->stringify, "magic", "code is correct" );

