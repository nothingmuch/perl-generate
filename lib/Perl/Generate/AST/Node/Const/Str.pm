#!/usr/bin/perl

package Perl::Generate::AST::Node::Const::Str;
use Moose;

with qw/
	Perl::Generate::AST::Node::Const
/;

use Data::Dumper ();

has value => (
	isa => "Str",
	is  => "rw",
	required => 1,
);

sub ppi {
	my ( $self, $e ) = @_;

	PPI::Token::Quote::Double->new( Data::Dumper::qquote( $self->value ) );
}

__PACKAGE__;

__END__

