#!/usr/bin/perl

package Perl::Generate::AST::Node::Var::Scalar;
use Moose;

with qw/
	Perl::Generate::AST::Node::Var
/;

sub sigil { '$' }

__PACKAGE__;

__END__

=pod

=head1 NAME

Perl::Generate::AST::Node::Var::Scalar - Scalar variable nodes.

=head1 SYNOPSIS

	use Perl::Generate;

	my $var_node = var('$foo');

	$var_node->ppi; # PPI::Token::Symbol

	our $foo = 45;
	eval $var_node->stringify; # 45

=cut


