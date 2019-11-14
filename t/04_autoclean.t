use Test::More tests => 2;

package Foo {
	use unconstant;
	use constant FOO => 42;
}

package Bar {
	use namespace::autoclean;
	use unconstant;
	use constant FOO => 42;
}

is ( Foo::FOO, 42, "Without namespace::autoclean" );
is ( Bar::FOO, 42, "With namespace::autoclean" );

