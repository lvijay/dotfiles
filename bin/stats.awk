#!/usr/bin/env gawk -f

## Given a file with first column being timing numbers, computes
## count, min, max, avg, median, p90, p95, p99, variance, stddev

BEGIN {
    min = 10000000
    if (!idx)
        idx = 1;
}

{
    records[NR] = $idx
    sum += $idx;
    if ($idx < min) min = $idx;
}

END {
    if (NR == 0) {
        avg = "-"
        pc50 = "-"
        pc90 = "-"
        pc95 = "-"
        pc99 = "-"
        max = "-"
        min = "-"
    } else {
        avg = sum / NR
        asort(records);
        for (i=1; i<NR; ++i) {
            diff = records[i] - avg;
            variance += (diff * diff)
        }
        variance /= NR
        ipc50 = int(NR / 2);
        ipc90 = int(NR * 0.90);
        ipc95 = int(NR * 0.95);
        ipc99 = int(NR * 0.99);
        pc50 = records[ipc50];
        pc90 = records[ipc90];
        pc95 = records[ipc95];
        pc99 = records[ipc99];
        max = records[NR];
        stddev = sqrt(variance);
    }
    print NR "," min "," max "," avg "," pc50 "," pc90 "," pc95 "," pc99 "," variance "," stddev
}

## stats.awk ends here
