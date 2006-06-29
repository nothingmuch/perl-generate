#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';
use ok  "Perl::Generate::AST::Node::Use";

use Perl::Generate::AST::Node::Var::Scalar;

can_ok( "Perl::Generate::AST::Node::Use", "module" );
can_ok( "Perl::Generate::AST::Node::Use", "imports" );

my $use_time_hires = Perl::Generate::AST::Node::Use->new(
	module => "This::Module",
);

is( $use_time_hires->stringify,  "use This::Module", "use syntax" );


my $use_time_hires_none = Perl::Generate::AST::Node::Use->new(
	module     => "That::Module",
	no_imports => 1,
);

is( $use_time_hires_none->stringify,  "use That::Module ()", "use with no imports" );

my $use_time_hires_bar = Perl::Generate::AST::Node::Use->new(
	imports => Perl::Generate::AST::Node::Var::Scalar->new(name => 'bar'),
	module  => "Thyne::Modoule",
);

is( $use_time_hires_bar->stringify, 'use Thyne::Modoule ($bar)', "use with imports" );

