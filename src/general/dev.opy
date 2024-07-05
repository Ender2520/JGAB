#!mainFile "../main.opy"

rule "[dev] bot spawn ally":
    @Event eachPlayer
    @Condition testMode
    @Condition eventPlayer.isHoldingButton(Button.MELEE)

    wait(1, Wait.ABORT_WHEN_FALSE)
    createDummy(Hero.GENJI, eventPlayer.getTeam(), -1, vect(0,10,0), vect(10,0,0))
    getLastCreatedEntity().startForcingPosition(updateEveryTick(movingBotPOS),true)

rule "[dev] movingBotPOS":
    @Condition testMode

    movingBotPOS = vect(0,0,0)
    while testMode:
        chase(movingBotPOS, vect(15,0,0), duration=5, ChaseReeval.DESTINATION_AND_DURATION)
        wait(5)
        stopChasingVariable(movingBotPOS)
        chase(movingBotPOS, vect(-15,5,0), duration=5, ChaseReeval.DESTINATION_AND_DURATION)
        wait(5)
        stopChasingVariable(movingBotPOS)

rule "[dev] bot remove ally":
    @Event eachPlayer
    @Condition testMode
    @Condition eventPlayer.isHoldingButton(Button.RELOAD)

    wait(1, Wait.ABORT_WHEN_FALSE)
    destroyAllDummies()

rule "[dev] testing effects/texts":
    #hudSubtext(getAllPlayers(), localPlayer.getSpeedInDirection(directionTowards(localPlayer.getPosition(),localPlayer.grappleTarget.getPosition())), HudPosition.TOP, 901, Color.SKY_BLUE, HudReeval.VISIBILITY_AND_STRING)
    #hudSubtext(getAllPlayers(), min(localPlayer.grappleStrength, 0.5 * (grappleDistance(localPlayer) ** 2)), HudPosition.TOP, 902, Color.BLUE, HudReeval.VISIBILITY_AND_STRING)
    #hudHeader(getAllPlayers(), "{0} | {1} | {2} | {3}".format(spawnDelay(Hero.PHARAH),spawnDelay(Hero.PHARAH),spawnDelay(Hero.PHARAH),spawnDelay(Hero.PHARAH)), HudPosition.TOP, 0, Color.RED, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR)
    #createBeam(getAllPlayers(), Beam.GOOD, localPlayer.grappleTarget.getPosition() + vect(false,-999,false), localPlayer.grappleTarget.getPosition() + vect(false,999,false), Color.WHITE, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)