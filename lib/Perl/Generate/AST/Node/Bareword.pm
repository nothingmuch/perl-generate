#!/usr/bin/perl

package Perl::Generate::AST::Node::Bareword;
use Moose;

with qw/
	Perl::Generate::AST::Node::RV
/;

has value => (
	isa => "Str",
	is  => "rw",
	required => 1,
);

sub ppi {
	my ( $self, $e ) = @_;

	PPI::Token::Word->new($self->value);
}

__PACKAGE__;

__END__
