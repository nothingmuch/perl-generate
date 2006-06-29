#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';
use ok "Perl::Generate::AST::Node::Assignment";

use Perl::Generate::AST::Node::Var::Scalar;

can_ok( "Perl::Generate::AST::Node::Assignment", "lvalue" );
can_ok( "Perl::Generate::AST::Node::Assignment", "rvalue" );

our ( $foo, $bar );

$bar = 123;

my $a = Perl::Generate::AST::Node::Assignment->new(
	lvalue => Perl::Generate::AST::Node::Var::Scalar->new( name => "foo" ),
	rvalue => Perl::Generate::AST::Node::Var::Scalar->new( name => "bar" ),
);

eval $a->stringify;

is( $foo, $bar, "eval" );

