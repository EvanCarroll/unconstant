use Test::More tests => 8;

package Foo1 {
	use constant BAR => (1,2,3,4);
	sub baz { BAR }
}

BEGIN {
	no warnings 'redefine';
	is( Foo1::baz, 4, 'Constant length set right initially' );
	*Foo1::BAR = sub { 42 };
	is( Foo1::baz, 4, 'Constants are inlined' );
}

package Foo2 {
	use unconstant;
	use constant BAR => (1,2,3);
	sub baz { BAR }
}

BEGIN {
	no warnings 'redefine';
	is( Foo2::baz, 3, 'Constant length set right initially' );
	*Foo2::BAR = sub { 1,2,3,4,5,6; };
	is( Foo2::baz, 6, 'Constant not inlined' );
}

package Foo3 {
	use unconstant;
	no unconstant;
	use constant BAR => (1,2,3,4,5);
	sub baz { BAR }
}

BEGIN {
	no warnings 'redefine';
	is( Foo3::baz, 5, 'Constant length set right initially' );
	*Foo3::BAR = sub { 42 };
	is( Foo3::baz, 5, 'Constant are inlined again after use of [no constant]' );
}

package Foo4 {
	use unconstant;
	use constant BAR => ();
	use constant BAZ => undef;
	sub bar { BAR }
	sub baz { BAZ }
}

BEGIN {
	no warnings 'redefine';
	is( Foo4::bar, undef, 'Empty list as a constant value is hadled correctly' );
	is( Foo4::baz, undef, 'undef as a constant value is hadled correctly' );
}

1;
