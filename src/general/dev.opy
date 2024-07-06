#!mainFile "../main.opy"

rule "[dev] developer options hud":
    @Event global
    @Condition testMode

    hudSubtext(getAllPlayers(), " \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n ", HudPosition.RIGHT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getAllPlayers(), "Selection Mode" if devIsSelecting == true else "Developer Options", HudPosition.RIGHT, 4, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getAllPlayers(), "{0} {1} Disable Enemy Spawning: {2}".format(">" if devSelection == 1 else "", abilityIconString(Hero.BAPTISTE, Button.ABILITY_2), devOptions[1]), HudPosition.RIGHT, 5, Color.WHITE if devSelection == 1 else Color.GREEN if devOptions[1] == true else Color.GRAY, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR)
    hudSubtext(getAllPlayers(), "{0} {1} Singleplayer Grapple Bypass: {2}".format(">" if devSelection == 2 else "", abilityIconString(Hero.GENJI, Button.JUMP), devOptions[2]), HudPosition.RIGHT, 6, Color.WHITE if devSelection == 2 else Color.GREEN if devOptions[2] == true else Color.GRAY, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR)
    hudSubtext(getAllPlayers(), "{0} {1} Enable Dummy Bot Spawning: {2}".format(">" if devSelection == 3 else "", iconString(Icon.HAPPY), devOptions[3]), HudPosition.RIGHT, 7, Color.WHITE if devSelection == 3 else Color.GREEN if devOptions[3] == true else Color.GRAY, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR)
    #hudSubtext(getAllPlayers(), localPlayer.getSpeedInDirection(directionTowards(localPlayer.getPosition(),localPlayer.grappleTarget.getPosition())), HudPosition.TOP, 901, Color.SKY_BLUE, HudReeval.VISIBILITY_AND_STRING)
    #hudSubtext(getAllPlayers(), min(localPlayer.grappleStrength, 0.5 * (grappleDistance(localPlayer) ** 2)), HudPosition.TOP, 902, Color.BLUE, HudReeval.VISIBILITY_AND_STRING)
    #hudHeader(getAllPlayers(), "{0} | {1} | {2} | {3}".format(spawnDelay(Hero.PHARAH),spawnDelay(Hero.PHARAH),spawnDelay(Hero.PHARAH),spawnDelay(Hero.PHARAH)), HudPosition.TOP, 0, Color.RED, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR)
    #createBeam(getAllPlayers(), Beam.GOOD, localPlayer.grappleTarget.getPosition() + vect(false,-999,false), localPlayer.grappleTarget.getPosition() + vect(false,999,false), Color.WHITE, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)

rule "[dev] developer toggle selection mode":
    @Event global
    @Condition testMode
    @Condition hostPlayer.isHoldingButton(Button.SECONDARY_FIRE)

    wait(1, Wait.ABORT_WHEN_FALSE)
    if devIsSelecting == true:
        devIsSelecting = false
        devSelection = 0
    else:
        devIsSelecting = true

rule "[dev] developer switch selection":
    @Event global
    @Condition testMode
    @Condition devIsSelecting
    @Condition hostPlayer.isHoldingButton(Button.SECONDARY_FIRE)

    if devSelection == 0:
        devSelection = 1
    else:
        waitUntil(hostPlayer.isHoldingButton(Button.SECONDARY_FIRE) != true, 9999)
        if devIsSelecting == true:
            if devSelection + 1 == len(devOptions):
                devSelection = 1
            else:
                devSelection += 1

rule "[dev] developer toggle developer option":
    @Event global
    @Condition testMode
    @Condition devIsSelecting
    @Condition hostPlayer.isHoldingButton(Button.PRIMARY_FIRE)

    if devOptions[devSelection] == true:
        devOptions[devSelection] = false
    else:
        devOptions[devSelection] = true
    
rule "[dev] bot spawn ally":
    @Event eachPlayer
    @Condition testMode
    @Condition devOptions[3] == true
    @Condition eventPlayer.isHoldingButton(Button.MELEE)

    wait(1, Wait.ABORT_WHEN_FALSE)
    createDummy(Hero.GENJI, eventPlayer.getTeam(), -1, vect(0,10,0), vect(10,0,0))
    getLastCreatedEntity().startForcingPosition(updateEveryTick(movingBotPOS),true)

rule "[dev] bot remove ally":
    @Event eachPlayer
    @Condition testMode
    @Condition devOptions[3] == true
    @Condition eventPlayer.isHoldingButton(Button.MELEE)

    wait(2, Wait.ABORT_WHEN_FALSE)
    destroyAllDummies()

/*
rule "[dev] movingBotPOS":
    @Condition testMode

    movingBotPOS = vect(0,0,0)
    while testMode:
        chase(movingBotPOS, vect(15,0,0), duration=5, ChaseReeval.DESTINATION_AND_DURATION)
        wait(5)
        stopChasingVariable(movingBotPOS)
        chase(movingBotPOS, vect(-15,5,0), duration=5, ChaseReeval.DESTINATION_AND_DURATION)
        wait(5)
        stopChasingVariable(movingBotPOS)\
*/