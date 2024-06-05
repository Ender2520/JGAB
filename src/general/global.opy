#!mainFile "../main.opy"

rule "[Global] Global 1":

    pauseMatchTime()
    # Initialize Variables
    ability1Enabled = createWorkshopSetting(bool, "Abilities", "Dash", true, 3)
    ability2Enabled = createWorkshopSetting(bool, "Abilities", "Deflect", true, 4)
    ultimateEnabled = createWorkshopSetting(bool, "Abilities", "Ultimate", true, 5)
    difficulty = createWorkshopSetting(int[1:10], "Customization", "Difficulty", 5, 1)
    roundLength = createWorkshopSetting(int[60:180], "Customization", "Round Length (in seconds)", 120, 2)
    chaosMode = createWorkshopSetting(bool, "Extra Modes", "Chaos Mode (overrides all customizable settings)", false, 6) == true:
    point[0] = vect(-20, false, false)
    point[1] = vect(20, false, false)
    camDirection = Vector.DOWN
    wait(false)
    x[0] = point[0].x
    x[1] = point[1].x
    z[0] = point[0].z
    z[1] = point[1].z
    point2D[0] = vect(x[0], false, z[0])
    point2D[1] = vect(x[1], false, z[1])
    direction2D = directionTowards(point2D[0], point2D[1])
    newBackward = crossProduct(camDirection, direction2D)
    # Hud
    progressBarHud(getAllPlayers() if roundUnderway else null, (getMatchTime() / roundLength) * 100, roundStatus, HudPosition.TOP, 5, Color.BLACK if chaosMode else Color.AQUA if wuPhase else Color.WHITE if nPhase else Color.RED, Color.BLACK if chaosMode else Color.AQUA if wuPhase else Color.WHITE if nPhase else Color.RED, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
    /*
    hudSubheader(getAllPlayers(), "Load [{0}] | Peak [{1}] | Avg [{2}]".format(getServerLoad(), getPeakServerLoad(), getAverageServerLoad()), HudPosition.RIGHT, -2, rgba(255, 255, 255, 125), HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), "Pha [{0}] | Ori [{1}] | Mei [{2}] | Rei [{3}]".format(len(getPlayersOnHero(Hero.PHARAH, Team.2)), len(getPlayersOnHero(Hero.ORISA, Team.2)), len(getPlayersOnHero(Hero.MEI, Team.2)), len(getPlayersOnHero(Hero.REINHARDT, Team.2))), HudPosition.RIGHT, -1, rgba(255, 255, 255, 125), HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    */
    hudSubheader(getAllPlayers(), "J.G.A.B. Just Genji and Beats | v1.0.3", HudPosition.RIGHT, 1, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), "Created by u/Ender | Code: 9WATM \n", HudPosition.RIGHT, 2, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), "Discord", "Join for Updates and to Give Feedback", "bit.ly/ENDERSWORKSHOP (all caps)", HudPosition.RIGHT, 4, rgb(188,103,245), rgb(243,224,255), rgb(243,224,255), HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    #
    createInWorldText(getAllPlayers() if not roundUnderway else null, "Just Genjis and Beats", vect(0,12,19.5), 4, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_POSITION, Color.GREEN, SpecVisibility.ALWAYS)
    createInWorldText(getAllPlayers() if not roundUnderway else null, "Created by u/Ender | Code: 9WATM", vect(0,10,19.5), 1.8, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_POSITION, Color.WHITE, SpecVisibility.ALWAYS)
    #
    createInWorldText(getAllPlayers() if not roundUnderway else null, "The Game", vect(10,7,19.5), 2.5, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_POSITION, Color.GREEN, SpecVisibility.ALWAYS)
    createInWorldText(getAllPlayers() if not roundUnderway else null, "Avoid enemy projectiles & crowd control.", vect(10,5,19.5), 1.25, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_POSITION, Color.WHITE, SpecVisibility.ALWAYS)
    #
    createInWorldText(getAllPlayers() if not roundUnderway else null, "Enemies", vect(-10,7,19.5), 2.5, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_POSITION, Color.GREEN, SpecVisibility.ALWAYS)
    createInWorldText(getAllPlayers() if not roundUnderway else null, "Pharah", vect(-6,5,19.5), 1, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_POSITION, Color.BLUE, SpecVisibility.ALWAYS)
    createEffect(getAllPlayers() if not roundUnderway else null, Effect.SPHERE, Color.BLUE, vect(-6,5.5,20), 1, EffectReeval.VISIBILITY_AND_COLOR)
    createInWorldText(getAllPlayers() if not roundUnderway else null, "Orisa", vect(-8.667,5,19.5), 1, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_POSITION, Color.LIME_GREEN, SpecVisibility.ALWAYS)
    createEffect(getAllPlayers() if not roundUnderway else null, Effect.SPHERE, Color.GREEN, vect(-8.667,5.5,20), 1, EffectReeval.VISIBILITY_AND_COLOR)
    createInWorldText(getAllPlayers() if not roundUnderway else null, "Mei", vect(-11.333,5,19.5), 1, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_POSITION, Color.AQUA, SpecVisibility.ALWAYS)
    createEffect(getAllPlayers() if not roundUnderway else null, Effect.SPHERE, Color.AQUA, vect(-11.333,5.5,20), 1, EffectReeval.VISIBILITY_AND_COLOR)
    createEffect(getAllPlayers() if not roundUnderway else null, Effect.SPHERE, Color.WHITE, vect(-11.333,5.5,20), 0.8, EffectReeval.VISIBILITY_AND_COLOR)
    createInWorldText(getAllPlayers() if not roundUnderway else null, "Reinhardt", vect(-14,5,19.5), 1, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_POSITION, Color.YELLOW, SpecVisibility.ALWAYS)
    createEffect(getAllPlayers() if not roundUnderway else null, Effect.SPHERE, Color.ORANGE, vect(-14,5.5,20), 1, EffectReeval.VISIBILITY_AND_COLOR)
    createEffect(getAllPlayers() if not roundUnderway else null, Effect.SPHERE, Color.YELLOW, vect(-14,5.5,20), 0.8, EffectReeval.VISIBILITY_AND_COLOR)
    #
    hudText(getAllPlayers(), "{0}".format(iconString(Icon.FLAG)), "Difficulty", "CHAOS MODE" if chaosMode else "Level {0}".format(difficulty), HudPosition.LEFT, 5, Color.BLACK if chaosMode else Color.WHITE, Color.BLACK if chaosMode else Color.WHITE, Color.BLACK if chaosMode else Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    #
    hudSubtext(getAllPlayers(), " \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", HudPosition.LEFT, 6, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), "Press ({0}) to see ability details.".format(buttonString(Button.SECONDARY_FIRE)), HudPosition.LEFT, 7, Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    ###
    hudText(getAllPlayers(), "{0}".format(abilityIconString(Hero.GENJI, Button.ABILITY_1)), "Dash", abilityHUDName(ability1Enabled, Button.ABILITY_1), HudPosition.LEFT, 8, abilityUltColor(ability1Enabled, localPlayer.isUsingAbility1(), Button.ABILITY_1), abilityUltColor(ability1Enabled, localPlayer.isUsingAbility1(), Button.ABILITY_1), abilityUltColor(ability1Enabled, localPlayer.isUsingAbility1(), Button.ABILITY_1), HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), "{0}".format(abilityIconString(Hero.GENJI, Button.ABILITY_2)), "Deflect", abilityHUDName(ability2Enabled, Button.ABILITY_2), HudPosition.LEFT, 9, abilityUltColor(ability2Enabled, localPlayer.isUsingAbility2(), Button.ABILITY_2), abilityUltColor(ability2Enabled, localPlayer.isUsingAbility2(), Button.ABILITY_2), abilityUltColor(ability2Enabled, localPlayer.isUsingAbility2(), Button.ABILITY_2), HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), "{0}".format(iconString(Icon.POISON_2)), "Eradication", ultHUDName(ultimateEnabled), HudPosition.LEFT, 10, ultHUDColor(ultimateEnabled), ultHUDColor(ultimateEnabled), ultHUDColor(ultimateEnabled), HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    ###
    hudSubheader(getAllPlayers() if localPlayer.isHoldingButton(Button.SECONDARY_FIRE) else null, "          Dashing allows you to quickly move in the direction you are\n          facing. While dashing, you are immune to all damage and gain\n          ultimate charge for every projectile you dash through.", HudPosition.LEFT, 8.5 if localPlayer.isHoldingButton(Button.SECONDARY_FIRE) else 9999, Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers() if localPlayer.isHoldingButton(Button.SECONDARY_FIRE) else null, "          Deflecting allows you to *deflect* any incoming projectiles\n          that are in front of you.", HudPosition.LEFT, 9.5 if localPlayer.isHoldingButton(Button.SECONDARY_FIRE) else 9999, Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers() if localPlayer.isHoldingButton(Button.SECONDARY_FIRE) else null, "          Eradication allows you to immediately destroy all enemies\n          and projectiles they shot. Ultimate charge resets upon taking\n          damage.", HudPosition.LEFT, 10.5 if localPlayer.isHoldingButton(Button.SECONDARY_FIRE) else 9999, Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    # Create Group UP FX
    createEffect(getAllPlayers(), Effect.RING, Color.GREEN if all([distance(p.getPosition() * vect(1,0,1), vect(0,0,0)) <= 3 and distance(vect(0, 0, 0), p) > 0 and not p.isDummy() for p in getPlayers(Team.1)]) else Color.WHITE, vect(0,0,0), 3, EffectReeval.VISIBILITY_AND_COLOR)
    readyFX[0] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.GREEN if all([distance(p.getPosition() * vect(1,0,1), vect(0,0,0)) <= 3 and distance(vect(0, 0, 0), p) > 0 and not p.isDummy() for p in getPlayers(Team.1)]) else Color.WHITE, vect(0,-20,0), 3, EffectReeval.VISIBILITY_AND_COLOR)
    readyFX[1] = getLastCreatedEntity()
    createInWorldText(getAllPlayers(), "Group Up To Begin! {0}/{1}".format(len([p for p in getAllPlayers() if distance(p.getPosition() * vect(1,0,1), vect(0,0,0)) <= 3 and p.isDummy() != true and p.hasSpawned()]), len([p for p in getAllPlayers() if p.isDummy() != true])), vect(0, 1.5, 0), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.GREEN if all([distance(p.getPosition() * vect(1,0,1), vect(0,0,0)) <= 3 and distance(vect(0, 0, 0), p) > 0 and not p.isDummy() for p in getPlayers(Team.1)]) else Color.WHITE, SpecVisibility.DEFAULT)
    readyFX[2] = getLastCreatedText()
    createIcon(getAllPlayers(), vect(0,0,0), Icon.ARROW_DOWN, IconReeval.VISIBILITY_AND_COLOR, Color.GREEN if all([distance(i.getPosition() * vect(1,0,1), vect(0,0,0)) <= 3 and distance(vect(0, 0, 0), i) > 0 for i in [p for p in getPlayers(Team.1) if not p.isDummy()]]) else Color.WHITE, true)
    readyFX[3] = getLastCreatedEntity()
    # Player Health Bar
    wait(1)
    # Wait Until Grouped Up
    while not (all([player.hasSpawned() for player in getPlayers(Team.1)]) and all([distance(vect(0, 0, 0), i) <= 3 and distance(vect(0, 0, 0), i) > 0 for i in [player for player in getPlayers(Team.1) if not player.isDummy()]])):
        waitUntil(all([player.hasSpawned() for player in getPlayers(Team.1)]), 9999)
        waitUntil(all([distance(vect(0, 0, 0), i) <= 3 and distance(vect(0, 0, 0), i) > 0 for i in [player for player in getPlayers(Team.1) if not player.isDummy()]]), 9999)
        wait(1)
        if all([distance(vect(0, 0, 0), i) <= 3 and distance(vect(0, 0, 0), i) > 0 for i in [player for player in getPlayers(Team.1) if not player.isDummy()]]) and all([player.hasSpawned() for player in getPlayers(Team.1)]):
            break
    # Initialize Start Game
    bigMessage(getAllPlayers(), "Begin!")
    destroyEffect(readyFX[0])
    destroyEffect(readyFX[1])
    destroyInWorldText(readyFX[2])
    destroyIcon(readyFX[3])
    destroyAllDummies()
    wait(1)
    # Actual Start Game
    GamePhase_SpawnBots()

rule "[Global] End Game":
    @Event global
    @Condition len(getPlayers(Team.1)) == 0 or getMatchTime() <= 0.1
    @Condition roundUnderway
    
    pauseMatchTime()
    if getMatchTime() <= 0.1:
        declareTeamVictory(Team.1)
    else:
        declareTeamVictory(Team.2)