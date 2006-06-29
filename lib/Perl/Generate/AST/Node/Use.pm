#!/usr/bin/perl

package Perl::Generate::AST::Node::Use;
use Moose;

with qw/
	Perl::Generate::AST::Node::Stmt
/;

has module => (
	isa => "Str",
	is  => "rw",
	required => 1,
);

has no_imports => (
	isa => "Bool",
	is  => "rw",
	default => 0,
);

has imports => (
	does => "Perl::Generate::AST::Node::Expr",
	is   => "rw",
	required => 0,
);

sub ppi {
	my $self = shift;

	my $s = PPI::Statement::Include->new( PPI::Token::Word->new("use") );

	$s->__add_element( PPI::Token::Whitespace->new(' ') );

	$s->__add_element( PPI::Token::Word->new( $self->module ) );

	if ( my $imports = $self->imports or $self->no_imports ) {
		$s->__add_element( PPI::Token::Whitespace->new(' ') );
		my $l = PPI::Structure::List->new( PPI::Token::Structure->new('(') );

		if ( $imports ) {
			$l->__add_element($_) for $imports->ppi;
		}

		$l->_set_finish( PPI::Token::Structure->new(')') );

		$s->__add_element($l);
	}

	return $s;
}

__PACKAGE__;

__END__

=pod

=head1 NAME

Perl::Generate::AST::Node::Use - Use statements

=cut

