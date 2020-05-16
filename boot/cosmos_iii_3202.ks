GLOBAL vehicle IS LIST(
                    LEXICON(
                        "name", "Booster",
                        "massTotal", 163645,
                        "massFuel", 144300-3844,
                        "minThrottle", 1.0,
                        "engines", LIST(LEXICON("isp", 296.0, "thrust", 2194400)),
                        "staging", LEXICON(
                                        "jettison", FALSE,
                                        "ignition", FALSE
                                        )
                    ),
                    LEXICON(
                        "name", "Second Stage",
                        "massTotal", 17722,
                        "massFuel", 15890-1461,
                        "engines", LIST(LEXICON("isp", 433.0, "thrust", 2*67000)),
                        "staging", LEXICON(
                                        "jettison", TRUE,
                                        "waitBeforeJettison", 1,
                                        "ignition", TRUE,
                                        "waitBeforeIgnition", 1,
                                        "ullage", "srb",
                                        "ullageBurnDuration", 5
                                        )
                    )
).
GLOBAL sequence IS LIST(
                    LEXICON("time", -3.5, "type", "stage", "message", "LR-87 ignition"),
                    LEXICON("time", 0, "type", "stage", "message", "LIFTOFF"),
                    LEXICON("time", 200, "type", "jettison", "message", "Payload Fairing jettison", "massLost", 368)
).
GLOBAL controls IS LEXICON(
                    "launchTimeAdvance", 150,
                    "verticalAscentSpeed", 65,
                    "pitchOverAngle", 3.5,
                    "upfgActivation", 125
).
SET STEERINGMANAGER:ROLLTS TO 10.
SWITCH TO 0.
CLEARSCREEN.
PRINT "Loaded boot file: COSMOS-III-3202!".