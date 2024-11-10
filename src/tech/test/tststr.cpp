#include <stdio.h>
#include <stdlib.h>
#include "tcl/str.hpp"

int main(void)
{
	TCDynStr	test("Test");

	test.hash();
    return 0;
}
