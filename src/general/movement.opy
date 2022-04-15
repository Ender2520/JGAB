#!mainFile "../main.opy"

#Activated extensions

#!extension buffStatusEffects
#!extension debuffStatusEffects
#!extension buffAndDebuffSounds
#!extension beamEffects

rule "[Movement] Initialize":
    @Event eachPlayer
    
    if not eventPlayer.isDummy():
        eventPlayer.disallowButton(Button.ABILITY_1)
        eventPlayer.disallowButton(Button.ABILITY_2)
        eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.disableHeroHUD()
    eventPlayer.disablePlayerCollision()
    eventPlayer.disableDeathSpectateAllPlayers()
    eventPlayer.startTransformingThrottle(1, 0.001, newBackward * -1)
    eventPlayer.startFacing(eventPlayer.faceDirection, 9999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.faceDirection = Vector.RIGHT
    
rule "[Movement] On Spawn":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned() == true
    @Condition eventPlayer.isDummy() == false

    eventPlayer.setMaxHealth(9999)
    eventPlayer.setHealth(99999)
    if not chaosMode:
        eventPlayer.lives[0] = createWorkshopSetting(int[1:5], "Customization", "Player Health", 3, 2)
    else:
        eventPlayer.lives[0] = 1
    eventPlayer.lives[1] = eventPlayer.lives[0]
    eventPlayer.startCamera(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + newBackward * 20 + Vector.UP * 2, null, null, false).getHitPosition(), eventPlayer.getEyePosition() + Vector.UP, 7.5)
    createProgressBarInWorldText(eventPlayer, (eventPlayer.lives[0] / eventPlayer.lives[1]) * 100, "", updateEveryTick(eventPlayer.getPosition()+ Vector.DOWN * 5), 1, Clip.NONE, Color.RED if eventPlayer.lives[0] == 1 else Color.GREEN if eventPlayer.lives[0] / eventPlayer.lives[1] >= 5/5 else rgb(100, 245, 45) if eventPlayer.lives[0] / eventPlayer.lives[1] >= 4/5 else Color.YELLOW if eventPlayer.lives[0] / eventPlayer.lives[1] >= 3/5 else rgb(216, 75, 9), Color.WHITE, ProgressWorldTextReeval.VISIBILITY_POSITION_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
    
rule "[Movement] Outline Updating":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned() == true
    @Condition eventPlayer.isDummy() == false

    eventPlayer.startForcingOutlineFor(getAllPlayers(), true , Color.GREEN, OutlineVisibility.ALWAYS)
    waitUntil(eventPlayer.lives[0] == 1 or eventPlayer.lives[0] / eventPlayer.lives[1] <= (4/5), 9999)
    eventPlayer.stopForcingOutlineFor(getAllPlayers())
    eventPlayer.startForcingOutlineFor(getAllPlayers(), true , Color.LIME_GREEN, OutlineVisibility.ALWAYS)
    waitUntil(eventPlayer.lives[0] == 1 or eventPlayer.lives[0] / eventPlayer.lives[1] <= (3/5), 9999)
    eventPlayer.stopForcingOutlineFor(getAllPlayers())
    eventPlayer.startForcingOutlineFor(getAllPlayers(), true , Color.YELLOW, OutlineVisibility.ALWAYS)
    waitUntil(eventPlayer.lives[0] == 1 or eventPlayer.lives[0] / eventPlayer.lives[1] <= (2/5), 9999)
    eventPlayer.stopForcingOutlineFor(getAllPlayers())
    eventPlayer.startForcingOutlineFor(getAllPlayers(), true , Color.ORANGE, OutlineVisibility.ALWAYS)
    waitUntil(eventPlayer.lives[0] == 1 or eventPlayer.lives[0] / eventPlayer.lives[1] <= (1/5), 9999)
    eventPlayer.stopForcingOutlineFor(getAllPlayers())
    eventPlayer.startForcingOutlineFor(getAllPlayers(), true , Color.RED, OutlineVisibility.ALWAYS)
    waitUntil(eventPlayer.lives[0] == 0, 9999)
    eventPlayer.stopForcingOutlineFor(getAllPlayers())

rule "[Movement] On Death":
    @Event playerDied
    
    if not eventPlayer.isDummy():
        eventPlayer.enableDeathSpectateAllPlayers()
        eventPlayer.enableDeathSpectateTargetHud()
        eventPlayer.disableRespawn()
        wait(false)
        if getDeadPlayers(Team.1) == getPlayers(Team.1):
            declareTeamVictory(Team.2)
    else:
        destroyDummy(eventPlayer.getTeam(), eventPlayer.getSlot())

rule "[Movement] 2D Movement":
    @Event eachPlayer
    @Condition (abs((z[1] - z[0]) * eventPlayer.getPosition().x - ((x[1] - x[0]) * eventPlayer.getPosition().z) + x[1] * z[0] - z[1] * x[0])) / distance(point2D[0], point2D[1]) > 0.05
    @Condition not isCharger
    
    eventPlayer.dest_tp_2d = point2D[0] + direction2D * dotProduct(direction2D, directionTowards(point2D[0], vect(eventPlayer.getPosition().x, false, eventPlayer.getPosition().z))) * distance(point2D[0], vect(eventPlayer.getPosition().x, false, eventPlayer.getPosition().z))
    eventPlayer.teleport(vect(eventPlayer.dest_tp_2d.x, eventPlayer.getPosition().y, eventPlayer.dest_tp_2d.z))
    wait()
    if RULE_CONDITION:
        goto RULE_START

rule "[Movement] Change Facing Direction":
    @Event eachPlayer
    @Condition abs(angleDifference(horizontalAngleOfDirection(worldVector(eventPlayer.getThrottle(), eventPlayer, Transform.ROTATION)), horizontalAngleOfDirection(eventPlayer.getFacingDirection()))) >= 180
    @Condition eventPlayer.isUsingAbility1() != true
    @Condition not isCharger

    eventPlayer.stopFacing()
    if eventPlayer.faceDirection == Vector.LEFT:
        eventPlayer.faceDirection = Vector.RIGHT
    elif eventPlayer.faceDirection == Vector.RIGHT:
        eventPlayer.faceDirection = Vector.LEFT
    eventPlayer.setFacing(eventPlayer.faceDirection, Relativity.TO_WORLD)
    wait()
    eventPlayer.startFacing(eventPlayer.faceDirection, 99999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    wait()

rule "[Movement] Use Dash":
    @Event eachPlayer
    @Condition dashEnabled
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1)

    if not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE):
        eventPlayer.allowButton(Button.ABILITY_1)
        eventPlayer.forceButtonPress(Button.ABILITY_1)
        eventPlayer.disallowButton(Button.ABILITY_1)

rule "[Movement] Use Deflect":
    @Event eachPlayer
    @Condition deflectEnabled
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)

    if not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE):
        eventPlayer.allowButton(Button.ABILITY_2)
        eventPlayer.forceButtonPress(Button.ABILITY_2)
        eventPlayer.disallowButton(Button.ABILITY_2)

rule "[Movement] Cancel Deflect Early":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.isUsingAbility2()

    wait(1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.forceButtonPress(Button.ABILITY_2)

rule "[Movement] Dash Effects":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.isUsingAbility1()

    while eventPlayer.isUsingAbility1():
        playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.GREEN, eventPlayer.getPosition(), 1)
        wait(0.032)

rule "[Movement] Ultimate Charge Loop":
    @Event eachPlayer
    @Hero genji
    @Condition ultimateEnabled
    @Condition eventPlayer.isAlive()
    @Condition roundUnderway

    chase(eventPlayer.ultCharge, 100, rate=3.333, ChaseReeval.NONE)
    while roundUnderway and eventPlayer.isAlive():
        waitUntil(eventPlayer.ultCharge == 100, 9999)
        eventPlayer.setUltCharge(eventPlayer.ultCharge)
        waitUntil(eventPlayer.ultCharge != 100, 9999)

rule "[Movement] Remove Ultimate Generation on Damage":
    @Event playerTookDamage
    @Hero genji
    @Condition ultimateEnabled
    @Condition eventDamage >= 100
    @Condition not eventPlayer.isUsingAbility1()
    @Condition eventPlayer.isAlive()
    @Condition roundUnderway

    stopChasingVariable(eventPlayer.ultCharge)
    eventPlayer.ultCharge = 0
    wait(2)
    chase(eventPlayer.ultCharge, 100, rate=3.333, ChaseReeval.NONE)

rule "[Movement] Ultimate Eliminate Enemies":
    @Event eachPlayer
    @Condition ultimateEnabled
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.getUltCharge() == 100 
    @Condition not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    @Condition eventPlayer.isAlive()
    @Condition roundUnderway
    @Condition not eventPlayer.hasStatusEffect(Status.STUNNED) and not eventPlayer.hasStatusEffect(Status.FROZEN) and not eventPlayer.hasStatusEffect(Status.HACKED)
    
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.TEAM_1, eventPlayer.getPosition(), 200)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.TEAM_1, eventPlayer.getPosition(), 200)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.GREEN, eventPlayer.getPosition(), 20)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.AQUA, eventPlayer.getPosition(), 25)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.GREEN, eventPlayer.getPosition(), 30)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.AQUA, eventPlayer.getPosition(), 35)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.GREEN, eventPlayer.getPosition(), 40)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.AQUA, eventPlayer.getPosition(), 45)
    eventPlayer.usingUltimateREAL = true
    stopChasingVariable(eventPlayer.ultCharge)
    eventPlayer.ultCharge = 0
    eventPlayer.setUltCharge(0)
    kill(getPlayers(Team.2), eventPlayer)
    wait(2)
    eventPlayer.usingUltimateREAL = false
    chase(eventPlayer.ultCharge, 100, rate=3.333, ChaseReeval.NONE)