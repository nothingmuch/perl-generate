#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';
use ok "Perl::Generate::AST::Node::If";

use Perl::Generate::AST::Node::Var::Scalar;
use Perl::Generate::AST::Node::Subcall;

our $foo = 1;
our $bar = 1;

my ( $m, $e );
sub moose { $m++ }
sub elk { $e++ };

my $if = Perl::Generate::AST::Node::If->new(
	cond => my $cond = Perl::Generate::AST::Node::Var::Scalar->new( name => "foo" ),
	true => my $body = Perl::Generate::AST::Node::Subcall->new( code => "moose" ),
);

ok( eval $cond->stringify, "condition is true" );

eval $body->stringify;

is( $m, 1, "body is OK" );

eval $if->stringify;

is( $m, 2, "moose called" );

$foo = 0;

eval $if->stringify;

is( $m, 2, "moose not called" );

my $if_else = Perl::Generate::AST::Node::If->new(
	cond => $cond,
	true => $body,
	false => Perl::Generate::AST::Node::Subcall->new( code => "elk" ),
);

like( $if_else->stringify, qr/else/, "contains an else" );

eval $if_else->stringify;

is( $e, 1, "elk called" );
is( $m, 2, "moose not called" );

my $elsif = Perl::Generate::AST::Node::If->new(
	cond => $cond,
	true => $body,
	false => Perl::Generate::AST::Node::If->new(
		cond => Perl::Generate::AST::Node::Var::Scalar->new( name => 'bar' ),
		true => Perl::Generate::AST::Node::Subcall->new( code => "elk" ),
	),
);

like( $elsif->stringify, qr/elsif/, "contains an elsif" );

eval $elsif->stringify;

is( $e, 2, "elk called" );
is( $m, 2, "moose not called" );

$bar = 0;

eval $elsif->stringify;

is( $e, 2, "elk not called" );
is( $m, 2, "moose not called" );

