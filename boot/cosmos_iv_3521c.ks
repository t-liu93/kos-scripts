global vehicle IS list(
                    lexicon(
                        "name", "Stage-I",
                        "massTotal", 265088,
                        "massFuel", 212200-6665,
                        "minThrottle", 1.0,
                        "engines", list(lexicon("isp", 290.0, "thrust", 831400*5)),
                        "staging", lexicon(
                                        "jettison", FALSE,
                                        "ignition", FALSE
                                        )
                    ),
                    lexicon(
                        "name", "Stage-II",
                        "massTotal", 47336,
                        "massFuel", 46000-1437,
                        "engines", list(lexicon("isp", 313, "thrust", 366100)),
                        "staging", lexicon(
                                        "jettison", true,
                                        "waitBeforeJettison", 1,
                                        "ignition", true,
                                        "waitBeforeIgnition", 1,
                                        "ullage", "srb",
                                        "ullageBurnDuration", 5
                                        )
                    )
).
global sequence IS list(
                    lexicon("time", -3.5, "type", "stage", "message", "Ignition"),
                    lexicon("time", 0, "type", "stage", "message", "LIFTOFF"),
                    lexicon("time", 115, "type", "stage", "message", "BOOSTER DECOUPLE"),
                    lexicon("time", 118, "type", "actiongroup", "groupnumber", 8, "message", "LAUNCH ESCAPE TOWER JETTISON"),
                    lexicon("time", 150, "type", "jettison", "message", "Payload Fairing jettison", "massLost", 405)
).
global controls IS lexicon(
                    "launchTimeAdvance", 150,
                    "verticalAscentSpeed", 50,
                    "pitchOverAngle", 7,
                    "upfgActivation", 120
).
set steeringmanager:rollts to 10.
switch to 0.
clearScreen.
print "Loaded boot file: COSMOS-IV-3521C!".