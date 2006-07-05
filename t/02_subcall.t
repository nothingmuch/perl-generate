#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use ok 'Perl::Generate::AST::Node::Subcall';

use Perl::Generate::AST::Node::Var::Scalar;

sub foo { "magic" };

my $sub = Perl::Generate::AST::Node::Subcall->new(
	code => "foo",
);

can_ok( $sub, "ppi" );

isa_ok( $sub->ppi, "PPI::Node" );

can_ok( $sub, "stringify" );

is( eval $sub->stringify, "magic", "code is correct" );

our $foo = sub { 42 };

my $cref = Perl::Generate::AST::Node::Subcall->new(
	code => Perl::Generate::AST::Node::Var::Scalar->new( name => 'foo' ),
);

isa_ok( $cref, "Perl::Generate::AST::Node::Subcall" );

is( eval $cref->stringify, 42, "code ref also possible" );
