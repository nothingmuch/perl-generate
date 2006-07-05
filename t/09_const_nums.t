#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';
use ok 'Perl::Generate::AST::Node::Const::Num';

my $five = Perl::Generate::AST::Node::Const::Num->new( value => 5 );

is( eval $five->stringify, 5 );

my $five_and_a_half = Perl::Generate::AST::Node::Const::Num->new( value => 5.5 );

is( eval $five_and_a_half->stringify, 5.5 );
