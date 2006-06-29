#!/usr/bin/perl

package Perl::Generate::AST::Node;
use Moose::Role;

use PPI ();

requires "ppi";

sub stringify {
	my $self = shift;

	my $f = PPI::Document::Fragment->new;
	$f->add_element( $_ ) for $self->ppi;
	return $f->serialize;
}

__PACKAGE__;

__END__

=pod

=head1 NAME

Perl::Generate::AST::Node - Base role for Perl 5 AST nodes.

=head1 SYNOPSIS

	use Moose;

	with qw/Perl::Generate::AST::Node/;

=head1 DESCRIPTION

All nodes in L<Perl::Generate::AST> do this role.

=cut


