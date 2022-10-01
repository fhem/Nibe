################################################
# test Set
################################################
package main;

use strict;
use warnings;
use Test::More;

# used to import of FHEM functions from fhem.pl
use GPUtils qw(:all);
BEGIN {
    GP_Import(
        qw(
            fhem
            FhemTestUtils_gotLog
            FhemTestUtils_resetLogs
        )
    );
}

# execute
{
    # Start populate the reading(s)
    readingsBeginUpdate($::defs{nibe});

    NIBE_ParseSingleRegister($::defs{nibe}, '5c00206a06a3b70100c80091', 5);

    readingsEndUpdate($::defs{nibe}, 1);
}
is(FhemTestUtils_gotLog("nibe: Found register Heat_Offset_S1"), 1, "Register not found");
is(FhemTestUtils_gotLog("nibe: Value 0001 normalized 1"), 1, "Value incorrect");
is(ReadingsVal("nibe", "Heat_Offset_S1", ""), "1", "Reading missing");

FhemTestUtils_resetLogs();

{
    # Start populate the reading(s)
    readingsBeginUpdate($::defs{nibe});

    NIBE_ParseSingleRegister($::defs{nibe}, '5c00206a06a3b70000c80090', 5);

    readingsEndUpdate($::defs{nibe}, 1);
}
is(FhemTestUtils_gotLog("nibe: Found register Heat_Offset_S1"), 1, "Register not found");
is(FhemTestUtils_gotLog("nibe: Value 0000 normalized 0"), 1, "Value incorrect");
is(ReadingsVal("nibe", "Heat_Offset_S1", ""), "0", "Reading missing");

FhemTestUtils_resetLogs();

{
    # Start populate the reading(s)
    readingsBeginUpdate($::defs{nibe});

    NIBE_ParseSingleRegister($::defs{nibe}, '5c00206a06a3b7ffffc80090', 5);

    readingsEndUpdate($::defs{nibe}, 1);
}
is(FhemTestUtils_gotLog("nibe: Found register Heat_Offset_S1"), 1, "Register not found");
is(FhemTestUtils_gotLog("nibe: Value ffff normalized -1"), 1, "Value incorrect");
is(ReadingsVal("nibe", "Heat_Offset_S1", ""), "-1", "Reading missing");

FhemTestUtils_resetLogs();

{
    # Start populate the reading(s)
    readingsBeginUpdate($::defs{nibe});

    NIBE_ParseSingleRegister($::defs{nibe}, '5c00206a06a3b7feffc80091', 5);

    readingsEndUpdate($::defs{nibe}, 1);
}
is(FhemTestUtils_gotLog("nibe: Found register Heat_Offset_S1"), 1, "Register not found");
is(FhemTestUtils_gotLog("nibe: Value fffe normalized -2"), 1, "Value incorrect");
is(ReadingsVal("nibe", "Heat_Offset_S1", ""), "-2", "Reading missing");

done_testing;
exit(0);

1;