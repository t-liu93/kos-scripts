// Landing script for my first generation Lunar probe.
// This script should be suitable for any probe with unlimitted restartable engines.
// However, it is made for a 400kg probe with an AJ10-Mid engine for de-orbiting and satellite engine for final approach.
// The TWR (local to moon) should be at least 2.2.

function engine_on
{
    set ship:control:mainthrottle to 1.0.
}

function engine_off
{
    set ship:control:mainthrottle to 0.0.
}

function kill_horizontal
{
    set ship:control:mainthrottle to 1.0.
    until (altitude - ship:geoposition:terrainheight) < 1000 or ship:groundspeed < 50
    {
        // print "Alt: " + (altitude - ship:geoposition:terrainheight) + ", gs: " + ship:groundspeed.
        lock steering to (-1) * ship:velocity:surface - ship:up:vector * 80.
        wait 1.
    }
    set ship:control:mainthrottle to 0.0.
    list engines in engs.
    for eng in engs
    {
        if eng:ignition
        {
            set eng:gimbal:limit to 5.
        }
    }
}

function decouple_aj10
{
    if stage:number = 1
    {
        // Switch the fuel according to your own situation.
        if stage:udmh < 10 or stage:hydrazine < 0.01
        {
            stage.
            gear on.
        }
    }
}

function final_landing
{
    lock steering to (-1) * ship:velocity:surface - ship:up:vector * 20.

    until (altitude - ship:geoposition:terrainheight) < 2
    {
        decouple_aj10().
        // print "Alt: " + (altitude - ship:geoposition:terrainheight) + ", gs: " + ship:groundspeed.
        if ship:groundspeed < 0.05
        {
            lock steering to  ship:up.
        }
        if (altitude - ship:geoposition:terrainheight) > 10000
        {
            set vel_min to -150.
            set vel_max to -120.
        }
        else if (altitude - ship:geoposition:terrainheight) > 5000
        {
            set vel_min to -100.
            set vel_max to -90.
        }
        else if (altitude - ship:geoposition:terrainheight) > 1000
        {
            set vel_min to -55.
            set vel_max to -45.
        }
        else
        {
            set vel_min to (-1) * ((altitude - ship:geoposition:terrainheight) / 10).
            if vel_min < -30
            {
                set vel_min to -30.
            }
            set vel_max to vel_min + 10.
        }

        if vel_max > 0
        {
            set vel_max to -3.
        }

        if altitude - ship:geoposition:terrainheight < 10
        {
            set vel_min to -1.
            set vel_max to -0.5.
        }

        if ship:verticalspeed < vel_min
        {
            engine_on().
        }
        if ship:verticalspeed > vel_max
        {
            engine_off().
        }
        wait 0.5.
    }
    set ship:control:mainthrottle to 0.0.
}

function land
{
    lock steering to ship:retrograde.
    until (altitude - ship:geoposition:terrainheight) < 40000
    {
        // print "Alt: " + (altitude - ship:geoposition:terrainheight).
        wait 1.
    }
    kill_horizontal().

    final_landing().
    unlock steering.
    unlock throttle.
}

land().