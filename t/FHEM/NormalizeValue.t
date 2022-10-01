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
is(NIBE_NormalizedValue('s8', '0000'), 0);
is(NIBE_NormalizedValue('s8', '0001'), 1);
is(NIBE_NormalizedValue('s8', '0010'), 16);

is(NIBE_NormalizedValue('s8', '00'), 0);
is(NIBE_NormalizedValue('s8', '01'), 1);
is(NIBE_NormalizedValue('s8', '10'), 16);

is(NIBE_NormalizedValue('s8', '000f'), 15);
is(NIBE_NormalizedValue('s8', 'FFF0'), -16);

is(NIBE_NormalizedValue('s8', '0f'), 15);
is(NIBE_NormalizedValue('s8', 'F0'), -16);
is(NIBE_NormalizedValue('s8', 'ff'), -1);

is(NIBE_NormalizedValue('s8', '007f'), 127);
is(NIBE_NormalizedValue('s8', 'ff80'), -128);

done_testing;
exit(0);

1;