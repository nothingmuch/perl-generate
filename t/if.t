#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';
use ok "Perl::Generate::AST::Node::If";

use Perl::Generate::AST::Node::Var::Scalar;
use Perl::Generate::AST::Node::Subcall;

our $foo = 1;

my $i;
sub moose { $i++ }

my $if = Perl::Generate::AST::Node::If->new(
	cond => my $cond = Perl::Generate::AST::Node::Var::Scalar->new( name => "foo" ),
	true => my $body = Perl::Generate::AST::Node::Subcall->new( subname => "moose" ),
);

ok( eval $cond->stringify, "condition is true" );

eval $body->stringify;

is( $i, 1, "body is OK" );

eval $if->stringify;

is( $i, 2, "moose called" );

$foo = 0;

eval $if->stringify;

is( $i, 2, "moose not called" );

