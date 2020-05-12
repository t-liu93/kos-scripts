// Settings for PEGAS
GLOBAL kOS_IPU IS 500.                    // Required to run the script fast enough.
GLOBAL cserVersion IS "old".            // Which version of the CSER function to use: "old" for the standard one, "new" for pand5461's implementation.
                                        // "Old" CSER requires IPU of about 500, while "new" has not been extensively tested yet.
GLOBAL pitchOverTimeLimit IS 20.        // In atmospheric part of ascent, when the vehicle pitches over, the wait for velocity vector to align will be forcibly broken after that many seconds.
GLOBAL upfgConvergenceDelay IS 5.        // Transition from passive (atmospheric) to active guidance occurs that many seconds before "upfgActivation" (to give UPFG time to converge).
GLOBAL upfgFinalizationTime IS 5.        // When time-to-go gets below that, keep attitude stable and simply count down time to cutoff.
GLOBAL stagingKillRotTime IS 5.            // Updating attitude commands will be forbidden that many seconds before staging (in an attempt to keep vehicle steady for a clean separation).
GLOBAL upfgConvergenceCriterion IS 0.1.    // Maximum difference between consecutive UPFG T-go predictions that allow accepting the solution.
GLOBAL upfgGoodSolutionCriterion IS 15.    // Maximum angle between guidance vectors calculated by UPFG between stages that allow accepting the solution.
