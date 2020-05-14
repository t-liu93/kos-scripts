global vehicle IS list(
                    lexicon(
                        "name", "Stage-I",
                        "massTotal", 356681,
                        "massFuel", 214200-6692,
                        "minThrottle", 1.0,
                        "engines", list(lexicon("isp", 290.0, "thrust", 846600*4)),
                        "staging", lexicon(
                                        "jettison", FALSE,
                                        "ignition", FALSE
                                        )
                    ),
                    lexicon(
                        "name", "Stage-II",
                        "massTotal", 136733,
                        "massFuel", 112700-9827,
                        "engines", list(lexicon("isp", 403.0, "thrust", 2*667000)),
                        "staging", lexicon(
                                        "jettison", true,
                                        "waitBeforeJettison", 1,
                                        "ignition", true,
                                        "waitBeforeIgnition", 1,
                                        "ullage", "srb",
                                        "ullageBurnDuration", 5
                                        )
                    ),
                    lexicon(
                        "name", "Stage-III",
                        "massTotal", 20647,
                        "massFuel", 15270-1404,
                        "engines", list(lexicon("isp", 433.0, "thrust", 2*67000)),
                        "staging", lexicon(
                                        "jettison", true,
                                        "waitBeforeJettison", 1,
                                        "ignition", true,
                                        "waitBeforeIgnition", 1,
                                        "ullage", "rcs",
                                        "ullageBurnDuration", 10,
                                        "postUllageBurn", 10
                                        )
                    )
).
global sequence IS list(
                    lexicon("time", -3.5, "type", "stage", "message", "LR-87 ignition"),
                    lexicon("time", 0, "type", "stage", "message", "LIFTOFF"),
                    lexicon("time", 100, "type", "stage", "message", "BOOSTER DECOUPLE"),
                    lexicon("time", 200, "type", "jettison", "message", "Payload Fairing jettison", "massLost", 2268)
).
global controls IS lexicon(
                    "launchTimeAdvance", 150,
                    "verticalAscentSpeed", 50,
                    "pitchOverAngle", 7.2,
                    "upfgActivation", 110
).
set steeringmanager:rollts to 10.
switch to 0.
clearScreen.
print "Loaded boot file: COSMOS-V!". // 6007kg