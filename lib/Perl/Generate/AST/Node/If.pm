#!/usr/bin/perl

package Perl::Generate::AST::Node::If;
use Moose;
use Moose::Util::TypeConstraints;

with qw/
	Perl::Generate::AST::Node
/;

use Perl::Generate::AST::Node::Block;

has cond => (
	does => "Perl::Generate::AST::Node::RV",
	is   => "rw",
	required => 1,
);

has true => (
	isa => "Perl::Generate::AST::Node::Block",
	is  => "rw",
	required => 1,
	coerce   => 1,
);

use Data::Dumper;
my $if_or_block = __PACKAGE__ . "IfOrBlock";
subtype $if_or_block =>
	=> as "Object"
	=> where { $_->isa(__PACKAGE__) || $_->isa("Perl::Generate::AST::Node::Block") };

coerce $if_or_block
	=> from "Perl::Generate::AST::Node",
	=> via {
		return $_ if $_->isa(__PACKAGE__);
		return $_ if $_->isa("Perl::Generate::AST::Node::Block");
		find_type_constraint("Perl::Generate::AST::Node::Block")->coercion->coerce($_);
	};

has false => (
	isa => $if_or_block,
	is  => "rw",
	required => 0,
	coerce   => 1,
);

sub ppi {
	my $self = shift;

	my $s = PPI::Statement::Compound->new(PPI::Token::Word->new("if"));

	$self->add_block_ppi( $s );

	$s;
}

sub add_block_ppi {
	my ( $self, $s ) = @_;

	my ( $cond, $true, $false ) = map { $self->$_ } qw/cond true false/;

	my $ppi_cond = PPI::Structure::Condition->new(
		PPI::Token::Structure->new('('),
	);

	$ppi_cond->__add_element( $_ ) for $cond->ppi;

	$ppi_cond->_set_finish( PPI::Token::Structure->new(')') );

	$s->__add_element( $ppi_cond );

	$s->__add_element( $true->ppi );

	if ( $false ) {
		if ( $false->isa(__PACKAGE__) ) {
			$s->__add_element( PPI::Token::Word->new("elsif") );
			$false->add_block_ppi( $s );
		} else {
			$s->__add_element( PPI::Token::Word->new("else") );
			$s->__add_element( $false->ppi );
		}
	}
}

__PACKAGE__;

__END__

=pod

=head1 NAME

Perl::Generate::AST::Node::If - 

=head1 SYNOPSIS

	use Perl::Generate::AST::Node::If;

=head1 DESCRIPTION

=cut


