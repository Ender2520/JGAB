#!mainFile "../main.opy"

def Enemy_Moderate_Bullet():
    eventPlayer.botPosition = vect(random.choice([-20.2,20.2]), random.uniform(0.5,2.5), 0)
    eventPlayer.startForcingPosition(eventPlayer.botPosition, true)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.GREEN, eventPlayer.botPosition + vect(false,1.25,false), 1.1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.botEffect[0] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.ORB, Color.LIME_GREEN, eventPlayer.botPosition + vect(false,1.25,false), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.botEffect[1] = getLastCreatedEntity()
    eventPlayer.startFacing(directionTowards(eventPlayer, sorted(getLivingPlayers(Team.1), lambda player: distance(player, eventPlayer))[0] + targetOffset), 9999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    wait(0.5)
    while eventPlayer.getAmmo(0) > 0:
        wait(chaos(0.25) random.uniform(1.1 - difficulty/10,2 - difficulty/10))
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    wait(1)
    destroyEffect(eventPlayer.botEffect[0])
    destroyEffect(eventPlayer.botEffect[1])
    wait(6)
    kill(eventPlayer, null)

def Enemy_Fast_Bullet():
    eventPlayer.botPosition = vect(random.choice([-20.2,20.2]), random.uniform(0.5,2.5), 0)
    eventPlayer.startForcingPosition(eventPlayer.botPosition, true)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.GREEN, eventPlayer.botPosition + vect(false,1.25,false), 1.1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.botEffect[0] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.ORB, Color.LIME_GREEN, eventPlayer.botPosition + vect(false,1.25-0.525,false), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.botEffect[1] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.ORB, Color.LIME_GREEN, eventPlayer.botPosition + vect(false,1.25+0.525,false), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.botEffect[2] = getLastCreatedEntity()
    eventPlayer.startFacing(directionTowards(eventPlayer, sorted(getLivingPlayers(Team.1), lambda player: distance(player, eventPlayer))[0] + targetOffset), 9999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    wait(0.5)
    while eventPlayer.getAmmo(0) > 0:
        wait(chaos(0.25) random.uniform(1.1 - difficulty/10,2 - difficulty/10))
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    wait(1)
    destroyEffect(eventPlayer.botEffect[0])
    destroyEffect(eventPlayer.botEffect[1])
    destroyEffect(eventPlayer.botEffect[2])
    wait(5)
    kill(eventPlayer, null)

def Enemy_Halt():
    eventPlayer.botPosition = vect(random.choice([-20.2,20.2]), random.uniform(0.5,2), 0)
    eventPlayer.startForcingPosition(eventPlayer.botPosition, true)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.GREEN, eventPlayer.botPosition + vect(false,1.25,false), 1.1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.botEffect[0] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.ORB, Color.WHITE, eventPlayer.botPosition + vect(false,1.25,false), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.botEffect[1] = getLastCreatedEntity()
    eventPlayer.startFacing(directionTowards(eventPlayer, sorted(getLivingPlayers(Team.1), lambda player: distance(player, eventPlayer))[0] + targetOffset), 9999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    wait()
    eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)
    wait(chaos((distance(eventPlayer, sorted(getLivingPlayers(Team.1), lambda player: distance(player, eventPlayer))[0] + targetOffset) / 15)) random.uniform(-1.1 + difficulty/10,1.1 - difficulty/10) + (distance(eventPlayer, sorted(getLivingPlayers(Team.1), lambda player: distance(player, eventPlayer))[0] + targetOffset) / (0.25*(35 + (round(difficulty/2.01) * 3)))))
    eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)
    wait(1)
    kill(eventPlayer, null)
    destroyEffect(eventPlayer.botEffect[0])
    destroyEffect(eventPlayer.botEffect[1])