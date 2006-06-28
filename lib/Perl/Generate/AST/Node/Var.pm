#!/usr/bin/perl

package Perl::Generate::AST::Node::Var;
use Moose::Role;

with qw/
	Perl::Generate::AST::Node::LV
/;

has name => (
	isa => "Str",
	is  => "rw",
	required => 1,
);

requires "sigil";

sub fullname {
	my $self = shift;
	$self->sigil . $self->name
}

sub ppi {
	my $self = shift;
	PPI::Token::Symbol->new( $self->fullname );
}


__PACKAGE__;

__END__

=pod

=head1 NAME

Perl::Generate::AST::Node::Var - Base role for var nodes.

=cut


