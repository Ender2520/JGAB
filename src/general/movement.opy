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
    eventPlayer.startForcingHero(Hero.GENJI)
    eventPlayer.faceDirection = Vector.RIGHT

rule "[Movement] On Spawn":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned() == true
    @Condition eventPlayer.isDummy() == false

    if roundUnderway:
        kill(eventPlayer, null)
    else:
        eventPlayer.livesColor = Color.GREEN
        eventPlayer.a1Choice = 1
        eventPlayer.a2Choice = 1
        eventPlayer.ultChoice = 1
        chase(eventPlayer.a1cooldownPATCH, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
        eventPlayer.setMaxHealth(9999)
        eventPlayer.setHealth(99999)
        if not chaosMode:
            eventPlayer.lives[0] = createWorkshopSetting(int[1:5], "Customization", "Player Health", 5, 2)
        else:
            eventPlayer.lives[0] = 1
        eventPlayer.lives[1] = eventPlayer.lives[0]
        eventPlayer.startCamera(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + newBackward * 20 + Vector.UP * 3, null, null, false).getHitPosition(), eventPlayer.getEyePosition() + Vector.UP * 3, 7.5)
        createProgressBarInWorldText(eventPlayer, (eventPlayer.lives[0] / eventPlayer.lives[1]) * 100, "", updateEveryTick(eventPlayer.getPosition()+ Vector.DOWN * 5), 1, Clip.NONE, eventPlayer.livesColor, Color.WHITE, ProgressWorldTextReeval.VISIBILITY_POSITION_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
        eventPlayer.teleport(vect(18,0,0))

rule "[Movement] Color Updating (Outline & Healthbar)":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned() == true
    @Condition eventPlayer.isDummy() == false
    @Condition eventPlayer.lives[0] != null

    wait(0.128)
    eventPlayer.startForcingOutlineFor(getAllPlayers(), true, eventPlayer.livesColor, OutlineVisibility.ALWAYS)
    if eventPlayer.lives[1] == 5:
        waitUntil(eventPlayer.lives[0] == 4, 9999)
        eventPlayer.livesColor = rgb(120,235,50)
        eventPlayer.startForcingOutlineFor(getAllPlayers(), true, Color.LIME_GREEN, OutlineVisibility.ALWAYS)
        waitUntil(eventPlayer.lives[0] == 3, 9999)
        eventPlayer.livesColor = Color.YELLOW
        eventPlayer.startForcingOutlineFor(getAllPlayers(), true, eventPlayer.livesColor, OutlineVisibility.ALWAYS)
        waitUntil(eventPlayer.lives[0] == 2, 9999)
        eventPlayer.livesColor = rgb(215,75,10)
        eventPlayer.startForcingOutlineFor(getAllPlayers(), true, Color.ORANGE, OutlineVisibility.ALWAYS)
        waitUntil(eventPlayer.lives[0] == 1, 9999)
        eventPlayer.livesColor = Color.RED
        eventPlayer.startForcingOutlineFor(getAllPlayers(), true, eventPlayer.livesColor, OutlineVisibility.ALWAYS)
    elif eventPlayer.lives[1] == 4:
        waitUntil(eventPlayer.lives[0] == 3, 9999)
        eventPlayer.livesColor = Color.YELLOW
        eventPlayer.startForcingOutlineFor(getAllPlayers(), true, eventPlayer.livesColor, OutlineVisibility.ALWAYS)
        waitUntil(eventPlayer.lives[0] == 2, 9999)
        eventPlayer.livesColor = rgb(215,75,10)
        eventPlayer.startForcingOutlineFor(getAllPlayers(), true, Color.ORANGE, OutlineVisibility.ALWAYS)
        waitUntil(eventPlayer.lives[0] == 1, 9999)
        eventPlayer.livesColor = Color.RED
        eventPlayer.startForcingOutlineFor(getAllPlayers(), true, eventPlayer.livesColor, OutlineVisibility.ALWAYS)
    elif eventPlayer.lives[1] == 3:
        waitUntil(eventPlayer.lives[0] == 2, 9999)
        eventPlayer.livesColor = Color.YELLOW
        eventPlayer.startForcingOutlineFor(getAllPlayers(), true, eventPlayer.livesColor, OutlineVisibility.ALWAYS)
        waitUntil(eventPlayer.lives[0] == 1, 9999)
        eventPlayer.livesColor = Color.RED
        eventPlayer.startForcingOutlineFor(getAllPlayers(), true, eventPlayer.livesColor, OutlineVisibility.ALWAYS)
    elif eventPlayer.lives[1] == 2:
        waitUntil(eventPlayer.lives[0] == 1, 9999)
        eventPlayer.livesColor = Color.RED
        eventPlayer.startForcingOutlineFor(getAllPlayers(), true, eventPlayer.livesColor, OutlineVisibility.ALWAYS)
    elif eventPlayer.lives[1] == 1:
        eventPlayer.livesColor = Color.RED
        eventPlayer.startForcingOutlineFor(getAllPlayers(), true, eventPlayer.livesColor, OutlineVisibility.ALWAYS)
    else:
        eventPlayer.livesColor = Color.WHITE
        eventPlayer.startForcingOutlineFor(getAllPlayers(), true, eventPlayer.livesColor, OutlineVisibility.ALWAYS)

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

rule "[Movement] A1 Use Dash":
    @Event eachPlayer
    @Condition ability1Enabled
    @Condition eventPlayer.a1Choice == 1
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1)
    @Condition eventPlayer.a1cooldownPATCH <= 0

    eventPlayer.allowButton(Button.ABILITY_1)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    eventPlayer.disallowButton(Button.ABILITY_1)

rule "[Movement] A1 Dash Effects":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.isUsingAbility1()

    eventPlayer.usingAbility1REAL = true
    while eventPlayer.isUsingAbility1():
        playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.GREEN, eventPlayer.getPosition(), 1)
        wait(0.032)
    eventPlayer.usingAbility1REAL = false
    eventPlayer.a1cooldownPATCH = 5
    
rule "[Movement] A1 Blink":
    @Event eachPlayer
    @Hero genji
    @Condition ability1Enabled
    @Condition roundUnderway
    @Condition eventPlayer.a1Choice == 4
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1)
    @Condition eventPlayer.a1cooldownPATCH <= 0
    #@Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) <= 0
    @Condition eventPlayer.usingAbility1REAL != true
    @Condition notCCd

    eventPlayer.usingAbility1REAL = true
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 1)
    playEffect(getAllPlayers(), DynamicEffect.REAPER_WRAITH_FORM_SOUND, Color.SKY_BLUE, eventPlayer.getPosition(), 100)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.SKY_BLUE, eventPlayer.getEyePosition(), 1)
    wait(0.1)
    eventPlayer.teleport(raycast(eventPlayer.getPosition(), eventPlayer.getPosition() + eventPlayer.getFacingDirection() * 10, null, getAllPlayers(), false).getHitPosition())
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.SKY_BLUE, eventPlayer.getEyePosition(), 1)
    playEffect(getAllPlayers(), DynamicEffect.DVA_MICRO_MISSILES_EXPLOSION_SOUND, Color.SKY_BLUE, eventPlayer.getPosition(), 100)
    eventPlayer.applyImpulse(Vector.UP, 3, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.clearStatusEffect(Status.INVINCIBLE)
    wait(0.4)
    eventPlayer.usingAbility1REAL = false
    eventPlayer.a1cooldownPATCH = 3
    #eventPlayer.setAbilityCooldown(Button.ABILITY_1, 3)

rule "[Movement] A1 Grapple Hook":  
    @Event eachPlayer
    @Hero genji
    @Condition ability1Enabled
    @Condition roundUnderway
    @Condition eventPlayer.a1Choice == 7
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1)
    @Condition eventPlayer.a1cooldownPATCH <= 0
    #@Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) <= 0
    @Condition eventPlayer.usingAbility1REAL != true
    @Condition notCCd

    eventPlayer.usingAbility1REAL = true
    eventPlayer.grappleTarget = sorted([p for p in getPlayers(eventPlayer.getTeam()) if p.isAlive() and distance(p, eventPlayer) > 0] , lambda x: distance(eventPlayer, x))
    if eventPlayer.grappleTarget == null:
        return
    eventPlayer.beamReach = 0
    eventPlayer.grappleStrength = 20
    createBeam(getAllPlayers(), Beam.GRAPPLE, updateEveryTick(eventPlayer.getPosition() + vect(0,1,0)), updateEveryTick((eventPlayer.grappleTarget.getPosition() + vect(0,1,0)) * eventPlayer.beamReach/100 + (eventPlayer.getPosition() + vect(0,1,0)) * (1-eventPlayer.beamReach/100)), Color.TEAM_1, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    eventPlayer.abilityEffects[4] = getLastCreatedEntity()
    chase(eventPlayer.beamReach, 100, duration=(distance(eventPlayer.getPosition() + vect(0,1,0), eventPlayer.grappleTarget.getPosition() + vect(0,1,0))) / 40, ChaseReeval.NONE)
    waitUntil(eventPlayer.beamReach == 100, 9999)
    wait(0.1)
    chase(eventPlayer.grappleStrength, 12, duration=2.5, ChaseReeval.NONE)
    eventPlayer.setGravity(50)
    while /*abs(eventPlayer.grappleTarget.getPosition().x - eventPlayer.getPosition().x) > 0.75) and */eventPlayer.grappleStrength > 12 and eventPlayer.grappleTarget.isAlive() and eventPlayer.isHoldingButton(Button.ABILITY_1) != true:
        eventPlayer.applyImpulse(Vector.UP, max(0,-0.25 * (eventPlayer.getPosition().y ** 2) + 0.5), Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
        eventPlayer.applyImpulse(directionTowards(eventPlayer.getPosition() + vect(0,1,0),eventPlayer.grappleTarget.getPosition() + vect(0,1,0)), min(eventPlayer.grappleStrength, 0.4 * ((grappleDistance(eventPlayer)) ** 2)), Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION_XYZ)
        wait(0.05)
    /* stiffer version
    eventPlayer.startForcingPosition(eventPlayer.activeGrapplePosition, true)
    chase(eventPlayer.activeGrapplePosition, eventPlayer.grappleTarget.getPosition(),rate=20,ChaseReeval.DESTINATION_AND_RATE)
    waitUntil(distance(eventPlayer.grappleTarget.getPosition(), eventPlayer.getPosition()) < 1, 3)
    eventPlayer.stopForcingPosition()
    */
    if eventPlayer.isHoldingButton(Button.ABILITY_1) == true:
        eventPlayer.applyImpulse(directionTowards(eventPlayer.getPosition() + vect(0,1,0),eventPlayer.grappleTarget.getPosition() + vect(0,1,0)), 7.5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION_XYZ)
    else:
        eventPlayer.applyImpulse(directionTowards(eventPlayer.getPosition() + vect(0,1,0),eventPlayer.grappleTarget.getPosition() + vect(0,1,0)), 2.5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION_XYZ)
    destroyEffect(eventPlayer.abilityEffects[4])
    eventPlayer.setGravity(100)
    eventPlayer.usingAbility1REAL = false
    eventPlayer.a1cooldownPATCH = 1.25
    #eventPlayer.setAbilityCooldown(Button.ABILITY_1, 3)

rule "[Movement] No Grapple Hook in Singleplayer":
    @Event eachPlayer
    @Condition abilityNames[(eventPlayer.a1Choice)] == "Grapple Hook"
    @Condition len(getAllPlayers()) == 1
    @Condition devOptions[2] != true

    waitUntil(distance(eventPlayer.getPosition() * vect(1,0,1), vect(12,0,0)) > 2 or abilityNames[(eventPlayer.a1Choice)] != "Grapple Hook", 3)
    if abilityNames[(eventPlayer.a1Choice)] == "Grapple Hook":
        if abilityNames[(eventPlayer.a1Choice)+3] == null:
            eventPlayer.a1Choice = 1
        else:
            eventPlayer.a1Choice += 3

rule "[Movement] A2 Use Deflect":
    @Event eachPlayer
    @Condition ability2Enabled
    @Condition eventPlayer.a2Choice == 1
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    @Condition eventPlayer.isAlive()

    if not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE):
        eventPlayer.allowButton(Button.ABILITY_2)
        eventPlayer.forceButtonPress(Button.ABILITY_2)
        eventPlayer.disallowButton(Button.ABILITY_2)

rule "[Movement] A2 Cancel Deflect Early*":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.isUsingAbility2()

    eventPlayer.usingAbility2REAL = true
    waitUntil(eventPlayer.isUsingAbility2() != true, 2)
    if eventPlayer.isUsingAbility2():
        eventPlayer.forceButtonPress(Button.ABILITY_2)
    eventPlayer.usingAbility2REAL = false

rule "[Movement] A2 Crystallize":
    @Event eachPlayer
    @Hero genji
    @Condition ability2Enabled
    @Condition roundUnderway
    @Condition eventPlayer.a2Choice == 4
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) <= 0
    @Condition eventPlayer.usingAbility2REAL != true
    @Condition eventPlayer.isAlive()
    @Condition notCCd

    eventPlayer.usingAbility2REAL = true
    eventPlayer.abilityDuration = 1
    playEffect(eventPlayer, DynamicEffect.BRIGITTE_REPAIR_PACK_ARMOR_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 100)
    createEffect(getAllPlayers(), Effect.BAPTISTE_IMMORTALITY_FIELD_PROTECTED, Color.WHITE, eventPlayer, 1, EffectReeval.VISIBILITY)
    eventPlayer.abilityEffects[0] = getLastCreatedEntity()
    createEffect(eventPlayer, Effect.BAPTISTE_IMMORTALITY_FIELD_PROTECTED_SOUND, Color.WHITE, eventPlayer.getPosition(), 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.abilityEffects[1] = getLastCreatedEntity()
    eventPlayer.setKnockbackReceived(200)
    eventPlayer.abilityCharge[0] = 2
    chase(eventPlayer.abilityDuration, 0, duration=10, ChaseReeval.DESTINATION_AND_DURATION)
    waitUntil(eventPlayer.abilityCharge[0] == 0 or eventPlayer.abilityDuration == 0, 9999)
    stopChasingVariable(eventPlayer.abilityDuration)
    playEffect(eventPlayer, DynamicEffect.ANA_BIOTIC_GRENADE_EXPLOSION_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 200)
    destroyEffect(eventPlayer.abilityEffects[0])
    destroyEffect(eventPlayer.abilityEffects[1])
    wait(0.4)
    eventPlayer.usingAbility2REAL = false
    eventPlayer.setKnockbackReceived(100)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 10)

rule "[Movement] A2 Flash Step":
    @Event eachPlayer
    @Hero genji
    @Condition ability2Enabled
    @Condition roundUnderway
    @Condition eventPlayer.a2Choice == 7
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) <= 0
    @Condition eventPlayer.usingAbility2REAL != true
    @Condition eventPlayer.isAlive()
    @Condition notCCd

    eventPlayer.usingAbility2REAL = true
    playEffect(eventPlayer, DynamicEffect.MOIRA_FADE_DISAPPEAR_SOUND, Color.SKY_BLUE, eventPlayer.getPosition(), 100)
    playEffect(eventPlayer, DynamicEffect.GOOD_EXPLOSION, Color.WHITE, eventPlayer.getPosition(), 2)
    createEffect(eventPlayer, Effect.SMOKE_SOUND, Color.WHITE, eventPlayer, 100, EffectReeval.VISIBILITY)
    eventPlayer.abilityEffects[0] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.CLOUD, Color.WHITE, eventPlayer.getPosition(), 1, EffectReeval.VISIBILITY)
    eventPlayer.abilityEffects[1] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.CLOUD, Color.WHITE, eventPlayer.getPosition(), 1, EffectReeval.VISIBILITY)
    eventPlayer.abilityEffects[2] = getLastCreatedEntity()
    createEffect(eventPlayer, Effect.BAPTISTE_IMMORTALITY_FIELD_PROTECTED_SOUND, Color.WHITE, eventPlayer.getPosition(), 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.abilityEffects[3] = getLastCreatedEntity()
    eventPlayer.setStatusEffect(eventPlayer, Status.PHASED_OUT, 0.5)
    eventPlayer.setInvisibility(Invis.ALL)
    wait(0.5)
    eventPlayer.setInvisibility(Invis.NONE)
    destroyEffect(eventPlayer.abilityEffects[0])
    destroyEffect(eventPlayer.abilityEffects[1])
    destroyEffect(eventPlayer.abilityEffects[2])
    destroyEffect(eventPlayer.abilityEffects[3])
    playEffect(getAllPlayers(), DynamicEffect.MOIRA_FADE_REAPPEAR_SOUND, Color.SKY_BLUE, eventPlayer.getPosition(), 100)
    wait(0.4)
    eventPlayer.usingAbility2REAL = false
    eventPlayer.setKnockbackReceived(100)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 4)

rule "[Movement] Ult Eradication":
    @Event eachPlayer
    @Condition ultimateEnabled
    @Condition roundUnderway
    @Condition eventPlayer.ultChoice == 1
    @Condition eventPlayer.ultCharge == 100
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.getUltCharge() == 100 
    @Condition eventPlayer.isAlive()
    @Condition notCCd

    playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 200)
    playEffect(getAllPlayers(), DynamicEffect.BASTION_TANK_CANNON_EXPLOSION_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 200)
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
    startChargingUltimate

rule "[Movement] Ult Slo-Mo":
    @Event eachPlayer
    @Condition ultimateEnabled
    @Condition roundUnderway
    @Condition eventPlayer.ultChoice == 4
    @Condition eventPlayer.ultCharge == 100
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.getUltCharge() == 100 
    @Condition eventPlayer.isAlive()
    @Condition notCCd
    
    if len([p for p in getPlayers(eventPlayer.getTeam()) if p.usingUltimateREAL == true and p.ultChoice == 4 and p != eventPlayer]) > 0:
        smallMessage(eventPlayer, "Slow Motion already Active")
        playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 100)
    else:
        eventPlayer.usingUltimateREAL = true
        stopChasingVariable(eventPlayer.ultCharge)
        eventPlayer.ultCharge = 0
        eventPlayer.setUltCharge(0)
        createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, eventPlayer.getPosition(), eventPlayer.effectRadius, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
        eventPlayer.abilityEffects[2] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.SPHERE, Color.SKY_BLUE, eventPlayer.getPosition(), eventPlayer.effectRadius - 2, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
        eventPlayer.abilityEffects[3] = getLastCreatedEntity()
        chase(eventPlayer.effectRadius, 100, duration=1, ChaseReeval.NONE)
        playEffect(getAllPlayers(), DynamicEffect.SOMBRA_EMP_EXPLOSION_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 50)
        playEffect(getAllPlayers(), DynamicEffect.TRACER_RECALL_DISAPPEAR_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)
        setSlowMotion(25)
        wait(2)
        chase(eventPlayer.effectRadius, 0, duration=0.5, ChaseReeval.NONE)
        playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_MINEFIELD_EXPLOSION_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 50)
        playEffect(getAllPlayers(), DynamicEffect.TRACER_RECALL_REAPPEAR_SOUND, Color.WHITE, eventPlayer.getPosition(), 100)
        setSlowMotion(100)
        eventPlayer.usingUltimateREAL = false
        startChargingUltimate

rule "[Movement] Ult 1-UP":
    @Event eachPlayer
    @Condition ultimateEnabled
    @Condition roundUnderway
    @Condition eventPlayer.ultChoice == 7
    @Condition eventPlayer.ultCharge == 100
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isAlive()
    @Condition notCCd
    
    if not eventPlayer.lives[0] < eventPlayer.lives[1]:
        smallMessage(eventPlayer, "CANNOT USE ULTIMATE WHEN AT FULL HEALTH")
    else:
        eventPlayer.usingUltimateREAL = true
        stopChasingVariable(eventPlayer.ultCharge)
        eventPlayer.ultCharge = 0
        eventPlayer.effectRadius = 0
        eventPlayer.setUltCharge(0)
        createEffect(getAllPlayers(), Effect.SPHERE, Color.GREEN, eventPlayer.getPosition(), eventPlayer.effectRadius, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
        eventPlayer.abilityEffects[6] = getLastCreatedEntity()
        chase(eventPlayer.effectRadius, 5, duration=1, ChaseReeval.NONE)
        playEffect(getAllPlayers(), DynamicEffect.ANA_BIOTIC_GRENADE_INCREASED_HEALING_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 100)
        wait(1)
        eventPlayer.lives[0] += 1
        playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.TEAM_1, eventPlayer.getPosition(), 200)
        destroyEffect(eventPlayer.abilityEffects[6])
        eventPlayer.usingUltimateREAL = false
        startChargingUltimate

rule "[Movement] Ultimate Charge Loop":
    @Event eachPlayer
    @Hero genji
    @Condition ultimateEnabled
    @Condition eventPlayer.isAlive()
    @Condition roundUnderway

    startChargingUltimate
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
    @Condition (victim.usingAbility2REAL == true and victim.a2Choice == 4) != true
    @Condition eventPlayer.isAlive()
    @Condition roundUnderway

    stopChasingVariable(eventPlayer.ultCharge)
    eventPlayer.ultCharge = 0
    eventPlayer.setUltCharge(eventPlayer.ultCharge)
    wait(3)
    startChargingUltimate

rule "[Movement] Switch Ability Selection":
    @Event eachPlayer
    @Condition roundUnderway != true
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition distance(eventPlayer.getPosition() * vect(1,0,1), vect(12,0,0)) <= 2 or distance(eventPlayer.getPosition() * vect(1,0,1), vect(4,0,0)) <= 2 or distance(eventPlayer.getPosition() * vect(1,0,1), vect(-4,0,0)) <= 2

    if distance(eventPlayer.getPosition() * vect(1,0,1), vect(12,0,0)) <= 2 and ability1Enabled:
        if abilityNames[(eventPlayer.a1Choice) + 3] == "Grapple Hook" and len(getAllPlayers()) == 1:
            playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 50)
            playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.RED, vect(12,0,0), 5)
            smallMessage(eventPlayer, "GRAPPLE HOOK CANNOT BE USED IN SINGLEPLAYER")
        else:
            playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 50)
            playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.WHITE, vect(12,0,0), 5)
        if abilityNames[(eventPlayer.a1Choice)+3] == null:
            eventPlayer.a1Choice = 1
        else:
            eventPlayer.a1Choice += 3
    elif distance(eventPlayer.getPosition() * vect(1,0,1), vect(4,0,0)) <= 2 and ability2Enabled:
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)
        if abilityNames[(eventPlayer.a2Choice+1)+3] == null:
            eventPlayer.a2Choice = 1
        else:
            eventPlayer.a2Choice += 3 
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 50)
        playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.WHITE, vect(4,0,0), 5)
    elif distance(eventPlayer.getPosition() * vect(1,0,1), vect(-4,0,0)) <= 2 and ultimateEnabled:
        if abilityNames[(eventPlayer.ultChoice+2)+3] == null:
            eventPlayer.ultChoice = 1
        else:
            eventPlayer.ultChoice += 3 
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 50)
        playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.WHITE, vect(-4,0,0), 5)