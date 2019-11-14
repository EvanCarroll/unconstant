use Test::More tests => 2;

package Foo {

	use constant TEST => 4;

	sub d {
		return TEST / 2;
	}
}


package Bar {

use unconstant;
	use constant TEST => 4;

	sub d {
		return TEST / 2;
	}
}


is( Foo::d(), 2 );
no warnings 'redefine';
*Bar::TEST=sub{2};
is( Bar::d(), 1 );


