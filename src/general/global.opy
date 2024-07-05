#!mainFile "../main.opy"

rule "[Global] Global 1":
    pauseMatchTime()
    #Initialize Variables
    ability1Enabled = createWorkshopSetting(bool, "Abilities", "Movement", true, 3)
    ability2Enabled = createWorkshopSetting(bool, "Abilities", "Counter", true, 4)
    ultimateEnabled = createWorkshopSetting(bool, "Abilities", "Ultimate", true, 5)
    difficulty = createWorkshopSetting(int[1:10], "Customization", "Difficulty", 5, 1)
    roundLength = createWorkshopSetting(int[60:180], "Customization", "Round Length (in seconds)", 120, 2)
    chaosMode = createWorkshopSetting(bool, "Extra Modes", "Chaos Mode (overrides all customizable settings)", false, 6)
    testMode = createWorkshopSetting(bool, "Extra Modes", "Test Mode (developer testing)", true, 7)
    colordisabled = rgba(127, 127, 127, 127)
    point[0] = vect(-20, false, false)
    point[1] = vect(20, false, false)
    camDirection = Vector.UP
    wait(false)
    x[0] = point[0].x
    x[1] = point[1].x
    z[0] = point[0].z
    z[1] = point[1].z
    point2D[0] = vect(x[0], false, z[0])
    point2D[1] = vect(x[1], false, z[1])
    direction2D = directionTowards(point2D[0], point2D[1])
    newBackward = crossProduct(camDirection, direction2D)
    abilityNames = [null,"Dash","Deflect","Eradication","Blink","Crystallize","Slo-Mo","Grapple Hook","Flash Step","1-UP"]
    #abilityDescriptions = [null, "Dash in the direction you are facing. Gain damage immunity and ultimate charge for each projectile hit", "Deflect any incoming projectiles that are in front of you.", "Immediately destroy all enemies and projectiles.","Blink","Harden","Slo-Mo","Grapple Hook","Flash Step","1-UP"]
    abilityIcons = [null, abilityIconString(Hero.GENJI, Button.ABILITY_1), abilityIconString(Hero.GENJI, Button.ABILITY_2), abilityIconString(Hero.ILLARI, Button.ABILITY_1), abilityIconString(Hero.TRACER, Button.ABILITY_1), abilityIconString(Hero.ILLARI, Button.ULTIMATE), abilityIconString(Hero.LUCIO, Button.ABILITY_2), abilityIconString(Hero.WIDOWMAKER,Button.ABILITY_1), abilityIconString(Hero.KIRIKO, Button.ABILITY_1), abilityIconString(Hero.MERCY, Button.ABILITY_2)]
    ultRate = [2.222,3.333,2.222]
    #Hud
    progressBarHud(getAllPlayers() if roundUnderway else null, getMatchTime() / roundLength * 100, roundStatus, HudPosition.TOP, 5, Color.BLACK if chaosMode else Color.AQUA if getMatchTime() >= roundLength - 15 else Color.WHITE if getMatchTime() >= roundLength * 0.5 else Color.RED, Color.BLACK if chaosMode else Color.AQUA if getMatchTime() >= roundLength - 15 else Color.WHITE if getMatchTime() >= roundLength * 0.5 else Color.RED, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), "J.G.A.B. Just Genji and Beats | v1.0.3", HudPosition.RIGHT, 1, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), "Created by u/Ender | Code: 9WATM \n", HudPosition.RIGHT, 2, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    createInWorldText(null if roundUnderway else getAllPlayers(), "Just Genjis and Beats", vect(0, 12, 19.5), 4, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_POSITION, Color.GREEN, SpecVisibility.ALWAYS)
    createInWorldText(null if roundUnderway else getAllPlayers(), "Created by u/Ender | Code: 9WATM", vect(0, 10, 19.5), 1.8, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_POSITION, Color.WHITE, SpecVisibility.ALWAYS)
    createInWorldText(null if roundUnderway else getAllPlayers(), "The Game", vect(10, 7, 19.5), 2.5, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_POSITION, Color.GREEN, SpecVisibility.ALWAYS)
    createInWorldText(null if roundUnderway else getAllPlayers(), "Avoid enemy projectiles & crowd control.", vect(10, 5, 19.5), 1.25, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_POSITION, Color.WHITE, SpecVisibility.ALWAYS)
    createInWorldText(null if roundUnderway else getAllPlayers(), "Enemies", vect(-10, 7, 19.5), 2.5, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_POSITION, Color.GREEN, SpecVisibility.ALWAYS)
    createInWorldText(null if roundUnderway else getAllPlayers(), "Pharah", vect(-6, 5, 19.5), 1, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_POSITION, Color.BLUE, SpecVisibility.ALWAYS)
    createEffect(null if roundUnderway else getAllPlayers(), Effect.SPHERE, Color.BLUE, vect(-6, 5.5, 20), 1, EffectReeval.VISIBILITY_AND_COLOR)
    createInWorldText(null if roundUnderway else getAllPlayers(), "Orisa", vect(-8.667, 5, 19.5), 1, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_POSITION, Color.LIME_GREEN, SpecVisibility.ALWAYS)
    createEffect(null if roundUnderway else getAllPlayers(), Effect.SPHERE, Color.GREEN, vect(-8.667, 5.5, 20), 1, EffectReeval.VISIBILITY_AND_COLOR)
    createInWorldText(null if roundUnderway else getAllPlayers(), "Mei", vect(-11.333, 5, 19.5), 1, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_POSITION, Color.AQUA, SpecVisibility.ALWAYS)
    createEffect(null if roundUnderway else getAllPlayers(), Effect.SPHERE, Color.AQUA, vect(-11.333, 5.5, 20), 1, EffectReeval.VISIBILITY_AND_COLOR)
    createEffect(null if roundUnderway else getAllPlayers(), Effect.SPHERE, Color.WHITE, vect(-11.333, 5.5, 20), 0.8, EffectReeval.VISIBILITY_AND_COLOR)
    createInWorldText(null if roundUnderway else getAllPlayers(), "Reinhardt", vect(-14, 5, 19.5), 1, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_POSITION, Color.YELLOW, SpecVisibility.ALWAYS)
    createEffect(null if roundUnderway else getAllPlayers(), Effect.SPHERE, Color.ORANGE, vect(-14, 5.5, 20), 1, EffectReeval.VISIBILITY_AND_COLOR)
    createEffect(null if roundUnderway else getAllPlayers(), Effect.SPHERE, Color.YELLOW, vect(-14, 5.5, 20), 0.8, EffectReeval.VISIBILITY_AND_COLOR)
    hudText(getAllPlayers(), "{0}".format(iconString(Icon.FLAG)), "Difficulty", "CHAOS MODE" if chaosMode else "Level {0}".format(difficulty), HudPosition.LEFT, 5, Color.BLACK if chaosMode else Color.WHITE, Color.BLACK if chaosMode else Color.WHITE, Color.BLACK if chaosMode else Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudSubtext(getAllPlayers(), " \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", HudPosition.LEFT, 6, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    
    hudText(getAllPlayers(), "{0}".format(abilityIcons[(localPlayer.a1Choice)]), abilityNames[(localPlayer.a1Choice)], "--Disabled--" if ability1Enabled != true else "Ready" if /*localPlayer.getAbilityCooldown(Button.ABILITY_1) == 0*/localPlayer.a1cooldownPATCH == 0 else /*localPlayer.getAbilityCooldown(Button.ABILITY_1)*/localPlayer.a1cooldownPATCH, HudPosition.LEFT, 8, colordisabled if ability1Enabled != true else Color.YELLOW if localPlayer.usingAbility1REAL else Color.RED if /*localPlayer.getAbilityCooldown(Button.ABILITY_1) > 0*/localPlayer.a1cooldownPATCH > 0 else Color.WHITE, colordisabled if ability1Enabled != true else Color.YELLOW if localPlayer.usingAbility1REAL else Color.RED if /*localPlayer.getAbilityCooldown(Button.ABILITY_1) > 0*/localPlayer.a1cooldownPATCH else Color.WHITE, colordisabled if ability1Enabled != true else Color.YELLOW if localPlayer.usingAbility1REAL else Color.RED if /*localPlayer.getAbilityCooldown(Button.ABILITY_1) > 0*/localPlayer.a1cooldownPATCH else Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), "{0}".format(abilityIcons[(localPlayer.a2Choice)+1]), abilityNames[(localPlayer.a2Choice)+1], "--Disabled--" if ability2Enabled != true else "Ready" if localPlayer.getAbilityCooldown(Button.ABILITY_2) == 0 else localPlayer.getAbilityCooldown(Button.ABILITY_2), HudPosition.LEFT, 9, colordisabled if ability2Enabled != true else Color.YELLOW if localPlayer.usingAbility2REAL else Color.RED if localPlayer.getAbilityCooldown(Button.ABILITY_2) > 0 else Color.WHITE, colordisabled if ability2Enabled != true else Color.YELLOW if localPlayer.usingAbility2REAL else Color.RED if localPlayer.getAbilityCooldown(Button.ABILITY_2) > 0 else Color.WHITE, colordisabled if ability2Enabled != true else Color.YELLOW if localPlayer.usingAbility2REAL else Color.RED if localPlayer.getAbilityCooldown(Button.ABILITY_2) > 0 else Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), "{0}".format(abilityIcons[(localPlayer.ultChoice)+2]), abilityNames[(localPlayer.ultChoice)+2], "--Disabled--" if ultimateEnabled != true else "Ready" if localPlayer.ultCharge == 100 else "{0}%".format(round(localPlayer.ultCharge)), HudPosition.LEFT, 10, colordisabled if ultimateEnabled != true else Color.YELLOW if localPlayer.usingUltimateREAL == true else Color.BLACK if roundUnderway and localPlayer.ultCharge == 0 else rgb(200 + 55 * (localPlayer.ultCharge / 100), 255 * (localPlayer.ultCharge / 100), 19 - 19 * (localPlayer.ultCharge / 100)) if localPlayer.ultCharge != 100 else Color.WHITE, colordisabled if ultimateEnabled != true else Color.YELLOW if localPlayer.usingUltimateREAL == true else Color.BLACK if roundUnderway and localPlayer.ultCharge == 0 else rgb(200 + 55 * (localPlayer.ultCharge / 100), 255 * (localPlayer.ultCharge / 100), 19 - 19 * (localPlayer.ultCharge / 100)) if localPlayer.ultCharge != 100 else Color.WHITE, colordisabled if ultimateEnabled != true else Color.YELLOW if localPlayer.usingUltimateREAL == true else Color.BLACK if roundUnderway and localPlayer.ultCharge == 0 else rgb(200 + 55 * (localPlayer.ultCharge / 100), 255 * (localPlayer.ultCharge / 100), 19 - 19 * (localPlayer.ultCharge / 100)) if localPlayer.ultCharge != 100 else Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    /*
    hudSubheader(getAllPlayers(), "Press ({0}) to see ability details.".format(buttonString(Button.SECONDARY_FIRE)), HudPosition.LEFT, 7, Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers() if localPlayer.isHoldingButton(Button.SECONDARY_FIRE) else null, "Dash in the direction you are facing. Gain ultimate charge for each projectile hit.", HudPosition.LEFT, 8.5 if localPlayer.isHoldingButton(Button.SECONDARY_FIRE) else 9999, Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers() if localPlayer.isHoldingButton(Button.SECONDARY_FIRE) else null, "Deflect any incoming projectiles that are in front of you.", HudPosition.LEFT, 9.5 if localPlayer.isHoldingButton(Button.SECONDARY_FIRE) else 9999, Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers() if localPlayer.isHoldingButton(Button.SECONDARY_FIRE) else null, "Immediately destroy all enemies and projectiles.", HudPosition.LEFT, 10.5 if localPlayer.isHoldingButton(Button.SECONDARY_FIRE) else 9999, Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    */
    #Create Group UP FX
    createEffect(getAllPlayers(), Effect.RING, Color.GREEN if allPlayersReady else Color.WHITE, vect(-12, 0, 0), 3, EffectReeval.VISIBILITY_AND_COLOR)
    readyFX[0] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.GREEN if allPlayersReady else Color.WHITE, vect(-12, -20, 0), 3, EffectReeval.VISIBILITY_AND_COLOR)
    readyFX[1] = getLastCreatedEntity()
    createInWorldText(getAllPlayers(), "Group Up To Begin! {0}/{1}".format(len([player for player in getAllPlayers() if distance(player.getPosition() * vect(1, 0, 1), vect(-12, 0, 0)) <= 3 and not player.isDummy() and player.hasSpawned()]), len([player for player in getAllPlayers() if not player.isDummy()])), vect(-12, 2, 0), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.GREEN if allPlayersReady else Color.WHITE, SpecVisibility.DEFAULT)
    readyFX[2] = getLastCreatedText()
    createIcon(getAllPlayers(), vect(-12, 0, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY_AND_COLOR, Color.GREEN if all([distance(i_.getPosition() * vect(1, 0, 1), vect(-12, 0, 0)) <= 3 and distance(vect(-12, 0, 0), i_) > 0 for i_ in [player for player in getPlayers(Team.1) if not player.isDummy()]]) else Color.WHITE, true)
    readyFX[3] = getLastCreatedEntity()
    createEffect(getAllPlayers() if selectionPercent_READY > 0 else null, Effect.RING, Color.GREEN, vect(-12, 0, 0), 3 * selectionPercent_READY if allPlayersReady else 0, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    readyFX[4] = getLastCreatedEntity()
    #Create Ability Changes
    #---ABILITY 1---
    createEffect(getAllPlayers(), Effect.RING, Color.RED if len(getAllPlayers()) == 1 and localPlayer.a1Choice == 7 else Color.WHITE, vect(12, 0, 0), 2.5, EffectReeval.VISIBILITY_AND_COLOR)
    readyFX[5] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.RED if len(getAllPlayers()) == 1 and localPlayer.a1Choice == 7 else Color.WHITE, vect(12, -24, 0), 2.5, EffectReeval.VISIBILITY_AND_COLOR)
    readyFX[6] = getLastCreatedEntity()
    createInWorldText(getAllPlayers(), abilityIcons[(localPlayer.a1Choice)], vect(12, 3.5, 0), 2.5, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    readyFX[7] = getLastCreatedText()
    createInWorldText(getAllPlayers(), abilityNames[(localPlayer.a1Choice)], vect(12, 2.5, 0), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.RED if len(getAllPlayers()) == 1 and localPlayer.a1Choice == 7 else Color.WHITE, SpecVisibility.DEFAULT)
    readyFX[8] = getLastCreatedText()
    createInWorldText(getAllPlayers(), "[{0}]".format(Button.INTERACT), vect(12, 2, 0), 0.75, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.RED if len(getAllPlayers()) == 1 and localPlayer.a1Choice == 7 else Color.WHITE, SpecVisibility.DEFAULT)
    readyFX[9] = getLastCreatedText()
    #---ABILITY 2---
    createEffect(getAllPlayers(), Effect.RING, Color.WHITE, vect(4, 0, 0), 2.5, EffectReeval.VISIBILITY_AND_COLOR)
    readyFX[10] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.WHITE, vect(4, -24, 0), 2.5, EffectReeval.VISIBILITY_AND_COLOR)
    readyFX[11] = getLastCreatedEntity()
    createInWorldText(getAllPlayers(), abilityIcons[(localPlayer.a2Choice)+1], vect(4, 3.5, 0), 2.5, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    readyFX[12] = getLastCreatedText()
    createInWorldText(getAllPlayers(), abilityNames[(localPlayer.a2Choice)+1], vect(4, 2.5, 0), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    readyFX[13] = getLastCreatedText()
    createInWorldText(getAllPlayers(), "[{0}]".format(Button.INTERACT), vect(4, 2, 0), 0.75, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    readyFX[14] = getLastCreatedText()
    #---ULTIMATE---
    createEffect(getAllPlayers(), Effect.RING, Color.WHITE, vect(-4, 0, 0), 2.5, EffectReeval.VISIBILITY_AND_COLOR)
    readyFX[15] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.WHITE, vect(-4, -24, 0), 2.5, EffectReeval.VISIBILITY_AND_COLOR)
    readyFX[16] = getLastCreatedEntity()
    createInWorldText(getAllPlayers(), abilityIcons[(localPlayer.ultChoice)+2], vect(-4, 3.5, 0), 2.5, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    readyFX[17] = getLastCreatedText()
    createInWorldText(getAllPlayers(), abilityNames[(localPlayer.ultChoice)+2], vect(-4, 2.5, 0), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    readyFX[18] = getLastCreatedText()
    createInWorldText(getAllPlayers(), "[{0}]".format(Button.INTERACT), vect(-4, 2, 0), 0.75, Clip.NONE, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    readyFX[19] = getLastCreatedText()
    #Player Health Bar
    wait(1)
    #Wait Until Grouped Up
    while not (allPlayersReady):
        selectionPercent_READY = 0
        waitUntil(all([player.hasSpawned() for player in getPlayers(Team.1)]), 9999)
        waitUntil(allPlayersReady, 9999)
        waitUntil(selectionPercent_READY == 1, 9999)
        if all([distance(vect(12, 0, 0), i_) <= 3 and distance(vect(12, 0, 0), i_) > 0 for i_ in [player for player in getPlayers(Team.1) if not player.isDummy()]]) and all([player.hasSpawned() for player in getPlayers(Team.1)]):
            break
    #Initialize Start Game
    bigMessage(getAllPlayers(), "Begin!")
    destroyEffect(readyFX[0])
    destroyEffect(readyFX[1])
    destroyInWorldText(readyFX[2])
    destroyIcon(readyFX[3])
    destroyEffect(readyFX[4])
    destroyEffect(readyFX[5])
    destroyEffect(readyFX[6])
    destroyInWorldText(readyFX[7])
    destroyInWorldText(readyFX[8])
    destroyInWorldText(readyFX[9])
    destroyEffect(readyFX[10])
    destroyEffect(readyFX[11])
    destroyInWorldText(readyFX[12])
    destroyInWorldText(readyFX[13])
    destroyInWorldText(readyFX[14])
    destroyEffect(readyFX[15])
    destroyEffect(readyFX[16])
    destroyInWorldText(readyFX[17])
    destroyInWorldText(readyFX[18])
    destroyInWorldText(readyFX[19])
    destroyAllDummies()
    wait(1)
    #Actual Start Game
    GamePhase_SpawnBots()

rule "[Global] Ready Selection Percent":
    @Event global
    @Condition roundUnderway != true
    @Condition allPlayersReady

    chase(selectionPercent_READY, 1, duration=1, ChaseReeval.NONE)
    waitUntil(not allPlayersReady or roundUnderway, 9999)
    stopChasingVariable(selectionPercent_READY)
    selectionPercent_READY = 0

rule "[Global] End Game":
    @Condition (getNumberOfPlayers(Team.1) == 0 or getMatchTime() <= 0.1) == true
    @Condition roundUnderway != false
    
    pauseMatchTime()
    if getMatchTime() <= 0.1:
        declareTeamVictory(Team.1)
    else:
        declareTeamVictory(Team.2)