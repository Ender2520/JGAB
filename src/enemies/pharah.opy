#!mainFile "../main.opy"

def Enemy_Slow_Rocket():
    @Name "Subroutine Enemy_Slow_Rocket"
    
    eventPlayer.botPosition = vect(random.randint(-18, 18), 22, 0)
    eventPlayer.startForcingPosition(eventPlayer.botPosition, true)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, eventPlayer.botPosition, 1.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.botEffect[0] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.ORB, Color.AQUA, eventPlayer.botPosition, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.botEffect[1] = getLastCreatedEntity()
    eventPlayer.startFacing(directionTowards(eventPlayer, sorted(getLivingPlayers(Team.1), lambda player: distance(player, eventPlayer))[0] + targetOffset), 9999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    while eventPlayer.getAmmo(0) > 0:
        wait(0.95 if chaosMode else random.uniform(2 - difficulty / 10, 5 - difficulty / 10))
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
        eventPlayer.botPosition = vect(random.randint(-18, 18), 22, 0)
    wait(1)
    destroyEffect(eventPlayer.botEffect[0])
    destroyEffect(eventPlayer.botEffect[1])
    wait(4)
    kill(eventPlayer, null)


def Enemy_Moderate_Rocket():
    @Name "Subroutine Enemy_Moderate_Rocket"
    
    eventPlayer.botPosition = vect(random.randint(-18, 18), 22, 0)
    eventPlayer.startForcingPosition(eventPlayer.botPosition, true)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, eventPlayer.botPosition, 1.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.botEffect[0] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.ORB, Color.AQUA, eventPlayer.botPosition + vect(-0.6, false, false), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.botEffect[1] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.ORB, Color.AQUA, eventPlayer.botPosition + vect(0.6, false, false), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.botEffect[2] = getLastCreatedEntity()
    eventPlayer.startFacing(directionTowards(eventPlayer, sorted(getLivingPlayers(Team.1), lambda player: distance(player, eventPlayer))[0] + targetOffset), 9999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    while eventPlayer.getAmmo(0) > 0:
        wait(0.95 if chaosMode else random.uniform(2 - difficulty / 10, 5 - difficulty / 10))
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
        eventPlayer.botPosition = vect(random.randint(-18, 18), 22, 0)
    wait(1)
    destroyEffect(eventPlayer.botEffect[0])
    destroyEffect(eventPlayer.botEffect[1])
    destroyEffect(eventPlayer.botEffect[2])
    wait(3)
    kill(eventPlayer, null)


def Enemy_Fast_Rocket():
    @Name "Subroutine Enemy_Fast_Rocket"
    
    eventPlayer.botPosition = vect(random.randint(-18, 18), 22, 0)
    eventPlayer.startForcingPosition(eventPlayer.botPosition, true)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, eventPlayer.botPosition, 1.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.botEffect[0] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.ORB, Color.AQUA, eventPlayer.botPosition + vect(-0.9, false, false), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.botEffect[1] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.ORB, Color.AQUA, eventPlayer.botPosition, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.botEffect[2] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.ORB, Color.AQUA, eventPlayer.botPosition + vect(0.9, false, false), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.botEffect[3] = getLastCreatedEntity()
    eventPlayer.startFacing(directionTowards(eventPlayer, sorted(getLivingPlayers(Team.1), lambda player: distance(player, eventPlayer))[0] + targetOffset), 9999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    while eventPlayer.getAmmo(0) > 0:
        wait(0.95 if chaosMode else random.uniform(2 - difficulty / 10, 5 - difficulty / 10))
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
        eventPlayer.botPosition = vect(random.randint(-18, 18), 22, 0)
    wait(1)
    destroyEffect(eventPlayer.botEffect[0])
    destroyEffect(eventPlayer.botEffect[1])
    destroyEffect(eventPlayer.botEffect[2])
    destroyEffect(eventPlayer.botEffect[3])
    wait(2)
    kill(eventPlayer, null)


def Enemy_Concussive_Blast():
    @Name "Subroutine Enemy_Concussive_Blast"
    
    eventPlayer.botPosition = vect(random.randint(-18, 18), 22, 0)
    eventPlayer.startForcingPosition(eventPlayer.botPosition, true)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, eventPlayer.botPosition, 1.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.botEffect[0] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.ORB, Color.WHITE, eventPlayer.botPosition, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.botEffect[1] = getLastCreatedEntity()
    eventPlayer.startFacing(directionTowards(eventPlayer, sorted(getLivingPlayers(Team.1), lambda player: distance(player, eventPlayer))[0] + targetOffset), 9999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    wait()
    eventPlayer.forceButtonPress(Button.ABILITY_2)
    wait(1)
    destroyEffect(eventPlayer.botEffect[0])
    destroyEffect(eventPlayer.botEffect[1])
    wait(6)
    kill(eventPlayer, null)