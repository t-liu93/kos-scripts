// Landing script for my first generation Lunar probe.
// This script should be suitable for any probe with unlimitted restartable engines.
// However, it is made for a 400kg probe with an AJ10-Mid engine for de-orbiting and satellite engine for final approach.
// The TWR (local to moon) should be at least 2.2.
set steeringmanager:maxstoppingtime to 5.
set steeringmanager:pitchpid:kd to 1.
set steeringmanager:yawpid:kd to 1.
set steeringmanager:rollpid:kd to 1.
set g_moon to moon:mu / (altitude + body:radius) ^ 2.

set phase to 1.

function engine_on
{
    set ship:control:mainthrottle to 1.0.
}

function engine_off
{
    set ship:control:mainthrottle to 0.0.
}

function get_agl
{
    return altitude - ship:geoposition:terrainheight.
}

function kill_horizontal
{
    print "Phase 1: Kill horizontal speed. ".
    lock steering to (-1) * (vxcl(ship:up:vector, ship:velocity:surface)).
    // lock steering to (-1) * ship:velocity:surface - ship:up:vector * 80.
    engine_on().
    wait until (altitude - ship:geoposition:terrainheight) < 1000 or ship:groundspeed < 1.5.
    engine_off().

    list engines in engs.
    for eng in engs
    {
        if eng:ignition and eng:hasgimbal
        {
            set eng:gimbal:limit to 5.
        }
    }

    set phase to 2.
}

function final_approach
{
    print "Phase 2: Final approach. ".
    wait until ship:angularvel:x < 0.01 and ship:angularvel:y < 0.01.
    until get_agl() < 1000
    {
        // print "Alt: " + (altitude - ship:geoposition:terrainheight) + ", gs: " + ship:groundspeed.
        if get_agl() > 10000
        {
            set vel_min to -150.
            set vel_max to -120.
        }
        else if get_agl() > 5000
        {
            set vel_min to -100.
            set vel_max to -90.
        }
        else if get_agl() > 1000
        {
            set vel_min to -55.
            set vel_max to -45.
        }
        else
        {
            set vel_min to (-1) * (get_agl() / 10).
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

        if get_agl() < 10
        {
            set vel_min to -1.
            set vel_max to -0.5.
        }

        if ship:verticalspeed < vel_min
        {
            // wait until ship:angularvel:x < 0.01 and ship:angularvel:y < 0.01.
            engine_on().
        }
        if ship:verticalspeed > vel_max
        {
            engine_off().
        }
        wait 0.5.
    }

    engine_off().
    engine_on().
    wait until ship:verticalspeed > -2.

    set phase to 3.
}

function touch_down
{
    print "Phase 3: Touch down. ".
    until get_agl() < 2
    {
        set available_acceleration to (ship:availablethrust / ship:mass) - g_moon.
        set burn_time to (-ship:verticalspeed) / available_acceleration.
        set burn_distance to (-ship:verticalspeed * burn_time + 0.5 * available_acceleration * burn_time ^ 2).
        until burn_distance >= get_agl()
        {
            if ship:verticalspeed > 0
            {
                set burn_distance to 0.
            }
            else
            {
                set available_acceleration to (ship:availablethrust / ship:mass) - g_moon.
                set burn_time to (-ship:verticalspeed) / available_acceleration.
                set burn_distance to (-ship:verticalspeed * burn_time + 0.5 * available_acceleration * burn_time ^ 2).
                print "Burn dist: " + burn_distance + ", agl: " + get_agl().
            }
            wait 0.1.
        }
        engine_on().
        wait 0.1.
    }
    engine_off().
    set phase to 0.
}


function land
{
    until phase = 0
    {
        if phase = 1
        {
            kill_horizontal().
        }
        else if phase = 2
        {
            final_approach().
        }
        else if phase = 3
        {
            touch_down().
        }

        wait 0.5.
    }
    engine_off().
    unlock steering.
    unlock throttle.
}

when stage:number = 1 and (stage:udmh = 0 or get_agl() < 5000 or phase = 3 or ship:availablethrust = 0) then
{
    engine_off().
    wait 1.
    stage.
    gear on.
    set STEERINGMANAGER:MAXSTOPPINGTIME to 1.
}

when ship:groundspeed < 0.05 then
{
    print "steering up".
    lock steering to ship:up.
}

when ship:groundspeed >= 0.05 and ship:groundspeed < 1 then
{
    print "steering a bit".
    lock steering to (-1) * ship:velocity:surface - ship:up:vector * 5.
}

when ship:verticalspeed > -0.5 then
{
    print "kill engine".
    engine_off().
    return true.
}

// when ship:groundspeed >= 10 and ship:groundspeed < 50 then
// {
//     lock steering to (-1) * ship:velocity:surface - ship:up:vector * 20.
// }

// when ship:groundspeed >= 0.05 and ship:groundspeed < 10 then
// {
//     lock steering to (-1) * ship:velocity:surface - ship:up:vector * 10.
// }

land().