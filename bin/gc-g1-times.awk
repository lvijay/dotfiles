#!/bin/gawk -f

## Analyzes the G1 GC logs.  Given a timespan window, aggregates the
## time for which the application threads were stopped and time it
## took to stop the application threads.

## Outputs tuples of timestamp time-since-last-gc app_thread_total stop_thread_total

BEGIN {
    prev_time = -1;
    app_thread_total = 0;
    stop_thread_total = 0;
    if (!timespan) {
        timespan = 120
    }
}
/time for which application threads were stopped/ {
    timestamp = $1
    evt_time = $2;
    sub(/:$/, "", timestamp);
    sub(/:/, "", evt_time);
    app_stop = $11;
    thrd_stop = $16;
    if (prev_time == -1) prev_time=evt_time;
    elapsed_time = evt_time - prev_time;
    if (elapsed_time > timespan) {
        print timestamp, elapsed_time, app_thread_total, stop_thread_total;
        prev_time = -1;
        app_thread_total = app_stop;
        stop_thread_total = thrd_stop;
    } else {
        app_thread_total += app_stop;
        stop_thread_total += thrd_stop;
    }
} END {
    print timestamp, elapsed_time, app_thread_total, stop_thread_total;
}
