###############################################################################
##
## JSBSim hydrodynamics system. FlightGear side.
##
##  Copyright (C) 2015 - 2017  Anders Gidenstam  (anders(at)gidenstam.org)
##  This file is licensed under the GPL license v2 or later.
##
###############################################################################

var ground = func {
    # Send the current ground level to the JSBSim hydrodynamics model.
    setprop("/fdm/jsbsim/hydro/environment/water-level-ft",
            getprop("/position/ground-elev-ft") +
            getprop("/fdm/jsbsim/hydro/environment/wave-amplitude-ft"));

    # Connect the JSBSim hydrodynamics wave model with the custom water shader.
    setprop("environment/waves/time-sec",
            getprop("/fdm/jsbsim/simulation/sim-time-sec"));
    setprop("environment/waves/from-deg",
            getprop("/fdm/jsbsim/hydro/environment/waves-from-deg"));
    setprop("environment/waves/length-ft",
            getprop("/fdm/jsbsim/hydro/environment/wave-length-ft"));
    setprop("environment/waves/amplitude-ft",
            getprop("/fdm/jsbsim/hydro/environment/wave-amplitude-ft"));
    setprop("environment/waves/angular-frequency-rad_sec",
            getprop("/fdm/jsbsim/hydro/environment/wave/angular-frequency-rad_sec"));
    setprop("environment/waves/wave-number-rad_ft",
            getprop("/fdm/jsbsim/hydro/environment/wave/wave-number-rad_ft"));

    settimer(ground, 0.0);
}

settimer(ground, 0.0);


###############################################################################
# On-screen displays
var enableOSD = func {
    var left  = screen.display.new(20, 10);
    var right = screen.display.new(-300, 10);

    left.add("/fdm/jsbsim/sim-time-sec");
    left.add("/orientation/heading-magnetic-deg");
    left.add("/fdm/jsbsim/hydro/true-course-deg");
    left.add("/fdm/jsbsim/hydro/beta-deg");
    left.add("/fdm/jsbsim/hydro/pitch-deg");
    left.add("/fdm/jsbsim/hydro/roll-deg");
    left.add("/fdm/jsbsim/hydro/floats/pitch-deg");
    left.add("/fdm/jsbsim/hydro/floats/roll-deg");
    left.add("/fdm/jsbsim/hydro/floats/height-agl-ft[0]");
    left.add("/fdm/jsbsim/hydro/floats/height-agl-ft[1]");
    left.add("/fdm/jsbsim/position/h-sl-ft");
    left.add("/fdm/jsbsim/hydro/environment/water-level-ft");
    left.add("/fdm/jsbsim/inertia/cg-x-in");
    left.add("/fdm/jsbsim/inertia/cg-y-in");
    left.add("/fdm/jsbsim/inertia/cg-z-in");
    left.add("/fdm/jsbsim/hydro/fdrag-lbs");
    left.add("/fdm/jsbsim/hydro/displacement-drag-lbs[0]");
    left.add("/fdm/jsbsim/hydro/displacement-drag-lbs[1]");
    left.add("/fdm/jsbsim/hydro/planing-drag-lbs[0]");
    left.add("/fdm/jsbsim/hydro/planing-drag-lbs[1]");
    left.add("/fdm/jsbsim/hydro/fbz-lbs");
    left.add("/fdm/jsbsim/hydro/buoyancy-lbs[0]");
    left.add("/fdm/jsbsim/hydro/buoyancy-lbs[1]");
    left.add("/fdm/jsbsim/hydro/planing-lift-lbs[0]");
    left.add("/fdm/jsbsim/hydro/planing-lift-lbs[1]");
    #left.add("/fdm/jsbsim/hydro/X/force-lbs");
    #left.add("/fdm/jsbsim/hydro/Y/force-lbs");
    left.add("/fdm/jsbsim/hydro/yaw-moment-lbsft");
    left.add("/fdm/jsbsim/hydro/pitch-moment-lbsft");
    left.add("/fdm/jsbsim/hydro/roll-moment-lbsft");
    left.add("/fdm/jsbsim/hydro/planing-floats/forebody-wetted-keel-ft[0]");
    left.add("/fdm/jsbsim/hydro/planing-floats/forebody-wetted-keel-ft[1]");
    left.add("/fdm/jsbsim/hydro/planing-floats/afterbody-wetted-keel-ft[0]");
    left.add("/fdm/jsbsim/hydro/planing-floats/afterbody-wetted-keel-ft[1]");
    left.add("/fdm/jsbsim/hydro/planing-floats/forebody-normal-force-lbs[0]");
    left.add("/fdm/jsbsim/hydro/planing-floats/forebody-normal-force-lbs[1]");
    left.add("/fdm/jsbsim/hydro/planing-floats/afterbody-normal-force-lbs[0]");
    left.add("/fdm/jsbsim/hydro/planing-floats/afterbody-normal-force-lbs[1]");
    #left.add("/fdm/jsbsim/hydro/transverse-wave/wave-length-ft");
    #left.add("/fdm/jsbsim/hydro/transverse-wave/wave-amplitude-ft");
    #left.add("/fdm/jsbsim/hydro/transverse-wave/squat-ft");
    #left.add("/fdm/jsbsim/hydro/transverse-wave/pitch-trim-change-deg");
    #left.add("/fdm/jsbsim/hydro/environment/wave/relative-heading-rad");
    #left.add("/fdm/jsbsim/hydro/orientation/wave-pitch-trim-change-deg");
    #left.add("/fdm/jsbsim/hydro/orientation/wave-roll-trim-change-deg");
    #left.add("/fdm/jsbsim/hydro/environment/wave/angular-frequency-rad_sec");
    #left.add("/fdm/jsbsim/hydro/environment/wave/wave-number-rad_ft");
    #left.add("/fdm/jsbsim/hydro/environment/wave/level-fwd-ft");
    #left.add("/fdm/jsbsim/hydro/environment/wave/level-at-hrp-ft");
    #left.add("/fdm/jsbsim/hydro/environment/wave/level-aft-ft");

    right.add("/instrumentation/airspeed-indicator/indicated-speed-kt");
    right.add("/fdm/jsbsim/hydro/active-norm");
    right.add("/fdm/jsbsim/hydro/v-kt");
    right.add("/fdm/jsbsim/hydro/vbx-fps");
    right.add("/fdm/jsbsim/hydro/vby-fps");
    right.add("/fdm/jsbsim/hydro/qbar-u-psf");
    right.add("/fdm/jsbsim/hydro/Frode-number");
    right.add("/fdm/jsbsim/hydro/speed-length-ratio");
}

# Debug settings.
enableOSD();
###############################################################################

var log = func {
    print(getprop("/fdm/jsbsim/sim-time-sec") ~ " " ~
          getprop("/fdm/jsbsim/hydro/v-kt") ~ " " ~
          getprop("/fdm/jsbsim/hydro/fdrag-lbs") ~ " " ~
          getprop("/fdm/jsbsim/propulsion/engine/thrust-lbs"));
    settimer(log, 0.1);
}

#settimer(log, 0.0);
