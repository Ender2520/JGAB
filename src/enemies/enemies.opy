#!mainFile "../main.opy"

rule "[Enemies] Initialize":
    @Event eachPlayer
    @Condition eventPlayer.isDummy() == true
    @Condition eventPlayer.hasSpawned() == true
    
    eventPlayer.disableEnvironmentCollision(true)
    eventPlayer.setInvisibility(Invis.ALL)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.setHealingDealt(0)
    eventPlayer.setKnockbackDealt(0)
    wait(0.2)
    if eventPlayer.getCurrentHero() == Hero.PHARAH:
        if wuPhase:
            eventPlayer.enemyType = random.randint(0,2)
        else:
            eventPlayer.enemyType = random.randint(0,3)
        eventPlayer.setMaxAmmo(0,chaos(10) (3+((3/5)*difficulty)))
        eventPlayer.setAmmo(0,chaos(10) (3+((3/5)*difficulty)))
        if eventPlayer.enemyType == 0:
            eventPlayer.startForcingName("Tier I Rocketeer")
            eventPlayer.setProjectileSpeed(chaos(45) 20 + (round(difficulty/2.01) * 2.5))
            Enemy_Slow_Rocket()
        elif eventPlayer.enemyType == 1:
            eventPlayer.startForcingName("Tier II Rocketeer")
            eventPlayer.setProjectileSpeed(chaos(55) 30 + (round(difficulty/2.01) * 2.5))
            Enemy_Moderate_Rocket()
        elif eventPlayer.enemyType == 2:
            eventPlayer.startForcingName("Tier III Rocketeer")
            eventPlayer.setProjectileSpeed(chaos(65) 40 + (round(difficulty/2.01) * 2.5))
            Enemy_Fast_Rocket()
        elif eventPlayer.enemyType == 3:
            eventPlayer.startForcingName("Displacer")
            eventPlayer.setProjectileSpeed(chaos(35) 14 + (round(difficulty/2.01)))
            eventPlayer.setKnockbackDealt(100)
            Enemy_Concussive_Blast()
    elif eventPlayer.getCurrentHero() == Hero.ORISA:
        if wuPhase:
            eventPlayer.enemyType = random.randint(0,1)
        else:
            eventPlayer.enemyType = random.randint(0,2)
        eventPlayer.setMaxAmmo(0,chaos(5) 3)
        eventPlayer.setAmmo(0,chaos(5) 3)
        eventPlayer.setDamageDealt(1000)
        if eventPlayer.enemyType == 0:
            eventPlayer.startForcingName("Tier I Gunner")
            eventPlayer.setProjectileSpeed(chaos(10) 5 + (round(difficulty/2.01) * 0.5))
            Enemy_Moderate_Bullet()
        elif eventPlayer.enemyType == 1:
            eventPlayer.startForcingName("Tier II Gunner")
            eventPlayer.setProjectileSpeed(chaos(15) 10 + (round(difficulty/2.01) * 0.5))
            Enemy_Fast_Bullet()
        elif eventPlayer.enemyType == 2:
            eventPlayer.startForcingName("Halter")
            eventPlayer.setProjectileSpeed(chaos(60) 35 + (round(difficulty/2.01) * 3))
            Enemy_Halt()
    elif eventPlayer.getCurrentHero() == Hero.MEI:
        eventPlayer.enemyType = 0
        eventPlayer.setMaxAmmo(0,chaos(72) 48)
        eventPlayer.setAmmo(0,chaos(72) 48)
        eventPlayer.setDamageDealt(1)
        #
        eventPlayer.startForcingName("Freezer")
        Enemy_Freeze()
    elif eventPlayer.getCurrentHero() == Hero.REINHARDT:
        eventPlayer.disableEnvironmentCollision(false)
        if eventPlayer.enemyType == 0:
            eventPlayer.setDamageDealt(1)
            eventPlayer.startForcingName("Groundbreaker")
            Enemy_Groundbreaker()
        elif eventPlayer.enemyType == 1:
            eventPlayer.setDamageDealt(1)
            eventPlayer.startForcingName("Charger")
            Enemy_Charge()
    
rule "[Enemies] Dealt Damage":
    @Event playerTookDamage
    @Condition attacker != victim
    @Condition eventDamage >= 100
    
    if not victim.isDummy():
        if not victim.isUsingAbility1():
            playEffect(getAllPlayers(), DynamicEffect.DEBUFF_IMPACT_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 200)
            playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.RED, eventPlayer.getPosition(), 1)
            heal(victim, null, eventDamage)
            victim.lives[0] -= 1
            if victim.lives[0] == 0:
                kill(eventPlayer, null)
        else:
            if victim.ultCharge != 0 and victim.ultCharge != 100:
                playEffect(getAllPlayers(), DynamicEffect.BUFF_IMPACT_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 200)
                playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.WHITE, eventPlayer.getPosition(), 1)
                victim.ultCharge += 2

rule "[Enemies] Reinhardt Charge Insta-Kill":
    @Event eachPlayer
    @Hero genji
    @Condition distance(eventPlayer, [p for p in getPlayersOnHero(Hero.REINHARDT, Team.2) if p.enemyType == 1].getPosition() + vect(0,1,0)) <= 2.1
    @Condition distance(eventPlayer, [p for p in getPlayersOnHero(Hero.REINHARDT, Team.2) if p.enemyType == 1].getPosition() + vect(0,1,0)) > 0
    @Condition roundUnderway

    playEffect(getAllPlayers(), DynamicEffect.DEBUFF_IMPACT_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 200)
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.ORANGE, eventPlayer.getPosition(), 2)
    kill(eventPlayer, null)

rule "[Enemies] Random Targeting Offset":
    @Event global
    @Condition roundUnderway
    
    targetOffset = vect(false,false,false)
    chase(targetOffset, vect(toX,toY,0), rate=9999, ChaseReeval.DESTINATION_AND_RATE)
    if chaosMode:
        while getMatchTime() < 9999: # MAYBE BELL CURVE
            toX = 0 + random.uniform(-0.1, 0.1) + random.uniform(-0.1, 0.1) + random.uniform(-0.1, 0.1) + random.uniform(-0.1, 0.1) + random.uniform(-0.1, 0.1) + random.uniform(-0.1, 0.1) + random.uniform(-0.1, 0.1) + random.uniform(-0.1, 0.1) + random.uniform(-0.1, 0.1) + random.uniform(-0.1, 0.1)
            toY = 0 + random.uniform(-0.05, 0.05) + random.uniform(-0.05, 0.05) + random.uniform(-0.05, 0.05) + random.uniform(-0.05, 0.05) + random.uniform(-0.05, 0.05) + random.uniform(-0.05, 0.05) + random.uniform(-0.05, 0.05) + random.uniform(-0.05, 0.05) + random.uniform(-0.05, 0.05) + random.uniform(-0.05, 0.05)
            wait(1)
    else:
        while getMatchTime() < 9999: # MAYBE BELL CURVE
            toX = 0 + random.uniform(-2.2 + difficulty * 0.2, 2.2 - difficulty * 0.2) + random.uniform(-2.2 + difficulty * 0.2, 2.2 - difficulty * 0.2) + random.uniform(-2.2 + difficulty * 0.2, 2.2 - difficulty * 0.2) + random.uniform(-2.2 + difficulty * 0.2, 2.2 - difficulty * 0.2) + random.uniform(-2.2 + difficulty * 0.2, 2.2 - difficulty * 0.2)
            toY = 0 + random.uniform(-0.5 + difficulty * 0.05, 0.55 - difficulty * 0.05) + random.uniform(-0.5 + difficulty * 0.05, 0.55 - difficulty * 0.05) + random.uniform(-0.5 + difficulty * 0.05, 0.55 - difficulty * 0.05) + random.uniform(-0.5 + difficulty * 0.05, 0.55 - difficulty * 0.05)
            wait(1)